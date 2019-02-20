package com.zxd.forrun.enums;

public enum TopicLevel {
    LEVEL1("普通帖", 0), LEVEL2("精华帖", 1), LEVEL3("置顶帖", 2);
    private String name;
    private Integer index;

    TopicLevel(String name, Integer index) {
        this.name = name;
        this.index = index;
    }

    TopicLevel() {

    }

    public Integer getIndex() {
        return index;
    }

    public void setIndex(Integer index) {
        this.index = index;
    }
}
