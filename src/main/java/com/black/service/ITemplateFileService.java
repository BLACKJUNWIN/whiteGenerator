package com.black.service;

import com.black.entity.TemplateFile;
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
public interface ITemplateFileService extends IService<TemplateFile> {

    /**
    * 查询任意数据
    * @param templateFile 对象数据
    * @return 对象数组
    */
    List<TemplateFile> findAll(TemplateFile templateFile);

    /**
    * 修改任意数据
    * @param templateFile 对象数据
    * @return 对象数组
    */
    public int modifyAll(TemplateFile templateFile);
}
