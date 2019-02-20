package com.zxd.forrun.service.impl;

import com.zxd.forrun.mapper.SectionMapper;
import com.zxd.forrun.mapper.TopicCategoryMapper;
import com.zxd.forrun.pojo.Section;
import com.zxd.forrun.pojo.SectionExample;
import com.zxd.forrun.pojo.TopicCategory;
import com.zxd.forrun.pojo.TopicCategoryExample;
import com.zxd.forrun.pojo.po.TopicCategoryCus;
import com.zxd.forrun.service.TopicCategoryService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
public class TopicCategoryServiceimpl implements TopicCategoryService {
    @Autowired
    private SectionMapper sectionMapper;
    @Autowired
    private TopicCategoryMapper topicCategoryMapper;

    /**
     * 1. 查找所有的板块细腻并复制到结果中
     * 2. 根据版块id查找对应版块的分类信息
     * @return
     */
    public List<TopicCategoryCus> findTopicCategroyCusList() {
        List<TopicCategoryCus> result = new ArrayList<TopicCategoryCus>();
        List<Section> sections = sectionMapper.selectByExample(new SectionExample());

        //遍历版块信息
        for(Section sec :sections){
            TopicCategoryCus topicCategoryCus = new TopicCategoryCus();
            BeanUtils.copyProperties(sec, topicCategoryCus);
            result.add(topicCategoryCus);

            TopicCategoryExample example = new TopicCategoryExample();
            TopicCategoryExample.Criteria criteria = example.createCriteria();
            criteria.andSectionIdEqualTo(sec.getId());
            List<TopicCategory> topicCategories = topicCategoryMapper.selectByExample(example);
            topicCategoryCus.setCategorys(topicCategories);
        }
        return result;
    }

    public TopicCategory getById(Integer id) {
        return topicCategoryMapper.selectByPrimaryKey(id);
    }

    public Integer update(TopicCategory topicCategory) {
        return topicCategoryMapper.updateByPrimaryKeySelective(topicCategory);
    }

    public Integer add(TopicCategory nes) {
        return topicCategoryMapper.insertSelective(nes);
    }

    public Integer delete(Integer id) {
        return topicCategoryMapper.deleteByPrimaryKey(id);
    }
}
