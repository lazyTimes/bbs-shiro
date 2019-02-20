package com.zxd.forrun.service;

import com.zxd.forrun.pojo.Section;
import com.zxd.forrun.pojo.Topic;
import com.zxd.forrun.pojo.TopicCategory;
import com.zxd.forrun.pojo.po.SectionCus;
import com.zxd.forrun.pojo.po.TopicCus;
import com.zxd.forrun.pojo.vo.PageInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 版块模块处理
 */
public interface SectionService {

    /**
     *  自定义版块信息
     * @return
     */
    List<SectionCus> sectionList();

    /**
     * 根据版块id 获取对应主题列表
     * @param topicId
     * @return
     */
    PageInfo<TopicCus> getTopicBySectionId(Integer start, Integer total, Integer topicId, Integer category_id);

    /**
     * 获取分类名称
     * @param type
     * @return
     */
    String getTopicCategoryName(Integer type);

    /**
     * 获取分类列表
     * @return
     */

    List<TopicCategory> getTopicCategoryList(@Param("sectionId") Integer sectionId);

    /**
     * 根据版块id获取对应版块
     * @param sectionId
     * @return
     */
    Section getSectionById(Integer sectionId);

    /**
     * 添加一个topic
     * @param topic
     */
    void addTopic(Topic topic) throws Exception;

    /**
     * 更新版块信息
     * @param sectionById
     */
    void updateSection(Section sectionById);

    /**
     * 添加一个版块
     * @param newsection
     */
    void addSection(Section newsection);

    /**
     * 获取最新的板块信息
     * @return
     */
    Integer getSectionGeneral();


}
