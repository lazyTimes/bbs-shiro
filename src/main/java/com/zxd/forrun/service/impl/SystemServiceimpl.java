package com.zxd.forrun.service.impl;

import com.zxd.forrun.mapper.SectionMapper;
import com.zxd.forrun.pojo.Section;
import com.zxd.forrun.pojo.SectionExample;
import com.zxd.forrun.service.SystemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
@Service
public class SystemServiceimpl implements SystemService {
    @Autowired
    private SectionMapper sectionMapper;

    public List<Section> getSectionList() {
        SectionExample sectionExample = new SectionExample();
        sectionExample.setOrderByClause("orderid DESC");
        List<Section> sections = sectionMapper.selectByExample(sectionExample);

        return sections;
    }
}
