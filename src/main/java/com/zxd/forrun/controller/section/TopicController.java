package com.zxd.forrun.controller.section;

import com.zxd.forrun.pojo.*;
import com.zxd.forrun.pojo.vo.ResultCode;
import com.zxd.forrun.service.*;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.net.InetAddress;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@RequestMapping("/topic")
@Controller
public class TopicController {
    @Autowired
    private SectionService sectionService;
    @Autowired
    private PostService postService;
    @Autowired
    private TopicService topicService;
    @Autowired
    private UserService userService;
    @Autowired
    private MessageService messageService;


    

    /**
     * 添加一个新主题
     * 需要参数
     *      版块id
     * @param model
     * @param
     * @return
     */
    @RequestMapping(value = "/add", method = RequestMethod.GET)
    public String toAddSection(Model model, Integer sectionId){
        //获取session信息W
        Users u = (Users)SecurityUtils.getSubject().getPrincipal();
        //获取分裂
        List<TopicCategory> topicCategoryList = sectionService.getTopicCategoryList(sectionId);
        model.addAttribute("username", u.getUsername());
        model.addAttribute("sectionId", sectionId);
        model.addAttribute("cateList", topicCategoryList);
        return "/admin/main/topicSend";
    }

    /**
     * 添加一条回复
     * @param model
     * @param topic
     * @param sectionId
     * @param categoryId
     * @param httpServletRequest
     * @return
     * @throws ParseException
     */
    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public @ResponseBody
    ResultCode addSection(Model model, Topic topic, Integer sectionId,
                          @RequestParam(defaultValue = "1") Integer categoryId, HttpServletRequest httpServletRequest) throws ParseException {
        System.out.println(sectionId);
        if(topic!=null && topic.getTitle()!=null &&  topic.getTitle().trim().equals("")){
            return new ResultCode(0 , 0, "标题不能为空");
        }
        if(topic!=null && topic.getContent()!=null && topic.getContent().trim().equals("")){
            return new ResultCode(0 , 0, "内容不能为空");
        }

        String ip = null;
        try {
            ip = InetAddress.getLocalHost().getHostAddress().toString();
        }catch (Exception e){
            return new ResultCode(0 , 0, "非法访问!");
        }
//        System.out.println(sectionById);

        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date formatdate = new Date();
        String dateStr = simpleDateFormat.format(formatdate);
        Date date = simpleDateFormat.parse(dateStr);
        //创建主题
        Topic tnew = new Topic();
        BeanUtils.copyProperties(topic, tnew);
        Users u = (Users) SecurityUtils.getSubject().getPrincipal();
        tnew.setAuthor(u.getId());
        tnew.setIpaddr(ip);
        tnew.setCreateDate(date);
        tnew.setLastUpdate(date);
        tnew.setType(categoryId);
        tnew.setPostCount(1);
        tnew.setOrderid(0);

        // 修改版块信息
        Section sectionById = sectionService.getSectionById(sectionId);
        sectionById.setAllCount(sectionById.getAllCount()+1);
        sectionById.setTopicCount(sectionById.getTopicCount()+1);
        sectionById.setTopicLastupdate(date);

        //插入回复信息
        Post post = new Post();
        post.setTopicId(tnew.getId());
        post.setAuthor(u.getId());
        post.setCreateDate(date);
        post.setLastUpdate(date);
        post.setContent(tnew.getContent());
        post.setTitle(tnew.getTitle());
        post.setClick(0);
        post.setIpaddr(ip);
        //统一处理业务
        try {
            sectionService.addTopic(tnew);
            // 获取自增主键
            Integer generalId = topicService.getGeneralId();
            postService.add(generalId, post);
            sectionService.updateSection(sectionById);

            //更新分类
            topicService.updateTopicCategory(categoryId);

        } catch (Exception e) {
            e.printStackTrace();
            return new ResultCode(0,0,"添加失败");
        }
        return new ResultCode(1,1,"添加成功");
    }


    /**
     * 申请加精请求
     * @param message
     * @return
     * @throws ParseException
     */
    @RequestMapping(value = "/sentGreat",method = RequestMethod.POST)
    public @ResponseBody ResultCode sentGreat(Message message, String title) throws ParseException {
        Message msg = new Message();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date formatdate = new Date();
        String dateStr = simpleDateFormat.format(formatdate);
        Date date = simpleDateFormat.parse(dateStr);
        Users local = (Users) SecurityUtils.getSubject().getPrincipal();
        if(local==null)
            return new ResultCode(0,0,"您还没有登录，请登录后重试");

        try {

            //获取管理员
            Users admin = userService.getUserByName("admin");
            BeanUtils.copyProperties(message, msg);
            //默认为发送成功
            msg.setSendState(2);
            msg.setSendTime(date);
            msg.setRecId(admin.getId());
            msg.setSendId(local.getId());
            msg.setContent(title+" : "+msg.getContent());
            messageService.addSenderMessages(msg);
        }catch (Exception e){
            msg.setSendState(0);
            return new ResultCode(0,0,"发送失败");
        }

        return new ResultCode(1,1,"发送成功");
    }
}
