package com.black;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * 自动生成文件启动类
 */
@SpringBootApplication
public class GeneratorApplication {
    public static void main(String[] args) {
        //纯静态文件生成
//        GeneratorFileService.doStaticFile();
        //静态随机文件生成
//        GeneratorFileService.doGenerator();
        //通过数据库动态文件生成
//        GeneratorFileService.doGeneratorBySql();
        SpringApplication.run(GeneratorApplication.class, args);
    }
}
