package com.black.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.time.LocalDateTime;

import com.black.common.entity.BaseEntity;
import lombok.*;

/**
 * <p>
 *  静态生成模板文件
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
@TableName("template_file")
public class TemplateFile extends BaseEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "`id`", type = IdType.AUTO)
    private Long id;

    @TableField(value = "`file_name`")
    private String fileName;

    @TableField(value = "`template_path_id`")
    private Long templatePathId;

    @TableField(value = "`theme`")
    private String theme;

    @TableField(value = "`img_url`")
    private String imgUrl;

    @TableField(value = "`describe`")
    private String describe;

    @TableField(exist = false)
    private String path;

    @TableField(exist = false)
    private String name;

    @TableField(exist = false)
    private String nameCh;
}
