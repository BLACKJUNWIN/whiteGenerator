package com.black.mapper;

import com.black.entity.TemplatePath;
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
public interface TemplatePathMapper extends BaseMapper<TemplatePath> {
      /**
      * 查询任意数据
      * @param templatePath 对象数据
      * @return 对象数组
      */
      public List<TemplatePath> selectAll(TemplatePath templatePath);

      /**
      * 修改任意数据
      * @param templatePath 对象数据
      * @return 对象数组
      */
      public int updateAll(TemplatePath templatePath);
}
