package com.black.service;

import com.black.entity.TemplatePath;
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
public interface ITemplatePathService extends IService<TemplatePath> {

    /**
    * 查询任意数据
    * @param templatePath 对象数据
    * @return 对象数组
    */
    List<TemplatePath> findAll(TemplatePath templatePath);

    /**
    * 修改任意数据
    * @param templatePath 对象数据
    * @return 对象数组
    */
    public int modifyAll(TemplatePath templatePath);
}
