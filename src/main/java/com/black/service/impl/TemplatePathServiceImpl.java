package com.black.service.impl;

import com.black.entity.TemplatePath;
import com.black.mapper.TemplatePathMapper;
import com.black.service.ITemplatePathService;
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
public class TemplatePathServiceImpl extends ServiceImpl<TemplatePathMapper, TemplatePath> implements ITemplatePathService {
    @Autowired
    TemplatePathMapper templatePathMapper;


    /**
     * 查询任意数据
     *
     * @param templatePath 对象数据
     * @return 对象数组
     */
    @Override
    public List<TemplatePath> findAll(TemplatePath templatePath) {
        return templatePathMapper.selectAll(templatePath);
    }

    /**
     * 修改任意数据
     *
     * @param templatePath 对象数据
     * @return 对象数组
     */
    @Override
    public int modifyAll(TemplatePath templatePath) {
        return templatePathMapper.updateAll(templatePath);
    }
}
