package com.black.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class TableEnum {
    //枚举名字
    private String name;
    //枚举值
    private String value;
}
