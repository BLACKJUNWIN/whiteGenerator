package com.black.controller;

import com.black.common.entity.ApiRes;
import com.black.model.TableData;
import com.black.service.IGeneratorService;
import com.black.utils.DataUtil;
import com.black.utils.FileUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@CrossOrigin
@RequestMapping("/")
public class GeneratorController {


    @Autowired
    IGeneratorService iGeneratorService;

    @PostMapping("/test_sql")
    public ApiRes<?> testSql(@RequestBody Map<String,String> map){
        return ApiRes.AutoApi(iGeneratorService.testSql(map));
    }

    @PostMapping("/sql_table")
    public ApiRes<?> sqlTable(@RequestBody Map<String,String> map){
        return new ApiRes<>(iGeneratorService.getSqlData(map));
    }

    @PostMapping("/modify_table_comment")
    public ApiRes<?> modifyTableComment(@RequestBody Map<String,Object> map){
        if(iGeneratorService.modifyTableComment((Map<String, String>) map.get("sqlData"), (Map<String, Object>) map.get("dataMap"))){
            return ApiRes.SuccessApi();
        }
        return ApiRes.FailApi();
    }

    @PostMapping("/modify_column_comment")
    public ApiRes<?> modifyColumnComment(@RequestBody Map<String,Object> map){
        if(iGeneratorService.modifyColumComment((Map<String, String>) map.get("sqlData"), (Map<String, Object>) map.get("dataMap"))){
            return ApiRes.SuccessApi();
        }
        return ApiRes.FailApi();
    }

    @PostMapping("/generator_code")
    public ApiRes<?> generatorCode(@RequestBody List<TableData> generatorList){
        generatorList.forEach(tableData -> {
            tableData.setName(tableData.getName().replace("tk_",""));
        });
        DataUtil.addHump(generatorList);
        iGeneratorService.generatorCode(generatorList);
        return new ApiRes<>("");
    }
}
