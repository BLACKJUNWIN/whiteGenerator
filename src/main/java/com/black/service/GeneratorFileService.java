//package com.black.service;
//
//
//import com.black.entity.GeneratorFile;
//import com.black.utils.Base;
//import com.black.utils.ContentUtil;
//import lombok.extern.slf4j.Slf4j;
//
//import java.util.*;
//
///**
// * 自动生成文件业务类
// */
//@Slf4j
//public class GeneratorFileService{
//
//    public static void doStaticFile(){
//        Map<String,Object> map=new HashMap<>();
//        //获取参数数据
//        map.put("param", Base.getParamMap());
//        //获取需要生成的文件
//        List<GeneratorFile> fileList = ContentUtil.getStaticFileList();
//        for (GeneratorFile file : fileList) {
//            ContentUtil.handleFile(file,map);
//        }
//        log.info("纯静态文件生成执行完成");
//    }
//    /**
//     * 随机生成静态文件
//     */
//    public static void doGenerator(){
//        Map<String,Object> map=new HashMap<>();
//        //获取参数数据
//        map.put("param", Base.getParamMap());
//        //获取数据库数据
//        map.put("data",Base.getMysqlData());
//        //获取需要生成的文件
//        List<GeneratorFile> generatorFileList = ContentUtil.getGeneratorFileList();
//        for (GeneratorFile file : generatorFileList) {//遍历需要自动生成的文件
//            ContentUtil.handleFile(file,map);
//        }
//        log.info("静态文件随机生成执行完成");
//    }
//
//    /**
//     * 通过数据库自动生成文件
//     */
//    public static void doGeneratorBySql(){
//        List<Map<String, Object>> mysqlData= Base.getMysqlData();
//        if(mysqlData.size()!=0){
//            List<GeneratorFile> autoGeneratorFileList = ContentUtil.getAutoGeneratorFileList();
//            for (GeneratorFile FileItem : autoGeneratorFileList) {//遍历需要自动生成的文件
//                for (Map<String,Object> table: mysqlData) {//遍历表数据,来生成对应表文件
//                    GeneratorFile cloneFile = FileItem.clone();
//                    Base.changeAutoFileOut(cloneFile,table.get("name")+"");
//                    ContentUtil.handleFile(cloneFile,table);
//                }
//            }
//            //日志记录
//            StringBuilder recordTables=new StringBuilder();
//            int size=0;
//            for (Map<String, Object> record : mysqlData) {
//                recordTables.append(record.get("name")).append(" ,");
//                size+=1;
//            }
//            log.info("处理数据库表 {} 张: {}",size,recordTables);
//        }else{
//            log.warn("没有获取到表数据,请检查数据库连接配置");
//        }
//        log.info("数据库数据动态生成执行完成");
//    }
//}
