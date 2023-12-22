package com.black.mapper;

import com.black.entity.GeneratorRecord;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;
/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author BlackJun
 * @since 2023-09-21 23:53:26
 */
@Mapper
public interface GeneratorRecordMapper extends BaseMapper<GeneratorRecord> {
      /**
      * 查询任意数据
      * @param generatorRecord 对象数据
      * @return 对象数组
      */
      public List<GeneratorRecord> selectAll(GeneratorRecord generatorRecord);

      /**
      * 修改任意数据
      * @param generatorRecord 对象数据
      * @return 对象数组
      */
      public int updateAll(GeneratorRecord generatorRecord);
}
