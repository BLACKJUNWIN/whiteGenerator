package com.black.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.time.LocalDateTime;

import com.black.common.entity.BaseEntity;
import com.black.common.enums.EnumFileType;
import com.black.common.enums.EnumPathCategory;
import lombok.*;

/**
 * <p>
 *  模板文件路径
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
@TableName("template_path")
public class TemplatePath extends BaseEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "`id`", type = IdType.AUTO)
    private Long id;

    @TableField(value = "`category`")
    private EnumPathCategory category;
    @TableField(value = "`name`")
    private String name;

    @TableField(value = "`name_ch`")
    private String nameCh;

    @TableField(value = "`path`")
    private String path;

    @TableField(value = "`type`")
    private EnumFileType type;

    @TableField(value = "`press`")
    private String press;

    @TableField(value = "`size`")
    private Integer size;

    @TableField(value = "`version`")
    private Integer version;
}
