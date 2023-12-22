package com.black.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.black.common.entity.ApiCode;
import com.black.common.entity.ApiRes;
import com.black.service.ITemplateFileService;
import com.black.entity.TemplateFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;
/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author BlackJun
 * @since 2023-09-21 23:53:27
 */
@CrossOrigin
@RestController
@RequestMapping("/templateFile")
public class TemplateFileController {
    @Autowired
    ITemplateFileService iTemplateFileService;

    /**
    * 添加数据
    *
    */
    @PostMapping("/")
    public ApiRes<?> save(@RequestBody TemplateFile templateFile){
        if (iTemplateFileService.save(templateFile)){
            return ApiRes.SuccessApi();
        }
        return ApiRes.FailApi();
    }

    /**
    * 删除数据
    *
    */
    @DeleteMapping("/{id}")
    public ApiRes<?> remove(@PathVariable("id") Long id){
        if(iTemplateFileService.removeById(id)){
            return ApiRes.SuccessApi();
        }
        return ApiRes.FailApi();
    }

    /**
    * 修改数据
    *
    */
    @PutMapping("/")
    public ApiRes<?> modify(@RequestBody TemplateFile templateFile){
        if(iTemplateFileService.modifyAll(templateFile)!=0){
            return ApiRes.SuccessApi();
        }
        return ApiRes.FailApi();
    }
    /**
    * 查询全部
    *
    */
    @GetMapping("/")
    public ApiRes<?> findAll(){
        PageHelper.startPage(1,10);
        return new ApiRes<>(new PageInfo<>(iTemplateFileService.list()));
    }
    /**
    * 任意查询
    *
    */
    @PatchMapping("/")
    public ApiRes<?> findBy(@RequestBody TemplateFile templateFile){
        PageHelper.startPage(templateFile.getPageNum(), templateFile.getPageSize());
        return new ApiRes<>(new PageInfo<>(iTemplateFileService.findAll(templateFile)));
    }
}
