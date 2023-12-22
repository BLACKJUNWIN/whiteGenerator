package com.black.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.black.common.entity.ApiCode;
import com.black.common.enums.EnumPathCategory;
import com.black.entity.TemplateFile;
import com.black.entity.TemplatePath;
import com.black.mapper.TemplateFileMapper;
import com.black.mapper.TemplatePathMapper;
import com.black.model.TableData;
import com.black.service.IGeneratorService;
import com.black.utils.FileUtil;
import com.black.utils.SqlUtil;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class GeneratorServiceImpl implements IGeneratorService {

    @Autowired
    private TemplatePathMapper templatePathMapper;

    @Autowired
    private TemplateFileMapper templateFileMapper;

    @Override
    public ApiCode testSql(Map<String, String> map) {
        String url = map.get("url");//地址
        String driver = map.get("drive");//驱动
        String user = map.get("user");//用户名
        String password = map.get("password");//密码
        //开始尝试连接
        Connection conn = null;
        try {
            try {
                Class.forName(driver);
            } catch (ClassNotFoundException ex) {
                return ApiCode.ERROR_DRIVER;
            }
            conn = DriverManager.getConnection(url, user, password);
            conn.close();
            return ApiCode.SUCCESS;

        } catch (SQLException ex1) {
            return ApiCode.ERROR_LOGIN;
        }
    }

    //获取sql数据
    @Override
    public List<Map<String, Object>> getSqlData(Map<String, String> map) {
        try {
            String sql = "SELECT `table_name` `tableName`, `table_comment` `tableComment` FROM information_schema.tables WHERE `table_schema`=DATABASE()";
            //获取表数据
            ResultSet resultSet = SqlUtil.executeSql(map, sql);
            List<Map<String, Object>> baseList = new ArrayList<>();
            while (resultSet.next()) {
                //对应表名
                String tableName = resultSet.getString("tableName");
                //对应表注释
                String tableComment = resultSet.getString("tableComment");
                Map<String, Object> tableMap = new HashMap<>();
                //遍历表去查询表对应表单
                String sql2 = "SELECT `column_name` `column`,`column_comment` `comment`,`data_type` `type`,character_maximum_length charLength FROM   `information_schema`.`columns` WHERE  `table_schema`=DATABASE() AND `table_name`=\'" + tableName + "\' ORDER BY `ordinal_position`;";
                ResultSet resultSet2 = SqlUtil.executeSql(map, sql2);
                //所有表参数集合
                List<Map<String, Object>> list = new ArrayList<>();
                while (resultSet2.next()) {//获取每个表下字段
                    ResultSetMetaData resultSetMetaData2 = resultSet2.getMetaData();
                    int count = resultSetMetaData2.getColumnCount();// 获取列的数量
                    HashMap<String, Object> mapItem = new HashMap<>();
                    for (int j = 1; j <= count; j++) {//获取每个字段属性
                        String key = resultSetMetaData2.getColumnLabel(j);
                        String value = resultSet2.getString(j);
                        if(key.equals("comment")){
                            String[] split = value.split(";");
                            if(split.length>1){//存在枚举
                                List<Map<String,Object>> enumList=new ArrayList<>();
                                String enums = split[1];
                                String[] enumArr = enums.split(",");
                                for (String enumItem : enumArr) {
                                    String[] keyValue = enumItem.split(":");
                                    Map<String,Object> enumItemMap=new HashMap<>();
                                    enumItemMap.put("name",keyValue[0]);
                                    enumItemMap.put("value",keyValue[1]);
                                    enumList.add(enumItemMap);
                                }
                                mapItem.put("enumList", enumList);
                                mapItem.put("isEnum", true);
                                mapItem.put("canEdit", true);
                            }else{//不存在枚举
                                mapItem.put("enumList", new ArrayList<>());
                                mapItem.put("canEnum", false);
                                mapItem.put("canEdit", false);
                            }
                            value=split[0];
                        }
                        mapItem.put(key, value);
                    }
                    mapItem.put("canSelect", false);
                    list.add(mapItem);
                }
                //格式化并保存表单数据
                tableMap.put("name", tableName);
                tableMap.put("comment", tableComment);
                tableMap.put("data", list);
                //把对应表添加到集合中
                baseList.add(tableMap);
            }
            return baseList;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    //修改列注释
    @Override
    public boolean modifyColumComment(Map<String, String> map, Map<String, Object> dataMap) {
        try {
            String columnType = dataMap.get("columnType")+"";
            if(columnType.contains("char")){
                columnType+="("+dataMap.get("charLength")+")";
            }
            StringBuilder comment = new StringBuilder(dataMap.get("comment")+"");
            List<Map<String,Object>> enumList=(List<Map<String,Object>>) dataMap.get("enumList");
            if(Boolean.parseBoolean(dataMap.get("canEnum") + "")){
                if (enumList.size()>0){
                    comment.append(";");
                    for (Map<String, Object> enumItem : enumList) {
                        comment.append(enumItem.get("name")).append(":").append(enumItem.get("value")).append(",");
                    }
                    comment.delete(comment.length()-1,comment.length());
                }
            }
            String sql = "alter table `" +dataMap.get("name")+"` modify column `"+ dataMap.get("column")+"` "+columnType+" comment '" +comment+"'";
            System.out.println(sql);
            SqlUtil.updateSql(map, sql);
            return true;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    //修改表注释
    @Override
    public boolean modifyTableComment(Map<String, String> map, Map<String, Object> dataMap) {
        try {
            String sql = "alter table `"+dataMap.get("name") + "` comment '" + dataMap.get("comment") + "'";
            SqlUtil.updateSql(map, sql);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    @Override
    public boolean generatorCode(List<TableData> generatorList) {
        PageHelper.startPage(1,1000);
        //获取需要动态生成的模板文件
        List<TemplatePath> templatePathList = generatorDynamic(generatorList);
        templatePathList.forEach(templatePath -> {//遍历自动生成文件
            generatorList.forEach(tableData -> {//遍历需要自动生成的数据
                FileUtil.generatorFile(templatePath,tableData);
            });
        });
        return false;
    }

    @Override
    public List<TemplatePath> generatorRealStatic(List<TableData> generatorList) {
        return templatePathMapper.selectList(new LambdaQueryWrapper<TemplatePath>().eq(TemplatePath::getCategory, EnumPathCategory.纯静态));
    }

    @Override
    public List<TemplatePath> generatorStatic(List<TableData> generatorList) {
        List<TemplatePath> staticList = templatePathMapper.selectList(new LambdaQueryWrapper<TemplatePath>().eq(TemplatePath::getCategory, EnumPathCategory.静态生成));

        return staticList;
    }

    @Override
    public List<TemplatePath> generatorDynamic(List<TableData> generatorList) {
        PageHelper.startPage(1,1000);
        List<TemplatePath> dynamicList = templatePathMapper.selectList(new LambdaQueryWrapper<TemplatePath>().eq(TemplatePath::getCategory, EnumPathCategory.动态生成));
        for (TemplatePath templatePath : dynamicList) {
            TemplateFile templateFile = new TemplateFile();
            templateFile.setTemplatePathId(templatePath.getId());
            PageHelper.startPage(1,1000);
            List<TemplateFile> fileList = templateFileMapper.selectAll(templateFile);
            templatePath.setPath(templatePath.getPath()+"\\"+fileList.get(0).getFileName());
        }
        return dynamicList;
    }

    @Override
    public List<TemplatePath> generatorBefore(List<TableData> generatorList) {
        return null;
    }

    @Override
    public List<TemplatePath> generatorBack(List<TableData> generatorList) {
        return null;
    }


}
