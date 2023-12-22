package com.black.entity;

import java.io.Serializable;
import java.time.LocalDateTime;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.black.common.entity.BaseEntity;
import lombok.*;

/**
 * <p>
 *
 * </p>
 *
 * @author BlackJun
 * @since 2023-09-22 13:48:45
 */
@EqualsAndHashCode(callSuper = true)
@Data
@ToString
@AllArgsConstructor
@NoArgsConstructor
@TableName("user")
public class User extends BaseEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableField(value = "`id`")
    private Long id;

    @TableField(value = "`name`")
    private String name;

    @TableField(value = "`password`")
    private String password;

    @TableField(value = "`role`")
    private String role;
}
