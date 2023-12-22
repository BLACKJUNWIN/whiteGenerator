package com.black.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.List;
@Data
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class TableData {
    //表名
    private String name;
    //表注释
    private String comment;
    //表数据
    private List<TableColumn> data;
    //驼峰命名
    private String humpName;
}
