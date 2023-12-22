package com.black.service.impl;

import com.black.entity.GeneratorRecord;
import com.black.mapper.GeneratorRecordMapper;
import com.black.service.IGeneratorRecordService;
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
 * @since 2023-09-21 23:53:26
 */
@Service
public class GeneratorRecordServiceImpl extends ServiceImpl<GeneratorRecordMapper, GeneratorRecord> implements IGeneratorRecordService {
    @Autowired
    GeneratorRecordMapper generatorRecordMapper;


    /**
     * 查询任意数据
     *
     * @param generatorRecord 对象数据
     * @return 对象数组
     */
    @Override
    public List<GeneratorRecord> findAll(GeneratorRecord generatorRecord) {
        return generatorRecordMapper.selectAll(generatorRecord);
    }

    /**
     * 修改任意数据
     *
     * @param generatorRecord 对象数据
     * @return 对象数组
     */
    @Override
    public int modifyAll(GeneratorRecord generatorRecord) {
        return generatorRecordMapper.updateAll(generatorRecord);
    }
}
