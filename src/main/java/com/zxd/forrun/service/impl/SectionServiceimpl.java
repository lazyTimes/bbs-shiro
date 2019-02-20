package com.zxd.forrun.service.impl;

import com.github.pagehelper.PageHelper;
import com.zxd.forrun.mapper.SectionMapper;
import com.zxd.forrun.mapper.TopicCategoryMapper;
import com.zxd.forrun.mapper.TopicMapper;
import com.zxd.forrun.mapper.SectionMapperCustom;
import com.zxd.forrun.mapper.TopicMapperCustom;
import com.zxd.forrun.pojo.*;
import com.zxd.forrun.pojo.po.SectionCus;
import com.zxd.forrun.pojo.po.TopicCus;
import com.zxd.forrun.pojo.vo.PageInfo;
import com.zxd.forrun.service.SectionService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class SectionServiceimpl implements SectionService{
    private static Logger logger = Logger.getLogger(SectionServiceimpl.class);

    @Autowired
    private SectionMapperCustom sectionMapperCustom;
    @Autowired
    private TopicCategoryMapper topicCategoryMapper;
    @Autowired
    private TopicMapperCustom topicMapperCustom;
    @Autowired
    private SectionMapper sectionMapper;
    @Autowired
    private TopicMapper topicMapper;

    public List<SectionCus> sectionList() {
        List<SectionCus> sectionCus = sectionMapperCustom.getSectionCus();
        return sectionCus;
    }

    /**
     * 使用分页获取主题内容
     * @param start
     * @param total
     * @param sectionId
     * @param categoryId
     * @return
     */
    public PageInfo<TopicCus> getTopicBySectionId(Integer start, Integer total,
                                                                         Integer sectionId, Integer categoryId) {
        List<TopicCus> topicCusList = null;
        PageInfo<TopicCus> page = null;
        if(sectionId==null)
            return null;
        try{
            PageHelper.startPage(start, total);
            int count = topicMapperCustom.getTopicRowCount();
            List<TopicCus> topicCusList1 = topicMapperCustom.getTopicCusList(sectionId, categoryId);
            page = new PageInfo<TopicCus>(start, total, count, topicCusList1);

        }catch (Exception e) {
            return null;
        }
        logger.info(page);
        return page;
    }

    public String getTopicCategoryName(Integer type) {
        TopicCategoryExample example = new TopicCategoryExample();
        TopicCategoryExample.Criteria criteria = example.createCriteria();
        criteria.andIdEqualTo(type);
        List<TopicCategory> topicCategories = topicCategoryMapper.selectByExample(example);
        if(topicCategories!= null && topicCategories.size()>0)
            return topicCategories.get(0).getCategoryName();
        return null;
    }

    public List<TopicCategory> getTopicCategoryList(Integer sectionId) {
        TopicCategoryExample topicCategoryExample = new TopicCategoryExample();
        TopicCategoryExample.Criteria criteria = topicCategoryExample.createCriteria();
        criteria.andSectionIdEqualTo(sectionId);
        List<TopicCategory> topicCategories = topicCategoryMapper.selectByExample(topicCategoryExample);
        if(topicCategories!=null && topicCategories.size()>0)
            return topicCategories;
        return null;
    }

    public Section getSectionById(Integer sectionId) {

        SectionExample sectionExample = new SectionExample();
        SectionExample.Criteria criteria = sectionExample.createCriteria();
        criteria.andIdEqualTo(sectionId);
        List<Section> sections = sectionMapper.selectByExample(sectionExample);

        if(sections!=null && sections.size()>0) {
            return sections.get(0);
        }

        return null;
    }

    public void addTopic(Topic topic) throws Exception {
        topicMapper.insertSelective(topic);
    }

    public void updateSection(Section sectionById) {
        sectionMapper.updateByPrimaryKeySelective(sectionById);
    }

    public void addSection(Section newsection) {
        sectionMapper.insertSelective(newsection);
    }

    public Integer getSectionGeneral() {

        return sectionMapperCustom.getGeneral();
    }




}
