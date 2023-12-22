package com.black.service.impl;

import com.black.entity.TemplateFile;
import com.black.mapper.TemplateFileMapper;
import com.black.service.ITemplateFileService;
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
public class TemplateFileServiceImpl extends ServiceImpl<TemplateFileMapper, TemplateFile> implements ITemplateFileService {
    @Autowired
    TemplateFileMapper templateFileMapper;


    /**
     * 查询任意数据
     *
     * @param templateFile 对象数据
     * @return 对象数组
     */
    @Override
    public List<TemplateFile> findAll(TemplateFile templateFile) {
        return templateFileMapper.selectAll(templateFile);
    }

    /**
     * 修改任意数据
     *
     * @param templateFile 对象数据
     * @return 对象数组
     */
    @Override
    public int modifyAll(TemplateFile templateFile) {
        return templateFileMapper.updateAll(templateFile);
    }
}
