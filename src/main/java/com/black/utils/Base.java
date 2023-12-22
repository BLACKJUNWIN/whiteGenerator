package com.black.utils;

import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateExceptionHandler;
import freemarker.template.TemplateModelException;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.*;
import java.util.*;

/**
 * 公共数据类
 */
public class Base {
    private static final String ProjectPath = System.getProperty("user.dir");
    private static Configuration config = null;

    /**
     * 获取项目路径
     * @return 项目路径
     */
    public static String getProjectPath() {
        return ProjectPath;
    }

    /**
     * 获取输出路径
     * @return 输出路径
     */
    public static String getOutPath() {
        String projectName="test";
        Map<String, Object> paramMap = getParamMap();
        String specifyName= paramMap.get("projectName") + "";
        if(!specifyName.equals("")){
            projectName=specifyName;
        }

        return ProjectPath + "\\out\\"+projectName;
    }

    /**
     * 获取静态资源路径
     * @return 静态资源路径
     */
    public static String getResourcePath() {
        return ProjectPath + "\\src\\main\\resources";
    }

    /**
     * 获取模板路径
     * @return 模板路径
     */
    public static String getTemplates() {
        return getResourcePath() + "\\templates";
    }

    /**
     * 获取Configuration对象
     */
    public Configuration getConfiguration() {
        if (config == null) {
            config = new Configuration(Configuration.VERSION_2_3_30);
            //设置模版放置路径，这里表示在classpath下的templates文件夹下
            config.setClassForTemplateLoading(this.getClass(), "/templates/");
            // 设置编码
            config.setEncoding(Locale.getDefault(), "UTF-8");
            // 设置对象的包装器
            config.setObjectWrapper(new DefaultObjectWrapper());
            // 设置异常处理器，否则没有的属性将会报错
            config.setTemplateExceptionHandler(TemplateExceptionHandler.IGNORE_HANDLER);
            //设置全局变量
            try {
                config.setSharedVariable("admin", "BlackJun");
            } catch (TemplateModelException e) {
                throw new RuntimeException(e);
            }
        }
        return config;
    }

    /**
     * 获取param.properties参数数据
     * @return param.properties参数数据
     */
    private static Map<String, Object> getThrowParamMap() throws IOException {
        //获取properties数据
        InputStream inputStream = null;
        Properties properties;
        try {
           inputStream = Files.newInputStream(Paths.get(getResourcePath() + "\\param.properties"));
            //实例化Properties类
            properties = new Properties();
                properties.load(inputStream);
        } finally {//最终都需要释放流
            if(inputStream!=null){
                inputStream.close();
            }
        }
        //强转为map
        return new HashMap<String, Object>((Map) properties);
    }
    public static Map<String, Object> getParamMap(){
        try {
            return getThrowParamMap();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }


//    /**
//     * 通过数据库表,确定文件输出路径
//     *
//     * @param FileItem 文件对象
//     * @param tableName 表名
//     */
//    public static void changeAutoFileOut(GeneratorFile FileItem, String tableName) {
//        String projectPath = getProjectPath();
//        String relativePath = FileItem.getOutFilePath().replace(projectPath, "");
//        String relativeOutPath = relativePath.replaceAll(FileItem.getName(), ContentUtil.downFirstName(tableName));
//        FileItem.setOutFilePath(projectPath + relativeOutPath);
//    }

    /**
     * 通过数据库表获取表单详细数据
     *
     * @return 所有表参数详情
     */
    public static List<Map<String, Object>> getMysqlData() {
        try {
            Map<String, Object> paramMap = getParamMap();
            //绑定驱动
            Class.forName(paramMap.get("drive") + "");
            //绑定数据库对象 Connection
            Connection connection = DriverManager.getConnection(paramMap.get("url") + "", paramMap.get("root") + "", paramMap.get("password") + "");
            String sql;
            String specifyTables = paramMap.get("tables") + "";
            if (specifyTables.equals("")) {//如何为空获取全部表
                sql = "SELECT `table_name` `tableName`, `table_comment` `tableComment` FROM information_schema.tables WHERE `table_schema`=DATABASE()";
            } else {
                sql = "SELECT `table_name` `tableName`, `table_comment` `tableComment` FROM information_schema.tables WHERE `table_schema`=DATABASE() and `table_name` in `" + specifyTables + "`";
            }
            //获取表数据
            ResultSet resultSet = connection.createStatement().executeQuery(sql);
            List<Map<String, Object>> baseList = new ArrayList<>();
            while (resultSet.next()) {
                //对应表名
                String tableName = resultSet.getString("tableName");
                //对应表注释
                String tableComment = resultSet.getString("tableComment");
                Map<String, Object> map = new HashMap<>();
                //遍历表去查询表对应表单
                String sql2 = "SELECT `column_name` `column`,`column_comment` `comment`,`data_type` `type`,`column_default` isFilter,`is_nullable` `required`FROM   `information_schema`.`columns` WHERE  `table_schema`=DATABASE() AND `table_name`=\'" + tableName + "\' ORDER BY `ordinal_position`;";
                ResultSet resultSet2 = connection.createStatement().executeQuery(sql2);
                //所有表参数集合
                List<Map<String, Object>> list = new ArrayList<>();
                while (resultSet2.next()) {//获取每个表下字段
                    ResultSetMetaData resultSetMetaData2 = resultSet2.getMetaData();
                    int count = resultSetMetaData2.getColumnCount();// 获取列的数量
                    HashMap<String, Object> mapItem = new HashMap<>();
                    for (int j = 1; j <= count; j++) {//获取每个字段属性
                        String key = resultSetMetaData2.getColumnLabel(j);
                        String value = resultSet2.getString(j);
                        mapItem.put(key, value);
                    }
                    mapItem.put("name", NameUtil.lineToHump(mapItem.get("column") + ""));
                    list.add(mapItem);
                }
                //格式化并保存表单数据
                String formatTableName = NameUtil.lineToHump(tableName);
                map.put("name", formatTableName);
                map.put("Name", NameUtil.upFirstName(formatTableName));
                map.put("comment", tableComment);
                map.put("data", list);
                //把对应表添加到集合中
                baseList.add(map);
            }
            return baseList;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
