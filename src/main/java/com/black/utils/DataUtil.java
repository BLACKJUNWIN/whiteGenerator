package com.black.utils;

import com.black.model.TableData;
import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateExceptionHandler;
import freemarker.template.TemplateModelException;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.*;

import static com.black.utils.FileUtil.ProjectPath;

public class DataUtil {

    private static Configuration config = null;

    /**
     * 获取param.properties参数数据
     * @return param.properties参数数据
     */
    private static Map<String, Object> getParamMap() throws IOException {
        //获取properties数据
        InputStream inputStream = null;
        Properties properties;
        try {
            inputStream = Files.newInputStream(Paths.get(ProjectPath + "\\src\\main\\resources\\param.properties"));
            //实例化Properties类
            properties = new Properties();
            properties.load(inputStream);
        } catch (IOException e) {
            throw new RuntimeException(e);
        } finally {//最终都需要释放流
            if(inputStream!=null){
                inputStream.close();
            }
        }
        //强转为map
        return new HashMap<String, Object>((Map) properties);
    }

    /**
     * 获取Configuration对象
     */
    public static Configuration getConfiguration() {
        if (config == null) {
            config = new Configuration(Configuration.VERSION_2_3_30);
            //设置模版放置路径，这里表示在classpath下的templates文件夹下
            config.setClassForTemplateLoading(DataUtil.class, "/templates/");
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
     * 添加驼峰命名
     * @param dataList 需要添加驼峰的数据
     * @return 处理后数据
     */
    public static List<TableData> addHump(List<TableData> dataList){
        dataList.forEach(tableData -> {
            System.out.println(tableData.getName());
            tableData.setHumpName(NameUtil.lineToHump(tableData.getName()));
            System.out.println(tableData.getHumpName());
            tableData.getData().forEach(column->{
                column.setHumpColumn(NameUtil.lineToHump(column.getColumn()));
            });
        });
        return dataList;
    }
}
