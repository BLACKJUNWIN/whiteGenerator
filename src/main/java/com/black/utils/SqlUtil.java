package com.black.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;

public class SqlUtil {
    //获取sql对象
    public static ResultSet executeSql(Map<String,String> map,String sql) {
        try {
            //绑定驱动
            Class.forName(map.get("drive") );
            //绑定数据库对象 Connection
            Connection connection = DriverManager.getConnection(map.get("url"), map.get("user") , map.get("password"));
            //获取表数据
            return connection.createStatement().executeQuery(sql);
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
    }

    //修改数据
    public static int updateSql(Map<String,String> map,String sql) {
        try {
            //绑定驱动
            Class.forName(map.get("drive") );
            //绑定数据库对象 Connection
            Connection connection = DriverManager.getConnection(map.get("url"), map.get("user") , map.get("password"));
            //获取表数据
            return connection.createStatement().executeUpdate(sql);
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
