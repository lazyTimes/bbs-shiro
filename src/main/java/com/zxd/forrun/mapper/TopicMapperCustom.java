package com.zxd.forrun.mapper;

import com.zxd.forrun.pojo.po.TopicCus;
import com.zxd.forrun.pojo.po.TopicCusAll;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TopicMapperCustom {

    /**
     * 获取自定义主题板块信息
     * @param sectionId
     * @param categoryId
     * @return
     */
    List<TopicCus> getTopicCusList(@Param("sectionId") Integer sectionId, @Param("categoryId") Integer categoryId);

    /**
     * 获取总记录数
     * @return
     */
    int getTopicRowCount();

    /**
     * 获取自增主键
     */
    Integer getGeneralId();

    /**
     * 获取自定义主题内容信息
     * @return
     */
    List<TopicCusAll> getCustomTopics();
}
