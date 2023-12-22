package com.black.utils;

import cn.hutool.core.io.file.PathUtil;
import cn.smallbun.screw.core.metadata.model.DataModel;
import com.black.common.enums.EnumFileType;
import com.black.entity.TemplatePath;
import com.black.model.TableData;
import freemarker.template.Configuration;
import freemarker.template.Template;
import lombok.extern.slf4j.Slf4j;

import javax.swing.filechooser.FileSystemView;
import java.io.BufferedWriter;
import java.io.File;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
@Slf4j
public class FileUtil {

    public static final String ProjectPath = System.getProperty("user.dir");
    /**
     * 获取桌面路径
     *
     * @return 桌面路径
     */
    public static String getDeckPath() {
        return FileSystemView.getFileSystemView().getHomeDirectory().getPath();
    }

    /**
     * 将输出路径内容移动桌面
     */
    public static void persistenceFileToDesk() {
        File dirFile = new File(System.getProperty("user.dir") + "\\out");
        dirFile.renameTo(new File(getDeckPath() + "\\out"));
    }

    //数据解析为树结构
    public static List<Map<String, Object>> parseArr(List<TemplatePath> parseArr) {
        List<Map<String, Object>> tree = new ArrayList<>();
        for (TemplatePath templatePath : parseArr) {
            String[] dirs = (templatePath.getPath() + "\\" + templatePath.getName()).split("\\\\");
            List<Map<String, Object>> currentNode = tree;
            for (int i = 0; i < dirs.length; i++) {
                if (!dirs[i].equals("")) {
                    boolean isPath = false;//检查是否存在文件夹
                    int pathIndex = 0;
                    for (int i1 = 0; i1 < currentNode.size(); i1++) {
                        if (currentNode.get(i1).get("label").equals(dirs[i])) {
                            isPath = true;
                            pathIndex = i1;
                            break;
                        }
                    }
                    if (!isPath || i == 0) {//如果不存在该节点就添加进去
                        List<Map<String, Object>> childList = new ArrayList<>();
                        Map<String, Object> childNode = new HashMap<>();
                        if (i == dirs.length - 1 && !templatePath.getType().equals("无")) {
                            childNode.put("label", dirs[i] + "." + templatePath.getType());
                        } else if (i == 0) {
                            childNode.put("label", templatePath.getName());
                            childNode.put("children", childList);
                        } else {
                            childNode.put("label", dirs[i]);
                            childNode.put("children", childList);
                        }
                        currentNode.add(childNode);
                        pathIndex = currentNode.size() - 1;
                    }
                    currentNode = (List<Map<String, Object>>) currentNode.get(pathIndex).get("children");
                }
            }
        }
        return tree;
    }


    /**
     * 文件生成,确定模板文件位置和输出位置
     *
     * @param file 需要处理的文件封装类
     * @param data  模板需要的文件数据
     */
    public static void generatorFile(TemplatePath file, TableData data) {
        String templatePath = file.getPath();
        String outFilePath= ProjectPath+"\\out"+templatePath;
        outFilePath=outFilePath.substring(0,outFilePath.lastIndexOf("\\")+1)+data.getName();
        if(file.getType()!= EnumFileType.无){
            templatePath+="."+file.getType();
            outFilePath+="."+file.getType();
        }
        templatePath+=".ftl";
        templatePath=templatePath.replace("\\","/");
        File outFile = new File(outFilePath);
        if (!outFile.exists()) {//如果不存在,创建目录
            if (!outFile.getParentFile().exists()) {
                boolean mkdirs = outFile.getParentFile().mkdirs();
            }
            //生成文件
            if (createFileByTemplate(templatePath, data, outFilePath)) {
                log.info("生成文件成功: {}", outFilePath);
            } else {
                log.warn("生成文件失败: {}", outFilePath);
            }
        } else {
            log.warn("文件已经存在: {}", outFilePath);
        }
    }

    /**
     * 生成静态文件
     *
     * @param templatePath 模版路径
     * @param tableData         模版需要的数据
     * @param outputPath   输出路径
     * @return 是否成功
     */
    private static boolean createFileByTemplate(String templatePath, TableData tableData, String outputPath) {
        try {
            // 获取Freemarker的Configuration
            Configuration config = DataUtil.getConfiguration();
            // 创建Template对象
            Template template = config.getTemplate(templatePath);
            // 生成静态页面
            Writer out = new BufferedWriter(new OutputStreamWriter(Files.newOutputStream(Paths.get(outputPath)), StandardCharsets.UTF_8));
            Map<String, Object> data = new HashMap<>();
            data.put("data",tableData);
            template.process(data, out);
            out.flush();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }
}
