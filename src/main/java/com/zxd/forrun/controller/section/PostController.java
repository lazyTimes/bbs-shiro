package com.zxd.forrun.controller.section;

import com.zxd.forrun.pojo.Post;
import com.zxd.forrun.pojo.Topic;
import com.zxd.forrun.pojo.Users;
import com.zxd.forrun.pojo.po.TopicCus;
import com.zxd.forrun.pojo.vo.PageInfo;
import com.zxd.forrun.pojo.vo.ResultCode;
import com.zxd.forrun.service.PostService;
import com.zxd.forrun.service.TopicService;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.net.InetAddress;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 回复管理
 */
@Controller
@RequestMapping("/post")
public class PostController {

    @Autowired
    private PostService postService;
    @Autowired
    private TopicService topicService;

    /**
     * 使用分页查找回复信息
     * @param model
     * @param topicId
     * @param start
     * @param total
     * @param childStart
     * @return
     */

    @RequestMapping("/post/{topicId}")
    public String toPost(@RequestParam(required = false) Integer sectionId, Model model, @PathVariable Integer topicId,
                         @RequestParam(defaultValue = "1") Integer start,
                         @RequestParam(defaultValue = "10") Integer total,
                         Integer childStart){
        //TODO : 有未完成的查询条件查询功能

        PageInfo<TopicCus> postListAndChild = postService.getPostListAndChild(start, total, topicId, childStart);
        model.addAttribute("postList", postListAndChild);
        model.addAttribute("sectionId", sectionId);
        return "admin/main/post";
    }

    @RequestMapping("/click")
    public @ResponseBody ResultCode click(@RequestParam(required = true) Integer postId){
        Post postById = postService.getPostById(postId);
        if(postById==null)
            return new ResultCode(0,0,"对不起点赞失败");
        postService.updateClick(postById);

        return new ResultCode(1,1,"点赞成功");
    }

    /**
     * 添加一个回复
     * @param topicId
     * @param post
     * @param parentId
     * @return
     * @throws ParseException
     */
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public @ResponseBody ResultCode add(@RequestParam(required = true) Integer topicId, Post post, Integer parentId) throws ParseException {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date formatdate = new Date();
        String dateStr = simpleDateFormat.format(formatdate);
        Date date = simpleDateFormat.parse(dateStr);
        if(post.getTopicId()==null)
            return new ResultCode(0,0,"对不起找不到主题");
        Post npost = new Post();
//        System.out.println("===="+post+"=======");
        BeanUtils.copyProperties(post, npost);
        npost.setClick(0);
        String ip = null;
        try {
            ip = InetAddress.getLocalHost().getHostAddress().toString();
        }catch (Exception e){
            return new ResultCode(0 , 0, "非法访问!");
        }
        Users u = (Users)SecurityUtils.getSubject().getPrincipal();
        npost.setIpaddr(ip);
        npost.setAuthor(u.getId());
        npost.setCreateDate(date);
        npost.setLastUpdate(date);
        npost.setTopicId(topicId);
        if(parentId!=null && postService.getPostById(parentId)!=null)
            npost.setParentId(parentId);
        try {
            postService.add(topicId, npost);
            //更新对应主题信息
            Topic topic = topicService.getTopicById(topicId);
            topic.setLastUpdate(date);
            topic.setPostCount(topic.getPostCount()+1);
            topicService.updateTopic(topic);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultCode(0,0,"添加失败");
        }
        return new ResultCode(1,1,"回复成功");
    }

    /**
     * 删除一个回复
     * @param id
     * @return
     */
    public ResultCode delete(Integer id){
        // TODO:该部分功能尚未完善
        return null;
    }

}
