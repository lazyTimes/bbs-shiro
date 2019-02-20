package com.zxd.forrun.pojo.po;

import com.zxd.forrun.pojo.Post;
import com.zxd.forrun.pojo.Topic;

public class TopicCus extends Topic {
    private Post lastPost;
    private String username;

    public Post getLastPost() {
        return lastPost;
    }

    public void setLastPost(Post lastPost) {
        this.lastPost = lastPost;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    @Override
    public String toString() {
        return "TopicCus{" +
                "lastPost=" + lastPost +
                ", username='" + username + '\'' +
                '}';
    }
}
