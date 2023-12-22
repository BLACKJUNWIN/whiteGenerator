package com.black.service;

import com.black.entity.GeneratorRecord;
import com.baomidou.mybatisplus.extension.service.IService;
import com.github.pagehelper.PageInfo;

import java.util.List;
/**
 * <p>
 *  服务类
 * </p>
 *
 * @author BlackJun
 * @since 2023-09-21 23:53:26
 */
public interface IGeneratorRecordService extends IService<GeneratorRecord> {

    /**
    * 查询任意数据
    * @param generatorRecord 对象数据
    * @return 对象数组
    */
    List<GeneratorRecord> findAll(GeneratorRecord generatorRecord);

    /**
    * 修改任意数据
    * @param generatorRecord 对象数据
    * @return 对象数组
    */
    public int modifyAll(GeneratorRecord generatorRecord);
}
