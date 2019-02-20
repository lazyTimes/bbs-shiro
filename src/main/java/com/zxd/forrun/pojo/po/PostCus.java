package com.zxd.forrun.pojo.po;

import com.zxd.forrun.pojo.Post;
import com.zxd.forrun.pojo.Users;
import com.zxd.forrun.pojo.vo.PageInfo;

/**
 * 自定义post
 */
public class PostCus extends Post {
    private Users user;
    private PageInfo<Post> child;

    public Users getUser() {
        return user;
    }

    public void setUser(Users user) {
        this.user = user;
    }

    public PageInfo<Post> getChild() {
        return child;
    }

    public void setChild(PageInfo<Post> child) {
        this.child = child;
    }
}
