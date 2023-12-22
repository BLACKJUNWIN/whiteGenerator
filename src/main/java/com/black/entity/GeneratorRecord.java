package com.black.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.time.LocalDateTime;
import com.black.common.entity.BaseEntity;
import lombok.*;
import org.springframework.beans.factory.annotation.Autowired;

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
@TableName("generator_record")
public class GeneratorRecord extends BaseEntity implements Serializable{

    private static final long serialVersionUID = 1L;

    @TableId(value = "`id`", type = IdType.AUTO)
    private Long id;

    @TableField(value = "`user_id`")
    private Long userId;

    @TableField(value = "`info`")
    private String info;

    @TableField(value = "`feedback`")
    private Boolean feedback;

    @TableField(value = "`evaluation`")
    private String evaluation;
}
