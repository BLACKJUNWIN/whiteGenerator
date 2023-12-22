package com.black.mapper;

import com.black.entity.TemplateFile;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;
/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author BlackJun
 * @since 2023-09-21 23:53:27
 */
@Mapper
public interface TemplateFileMapper extends BaseMapper<TemplateFile> {
      /**
      * 查询任意数据
      * @param templateFile 对象数据
      * @return 对象数组
      */
      public List<TemplateFile> selectAll(TemplateFile templateFile);

      /**
      * 修改任意数据
      * @param templateFile 对象数据
      * @return 对象数组
      */
      public int updateAll(TemplateFile templateFile);
}
