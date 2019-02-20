package com.zxd.forrun.mapper;

import com.zxd.forrun.pojo.po.SectionCus;

import java.util.List;

public interface SectionMapperCustom {

    /**
     * 获取自定义版块列表
     * @return
     */
    List<SectionCus> getSectionCus();

    Integer getGeneral();
}
