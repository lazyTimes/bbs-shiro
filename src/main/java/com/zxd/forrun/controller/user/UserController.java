package com.zxd.forrun.controller.user;

import com.zxd.forrun.pojo.*;
import com.zxd.forrun.pojo.vo.PageInfo;
import com.zxd.forrun.pojo.vo.ResultCode;
import com.zxd.forrun.service.MessageService;
import com.zxd.forrun.service.PostService;
import com.zxd.forrun.service.TopicService;
import com.zxd.forrun.service.UserService;
import org.apache.log4j.Logger;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;

@RequestMapping("/user")
@Controller
public class UserController {

    @Autowired
    private UserService userService;
    @Autowired
    private TopicService topicService;
    @Autowired
    private PostService postService;
    @Autowired
    private MessageService messageService;

    private static Logger logger = Logger.getLogger(UserController.class);

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String toLogin(Users user, Model model, HttpServletRequest request){
//        String requestURI = request.getRequestURI();
//        System.out.println(requestURI);
        return "admin/login/login";

    }

    /**
     * 登录
     * @param user
     * @param model
     * @return
     */
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public @ResponseBody ResultCode login(Users user, Model model, HttpServletRequest request){
        logger.info("用球路径为"+request.getRequestURI());
        Subject subject = SecurityUtils.getSubject();
        try {
            Users login = userService.check(user.getUsername(), user.getPassword());
            //登录失败处理
            if(login == null){
                return new ResultCode(0, 0, "用户名或者密码错误");
            }
            //更新登录时间
            login.setLastLogintime(new Date());
            userService.update(login);
            UsernamePasswordToken token = new UsernamePasswordToken(user.getUsername(),user.getPassword()) ;
            subject.login(token);
            return new ResultCode(1, 1, "登录成功");
        }catch (Exception e){
            //这里将异常打印关闭是因为如果登录失败的话会自动抛异常
            return new ResultCode(0, 0, "用户名或者密码错误");
        }

    }

    /**
     * 注册页面
     * @return
     */
    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String toRegister(){
        return "admin/login/register";
    }

    /**
     * 注册处理方法，对于其他字段也进行了一定的校验
     * @param model
     * @param user
     * @return
     */
    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public @ResponseBody ResultCode register(Model model, Users user){
        Date date = new Date();
        user.setRegisterDate(date);
        user.setLastLogintime(date);
        Users userByName = userService.getUserByName(user.getUsername());
        if(null != userByName)
            return new ResultCode(0, 0, "用户名已经存在");

        Users userByTelephone = userService.getUserByTelephone(user.getTelephone());
        if(null != userByTelephone)
            return new ResultCode(0, 0, "手机号已经存在");

        try{
            userService.add(user);
        }catch (Exception e){
            return new ResultCode(0, 0, "注册失败");
        }
        System.out.println("注册成功");
        model.addAttribute("username", user.getUsername());
        return new ResultCode(1, 1, "注册成功");
    }

    /**
     * 用户中心
     * @param model
     * @return
     */
    @RequestMapping(value = "/center", method = RequestMethod.GET)
    public String center(Model model){
        Users user = (Users) SecurityUtils.getSubject().getPrincipal();
        if(user==null)
            return "admin/login/login";
        user.setPassword("");
        model.addAttribute("user", user);
        return "admin/user/center";
    }

    /**
     * 当前用户对应的主题
     * @param start
     * @param total
     * @param model
     * @return
     */
    @RequestMapping(value = "/center/allTopic", method = RequestMethod.GET)
    public String allTopic(@RequestParam(defaultValue = "1") Integer start, @RequestParam(defaultValue = "20") Integer total, Model model){
        Users user = (Users) SecurityUtils.getSubject().getPrincipal();
        PageInfo<Topic> topicList = topicService.getTopicByUserId(start, total, user.getId());
        model.addAttribute("topics", topicList);
        return "admin/user/alltopic";
    }

    /**
     * 当前用户对应的所有回复
     * @param start
     * @param total
     * @param model
     * @return
     */
    @RequestMapping(value = "/center/allPost", method = RequestMethod.GET)
    public String allPost(@RequestParam(defaultValue = "1") Integer start, @RequestParam(defaultValue = "20") Integer total, Model model){
        Users user = (Users) SecurityUtils.getSubject().getPrincipal();
        PageInfo<Post> posts = postService.getPostsByUserId(start, total, user.getId());
        model.addAttribute("posts", posts);
        return "admin/user/allpost";
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(){
        Subject subject = SecurityUtils.getSubject();
        subject.logout();
        return "redirect:/user/login";
    }

    @RequestMapping(value = "/center/messsage", method = RequestMethod.GET)
    public String message(Model model, Integer topicId) {
        Users local = (Users) SecurityUtils.getSubject().getPrincipal();

        if(local==null){
            //交由登录控制
            return "redirect:/user/login";
        }else if(topicId==null){
            return "admin/error/error";
        }
        Topic topicById = topicService.getTopicById(topicId);
        //获取管理员
        Users admin = userService.getUserByName("admin");

        model.addAttribute("topic", topicById);
        model.addAttribute("local", local.getUsername());
        model.addAttribute("admin", admin.getUsername());
        return "admin/user/message";


    }

    /**
     * 申请加精信息查看
     * @param start
     * @param total
     * @param model
     * @return
     */
    @RequestMapping(value = "/center/receive", method = RequestMethod.GET)
    public String receive(@RequestParam(defaultValue = "1") Integer start, @RequestParam(defaultValue = "20") Integer total, Model model){
        Users local = (Users) SecurityUtils.getSubject().getPrincipal();
        try {
            if(local==null){
                //交由登录控制
                return "redirect:/user/login";
            }
            PageInfo<Message> messageList = messageService.getMessagesByUserId(start, total, local.getId());
            model.addAttribute("messages", messageList);
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/user/login";
        }
        return "admin/user/receive";
    }

}
