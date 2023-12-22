package com.black.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.black.utils.FileUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.black.common.entity.ApiRes;
import com.black.service.ITemplatePathService;
import com.black.entity.TemplatePath;
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
@RequestMapping("/templatePath")
public class TemplatePathController {
    @Autowired
    ITemplatePathService iTemplatePathService;

    /**
    * 添加数据
    *
    */
    @PostMapping("/")
    public ApiRes<?> save(@RequestBody TemplatePath templatePath){
        if (iTemplatePathService.save(templatePath)){
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
        if(iTemplatePathService.removeById(id)){
            return ApiRes.SuccessApi();
        }
        return ApiRes.FailApi();
    }

    /**
    * 修改数据
    *
    */
    @PutMapping("/")
    public ApiRes<?> modify(@RequestBody TemplatePath templatePath){
        if(iTemplatePathService.modifyAll(templatePath)!=0){
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
        return new ApiRes<>(new PageInfo<>(iTemplatePathService.list()));
    }

    /**
    * 任意查询
    *
    */
    @PatchMapping("/")
    public ApiRes<?> findBy(@RequestBody TemplatePath templatePath){
        PageHelper.startPage(templatePath.getPageNum(),templatePath.getPageSize());
        if(templatePath.getName()!=null&&templatePath.getName().equals("生成")){
            return new ApiRes<>(new PageInfo<>(iTemplatePathService.list(new LambdaQueryWrapper<TemplatePath>().in(TemplatePath::getCategory,"静态生成","动态生成"))));
        }
        return new ApiRes<>(new PageInfo<>(iTemplatePathService.findAll(templatePath)));
    }

    /**
     * 获取文件树
     * @return 文件树结构
     */
    @GetMapping("/getFileTree")
    public ApiRes<?> getFileTree(){
        PageHelper.startPage(1,1000);
        List<TemplatePath> list = iTemplatePathService.list();
        return new ApiRes<>(FileUtil.parseArr(list));
    }
}
