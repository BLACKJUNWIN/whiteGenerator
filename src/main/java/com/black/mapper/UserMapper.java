package com.black.mapper;

import com.black.entity.User;
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
public interface UserMapper extends BaseMapper<User> {
      /**
      * 查询任意数据
      * @param user 对象数据
      * @return 对象数组
      */
      public List<User> selectAll(User user);

      /**
      * 修改任意数据
      * @param user 对象数据
      * @return 对象数组
      */
      public int updateAll(User user);
}
