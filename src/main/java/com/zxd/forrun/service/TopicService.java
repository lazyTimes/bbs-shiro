package com.zxd.forrun.service;

import com.zxd.forrun.pojo.Topic;
import com.zxd.forrun.pojo.po.TopicCusAll;
import com.zxd.forrun.pojo.vo.PageInfo;
import org.apache.ibatis.annotations.Param;

public interface TopicService {

    /**
     * 获取自增主键
     * @return
     */
    Integer getGeneralId();

    /**
     * 根据id查找对应主题
     * @param topicId
     * @return
     */
    Topic getTopicById(Integer topicId);

    /**
     * 根据主键更新主题信息
     * @param topic
     */
    void updateTopic(Topic topic) throws Exception;

    /**
     *
     * @param start
     * @param total
     * @param userid
     * @return
     */
    PageInfo<Topic> getTopicByUserId(Integer start, Integer total, @Param("userid") Integer userid);

    /**
     * 更新分类
     * @param categoryId
     */
    void updateTopicCategory(Integer categoryId);

    /**
     * 获取所有的主题信息
     * @param start
     * @param total
     * @return
     */
    PageInfo<TopicCusAll> getTopicAll(Integer start, Integer total);

    Integer delete(Topic tp);
}
