package com.zxd.forrun.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.zxd.forrun.mapper.PostMapper;
import com.zxd.forrun.mapper.TopicMapper;
import com.zxd.forrun.mapper.PostMapperCustom;
import com.zxd.forrun.pojo.Post;
import com.zxd.forrun.pojo.PostExample;
import com.zxd.forrun.pojo.Topic;
import com.zxd.forrun.pojo.po.PostCus;
import com.zxd.forrun.pojo.po.TopicCus;
import com.zxd.forrun.pojo.vo.PageInfo;
import com.zxd.forrun.service.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class PostServiceimpl implements PostService {
    private static org.apache.log4j.Logger logger = org.apache.log4j.Logger.getLogger(PostServiceimpl.class);
    @Autowired
    private PostMapper postMapper;
    @Autowired
    private TopicMapper topicMapper;
    @Autowired
    private PostMapperCustom postMapperCustom;

    @Value("${lastcount}")
    private Integer lastCount;
    /**
     * 回复分页数
     */
    @Value("${count}")
    private Integer postCount;

    public PageInfo<TopicCus> getPostListAndChild(Integer start, Integer total, Integer topicId, Integer childStart) {

        Page<Object> startPage = PageHelper.startPage(start, total);
        List<PostCus> postList = postMapperCustom.getPostList(topicId);
        //遍历所有的父节点查找子节点
        for(PostCus postCus : postList){
            PostExample example = new PostExample();
            PostExample.Criteria criteria = example.createCriteria();
            criteria.andParentIdEqualTo(postCus.getId());
            Page<Object> objects = null;
            if(childStart!=null)
                objects = PageHelper.startPage(childStart, postCount);
            else
                objects = PageHelper.startPage(1, postCount);
            //当前回复下面的子回复
            List<Post> posts = postMapper.selectByExampleWithBLOBs(example);

            com.github.pagehelper.PageInfo pageInfo = new com.github.pagehelper.PageInfo(objects);
            PageInfo child = new PageInfo(1,postCount, (int)pageInfo.getTotal(), posts);
            postCus.setChild(child);
        }
        com.github.pagehelper.PageInfo pageInfo = new com.github.pagehelper.PageInfo(startPage);
        PageInfo result = new PageInfo(start,total, (int)pageInfo.getTotal(), postList);
        return result;
    }

    public void add(Integer topicId, Post postcus) throws Exception{
        System.out.println("postcus" + postcus);
        Topic topic = topicMapper.selectByPrimaryKey(topicId);
        if(topic==null)
            throw new RuntimeException("找不到主题");
        postcus.setTopicId(topicId);
        int i = postMapper.insertSelective(postcus);
        logger.info("发表新回复"+i);
    }

    public Post getPostById(Integer parentId) {
        return postMapper.selectByPrimaryKey(parentId);
    }

    public PageInfo<Post> getPostsByUserId(Integer start, Integer total, Integer userid) {
        if(userid==null)
            throw new RuntimeException("找不到用户");
        PostExample postExample = new PostExample();
        postExample.setOrderByClause("last_update DESC");
        PostExample.Criteria criteria = postExample.createCriteria();
        criteria.andAuthorEqualTo(userid);
        Page<Object> objects = PageHelper.startPage(start, total);
        List<Post> posts = postMapper.selectByExample(postExample);
        com.github.pagehelper.PageInfo pageInfo = new com.github.pagehelper.PageInfo(objects);
        PageInfo<Post> pageInfo1 = new PageInfo<Post>(start, total, (int)pageInfo.getTotal(), posts);
        if(posts!=null && posts.size()>0)
            return pageInfo1;
        return null;
    }

    public PageInfo<PostCus> getLastPosts() {
        Page<Object> objects = PageHelper.startPage(1, lastCount);
        List<PostCus> lastPostCusList = postMapperCustom.getLastPostCusList();
        com.github.pagehelper.PageInfo pageInfo = new com.github.pagehelper.PageInfo(objects);
        PageInfo<PostCus> pageInfo1 = new PageInfo<PostCus>(1, lastCount,
                (int)pageInfo.getTotal(), lastPostCusList);
        if(lastPostCusList!=null && lastPostCusList.size()>0)
            return pageInfo1;
        return null;

    }

    public void updateClick(Post postById) {
        postById.setClick(postById.getClick()+1);
        postMapper.updateByPrimaryKey(postById);
    }

    public Integer deleteByTopicId(Integer id) {
        PostExample postExample = new PostExample();
        PostExample.Criteria criteria = postExample.createCriteria();
        criteria.andTopicIdEqualTo(id);
        Integer i = postMapper.deleteByExample(postExample);
        return i;
    }


}
