package com.black.service;

import com.black.entity.User;
import com.baomidou.mybatisplus.extension.service.IService;
import com.github.pagehelper.PageInfo;

import java.util.List;
/**
 * <p>
 *  服务类
 * </p>
 *
 * @author BlackJun
 * @since 2023-09-21 23:53:27
 */
public interface IUserService extends IService<User> {

    /**
    * 查询任意数据
    * @param user 对象数据
    * @return 对象数组
    */
    List<User> findAll(User user);

    /**
    * 修改任意数据
    * @param user 对象数据
    * @return 对象数组
    */
    public int modifyAll(User user);
}
