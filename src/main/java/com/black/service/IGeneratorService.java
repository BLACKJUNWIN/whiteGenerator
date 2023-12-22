package com.black.service;

import com.black.common.entity.ApiCode;
import com.black.entity.TemplatePath;
import com.black.model.TableData;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;


public interface IGeneratorService{
    /**
     * 测试数据是否连接成功
     * @param map 数据连接数据
     * @return 状态码
     */
    ApiCode testSql(Map<String,String> map);

    /**
     * 获取数据库表数据
     * @param map 数据连接数据
     * @return 状态码
     */
   List<Map<String, Object>> getSqlData(Map<String,String> map);

    /**
     * 修改列注释
     * @param map sql连接参数
     * @param dataMap 列数据
     * @return 是否成功
     */
   boolean modifyColumComment(Map<String,String> map,Map<String,Object> dataMap);

    /**
     * 修改表注释
     * @param map sql连接参数
     * @param dataMap 表数据
     * @return 是否成功
     */
   boolean modifyTableComment(Map<String,String> map,Map<String,Object> dataMap);

    /**
     * 自动生成表注释
     * @param generatorList 列表
     * @return 是否成功
     */
    boolean generatorCode(List<TableData> generatorList);

    List<TemplatePath> generatorRealStatic(List<TableData> generatorList);
    List<TemplatePath> generatorStatic(List<TableData> generatorList);

    List<TemplatePath> generatorDynamic(List<TableData> generatorList);

    List<TemplatePath> generatorBefore(List<TableData> generatorList);

    List<TemplatePath> generatorBack(List<TableData> generatorList);
}
