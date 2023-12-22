//package com.black.utils;
//
//import com.black.entity.AutoTemplatePath;
//import com.black.entity.GeneratorFile;
//import com.black.entity.StaticPath;
//import com.black.entity.TemplatePath;
//import freemarker.template.*;
//import lombok.extern.slf4j.Slf4j;
//
//import java.io.*;
//import java.nio.charset.StandardCharsets;
//import java.nio.file.Files;
//import java.nio.file.Paths;
//import java.util.ArrayList;
//import java.util.List;
//import java.util.Map;
//import java.util.regex.Matcher;
//import java.util.regex.Pattern;
//
///**
// * 内容处理类
// */
//@Slf4j
//public class ContentUtil {
//    private static final Pattern linePattern = Pattern.compile("_(\\w)");
//    /**
//     * 生成静态文件
//     * @param templatePath 模版路径
//     * @param data 模版需要的数据
//     * @param outputPath 输出路径
//     * @return 是否成功
//     */
//    public static boolean createFile(String templatePath, Map<String, Object> data, String outputPath) {
//        try {
//            // 获取Freemarker的Configuration
//            Configuration config = new Base().getConfiguration();
//            // 创建Template对象
//            Template template = config.getTemplate(templatePath);
//            // 生成静态页面
//            Writer out = new BufferedWriter(new OutputStreamWriter(Files.newOutputStream(Paths.get(outputPath)), StandardCharsets.UTF_8));
//            template.process(data, out);
//            out.flush();
//            out.close();
//        } catch (Exception e) {
////            return false;
//            throw new RuntimeException(e);
//        }
//        return true;
//    }
//
//    /**
//     * 获取纯静态文件集合
//     * @return 纯静态文件集合
//     */
//    public static List<GeneratorFile> getStaticFileList(){
//        List<GeneratorFile> list=new ArrayList<>();
//        for (StaticPath item : StaticPath.values()) {
//            GeneratorFile file = GeneratorFile.getStaticFile(item);
//            if (file!=null){
//                list.add(file);
//            }
//        }
//        return list;
//    }
//    /**
//     * 获取随机静态文件集合
//     * @return 随机静态文件集合
//     */
//    public static List<GeneratorFile> getGeneratorFileList(){
//        List<GeneratorFile> list=new ArrayList<>();
//        for (TemplatePath item : TemplatePath.values()) {
//            GeneratorFile file = GeneratorFile.getGeneratorFile(item);
//            if (file!=null){
//                list.add(file);
//            }
//        }
//        return list;
//    }
//
//    /**
//     * 获取数据库文件集合
//     * @return 数据库文件集合
//     */
//    public static List<GeneratorFile> getAutoGeneratorFileList(){
//        List<GeneratorFile> list=new ArrayList<>();
//        for (AutoTemplatePath item : AutoTemplatePath.values()) {
//            GeneratorFile file = GeneratorFile.getAutoGeneratorFile(item);
//            if (file!=null){
//                list.add(file);
//            }
//        }
//        return list;
//    }
//
//    /**
//     * 文件保存处理
//     * @param file 需要处理的文件封装类
//     * @param map  模板需要的文件数据
//     */
//    public static void handleFile(GeneratorFile file,Map<String,Object> map){
//        String templatePath=file.getTemplateFilePath().replace(Base.getTemplates(),"");
//        File outFile = new File(file.getOutFilePath());
//        if (!outFile.exists()){//如果不存在
//            if(!outFile.getParentFile().exists()){
//                boolean mkdirs = outFile.getParentFile().mkdirs();//创建目录
//            }
//            //生成文件
//            if(createFile(templatePath,map,file.getOutFilePath())){
//                log.info("生成文件成功: {}",file.getOutFilePath());
//            }else{
//                log.warn("生成文件失败: {}",file.getOutFilePath());
//            }
//        }else{
//            log.warn("文件已经存在: {}",file.getOutFilePath());
//        }
//    }
//
//    /**
//     * 首字母小写
//     * @param name 英文内容
//     * @return 首字母小写
//     */
//    public static String downFirstName(String name){
//        return name.substring(0, 1).toLowerCase() + name.substring(1);
//    }
//
//    /**
//     * 首字母大写
//     * @param name 英文内容
//     * @return 首字母大写
//     */
//    public static String upFirstName(String name){
//        return name.substring(0, 1).toUpperCase() + name.substring(1);
//    }
//
//    /**
//     *  下划线转驼峰
//     * @param str 需要处理的英文内容
//     * @return 驼峰内容
//     */
//    public static String lineToHump(String str) {
//        str = str.toLowerCase();
//        Matcher matcher = linePattern.matcher(str);
//        StringBuffer sb = new StringBuffer();
//        while (matcher.find()) {
//            matcher.appendReplacement(sb, matcher.group(1).toUpperCase());
//        }
//        matcher.appendTail(sb);
//        return sb.toString();
//    }
//
//    /**
//     * 生成随机整数（包含起始与终止范围）
//     *
//     * @return 随机整数
//     */
//    public static int GetRandomNum(int startNum, int endNum) {
//        return (int) (startNum + Math.random() * (endNum - startNum + 1));
//    }
//
//}
