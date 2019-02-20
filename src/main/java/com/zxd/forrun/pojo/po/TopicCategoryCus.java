package com.zxd.forrun.pojo.po;

import com.zxd.forrun.pojo.Section;
import com.zxd.forrun.pojo.TopicCategory;

import java.util.List;

public class TopicCategoryCus extends Section {
    private List<TopicCategory> categorys;

    public List<TopicCategory> getCategorys() {
        return categorys;
    }

    public void setCategorys(List<TopicCategory> categorys) {
        this.categorys = categorys;
    }
}
