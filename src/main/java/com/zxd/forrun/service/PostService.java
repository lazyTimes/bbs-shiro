package com.zxd.forrun.service;

import com.zxd.forrun.pojo.Post;
import com.zxd.forrun.pojo.po.PostCus;
import com.zxd.forrun.pojo.po.TopicCus;
import com.zxd.forrun.pojo.vo.PageInfo;
import org.apache.ibatis.annotations.Param;

public interface PostService {

    /**
     * 获取回复父类以及每一个回复的子类
     * @param topicId
     * @return
     */
    PageInfo<TopicCus> getPostListAndChild(Integer start, Integer total, Integer topicId, @Param("childStart") Integer childStart);

    /**
     * 添加一个回复
     */
    void add(Integer topicId, Post postcus) throws  Exception;

    /**
     * 根据parentid获取父类id
     * @param parentId
     * @return
     */
    Post getPostById(Integer parentId);

    /**
     * 查找某个用户下所有回复
     * @param id
     * @return
     */
    PageInfo<Post> getPostsByUserId(Integer start, Integer total, @Param("userid") Integer userid);

    /**
     * 获取指定回复
     * @return
     */
    PageInfo<PostCus> getLastPosts();

    /**
     * 更新点赞数
     * @param postById
     */
    void updateClick(Post postById);

    /**
     *  根据主题删除所有的子回复
     * @param id
     */
    Integer deleteByTopicId(Integer id);
}
