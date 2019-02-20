package com.zxd.forrun.service;

import com.zxd.forrun.pojo.TopicCategory;
import com.zxd.forrun.pojo.po.TopicCategoryCus;

import java.util.List;

public interface TopicCategoryService {

    List<TopicCategoryCus> findTopicCategroyCusList();

    TopicCategory getById(Integer id);

    Integer update(TopicCategory topicCategory);

    Integer add(TopicCategory nes);

    Integer delete(Integer id);
}
