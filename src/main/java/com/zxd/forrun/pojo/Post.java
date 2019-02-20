package com.zxd.forrun.pojo;

import java.util.Date;

public class Post {
    private Integer id;

    private Integer topicId;

    private String title;

    private Integer author;

    private Date createDate;

    private Date lastUpdate;

    private String ipaddr;

    private Integer parentId;

    private Integer click;

    private String content;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getTopicId() {
        return topicId;
    }

    public void setTopicId(Integer topicId) {
        this.topicId = topicId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public Integer getAuthor() {
        return author;
    }

    public void setAuthor(Integer author) {
        this.author = author;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Date getLastUpdate() {
        return lastUpdate;
    }

    public void setLastUpdate(Date lastUpdate) {
        this.lastUpdate = lastUpdate;
    }

    public String getIpaddr() {
        return ipaddr;
    }

    public void setIpaddr(String ipaddr) {
        this.ipaddr = ipaddr == null ? null : ipaddr.trim();
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    public Integer getClick() {
        return click;
    }

    public void setClick(Integer click) {
        this.click = click;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    @Override
    public String toString() {
        return "Post{" +
                "id=" + id +
                ", topicId=" + topicId +
                ", title='" + title + '\'' +
                ", author=" + author +
                ", createDate=" + createDate +
                ", lastUpdate=" + lastUpdate +
                ", ipaddr='" + ipaddr + '\'' +
                ", parentId=" + parentId +
                ", click=" + click +
                ", content='" + content + '\'' +
                '}';
    }
}