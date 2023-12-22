package com.black.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.black.common.entity.ApiCode;
import com.black.common.entity.ApiRes;
import com.black.service.IUserService;
import com.black.entity.User;
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
@RequestMapping("/user")
public class UserController {
    @Autowired
    IUserService iUserService;

    /**
    * 添加数据
    *
    */
    @PostMapping("/")
    public ApiRes<?> save(@RequestBody User user){
        if (iUserService.save(user)){
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
        if(iUserService.removeById(id)){
            return ApiRes.SuccessApi();
        }
        return ApiRes.FailApi();
    }

    /**
    * 修改数据
    *
    */
    @PutMapping("/")
    public ApiRes<?> modify(@RequestBody User user){
        if(iUserService.modifyAll(user)!=0){
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
        return new ApiRes<>(new PageInfo<>(iUserService.list()));
    }
    /**
    * 任意查询
    *
    */
    @PatchMapping("/")
    public ApiRes<?> findBy(@RequestBody User user){
        PageHelper.startPage(user.getPageNum(),user.getPageSize());
        return new ApiRes<>(new PageInfo<>(iUserService.findAll(user)));
    }
}
