package com.zxd.forrun.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.zxd.forrun.mapper.TopicCategoryMapper;
import com.zxd.forrun.mapper.TopicMapper;
import com.zxd.forrun.mapper.TopicMapperCustom;
import com.zxd.forrun.pojo.Topic;
import com.zxd.forrun.pojo.TopicCategory;
import com.zxd.forrun.pojo.TopicExample;
import com.zxd.forrun.pojo.po.TopicCusAll;
import com.zxd.forrun.pojo.vo.PageInfo;
import com.zxd.forrun.service.TopicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class TopicServiceimpl implements TopicService {

    @Autowired
    private TopicMapperCustom topicMapperCustom;
    @Autowired
    private TopicMapper topicMapper;
    @Autowired
    private TopicCategoryMapper topicCategoryMapper;

    public Integer getGeneralId() {

        return topicMapperCustom.getGeneralId();
    }

    public Topic getTopicById(Integer topicId) {
        return topicMapper.selectByPrimaryKey(topicId);
    }

    public void updateTopic(Topic topic) throws Exception{
        Topic tp = topicMapper.selectByPrimaryKey(topic.getId());
        if(tp==null)
            throw new RuntimeException("找不到对应主题");
        topicMapper.updateByPrimaryKey(topic);
    }

    public PageInfo<Topic> getTopicByUserId(Integer start, Integer total, Integer userid) {
        if(userid==null)
            throw new RuntimeException("找不到用户");
        TopicExample topicExample = new TopicExample();
        topicExample.setOrderByClause("last_update DESC");
        TopicExample.Criteria criteria = topicExample.createCriteria();
        criteria.andAuthorEqualTo(userid);

        Page<Object> objects = PageHelper.startPage(start, total);
        List<Topic> topics = topicMapper.selectByExample(topicExample);
        com.github.pagehelper.PageInfo pageInfo = new com.github.pagehelper.PageInfo(objects);
        PageInfo<Topic> pageInfo1 = new PageInfo<Topic>(start, total, (int)pageInfo.getTotal(), topics);
        if(topics!=null && topics.size()>0)
            return pageInfo1;
        return null;
    }

    public void updateTopicCategory(Integer generalId) {
        if(generalId==null)
            throw new RuntimeException("找不到分类");
        TopicCategory topicCategory = topicCategoryMapper.selectByPrimaryKey(generalId);
        topicCategory.setCategoryCount(topicCategory.getCategoryCount()+1);
        topicCategoryMapper.updateByPrimaryKeySelective(topicCategory);


    }

    public PageInfo<TopicCusAll> getTopicAll(Integer start, Integer total) {
        Page<Object> objects = PageHelper.startPage(start, total);
        List<TopicCusAll> customTopics = topicMapperCustom.getCustomTopics();
        com.github.pagehelper.PageInfo pageInfo = new com.github.pagehelper.PageInfo(objects);
        PageInfo<TopicCusAll> pageInfo1 = new PageInfo<TopicCusAll>(start, total, Integer.parseInt(String.valueOf(pageInfo.getTotal())), customTopics);
        if(customTopics!=null && customTopics.size()>0)
            return pageInfo1;
        return null;
    }

    public Integer delete(Topic tp) {
        return topicMapper.deleteByPrimaryKey(tp.getId());
    }


}
