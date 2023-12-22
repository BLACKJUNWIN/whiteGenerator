package com.black.service.impl;

import com.black.entity.User;
import com.black.mapper.UserMapper;
import com.black.service.IUserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author BlackJun
 * @since 2023-09-21 23:53:27
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements IUserService {
    @Autowired
    UserMapper userMapper;


    /**
     * 查询任意数据
     *
     * @param user 对象数据
     * @return 对象数组
     */
    @Override
    public List<User> findAll(User user) {
        return userMapper.selectAll(user);
    }

    /**
     * 修改任意数据
     *
     * @param user 对象数据
     * @return 对象数组
     */
    @Override
    public int modifyAll(User user) {
        return userMapper.updateAll(user);
    }
}
