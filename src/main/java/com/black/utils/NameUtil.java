package com.black.utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class NameUtil {

    private static final Pattern linePattern = Pattern.compile("_(\\w)");
    /**
     * 首字母小写
     *
     * @param name 英文内容
     * @return 首字母小写
     */
    public static String downFirstName(String name) {
        return name.substring(0, 1).toLowerCase() + name.substring(1);
    }

    /**
     * 首字母大写
     *
     * @param name 英文内容
     * @return 首字母大写
     */
    public static String upFirstName(String name) {
        return name.substring(0, 1).toUpperCase() + name.substring(1);
    }

    /**
     * 下划线转驼峰
     *
     * @param str 需要处理的英文内容
     * @return 驼峰内容
     */
    public static String lineToHump(String str) {
        StringBuilder result = new StringBuilder();
        String[] words = str.split("_");
        for (int i = 0; i < words.length; i++) {
            if (i == 0) {
                result.append(words[i].toLowerCase());
            } else {
                result.append(Character.toUpperCase(words[i].charAt(0)));
                result.append(words[i].substring(1).toLowerCase());
            }
        }
        return result.toString();
    }
}
