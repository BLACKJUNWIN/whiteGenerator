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
public class TableColumn {
    //列名
    private String column;
    //注释
    private String comment;
    //类型
    private String type;
    //char类型长度
    private String charLength;
    //字段是否需要在过滤面板
    private boolean canSelect;
    //字段是否需要在编辑面板
    private boolean canEdit;
    //字段是否为枚举
    private boolean canEnum;
    //枚举具体类型
    private List<TableEnum> enumList;
    //驼峰列名
    private String humpColumn;
}
