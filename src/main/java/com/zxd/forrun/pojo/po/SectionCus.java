package com.zxd.forrun.pojo.po;

import com.zxd.forrun.pojo.Section;
import com.zxd.forrun.pojo.Topic;

public class SectionCus extends Section {
    private Topic lastTopic;
    private String username;

    public Topic getLastTopic() {
        return lastTopic;
    }

    public void setLastTopic(Topic lastTopic) {
        this.lastTopic = lastTopic;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
}
