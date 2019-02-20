package com.zxd.forrun.controller.system;

import com.zxd.forrun.pojo.*;
import com.zxd.forrun.pojo.po.MessageCus;
import com.zxd.forrun.pojo.po.TopicCategoryCus;
import com.zxd.forrun.pojo.po.TopicCusAll;
import com.zxd.forrun.pojo.vo.PageInfo;
import com.zxd.forrun.pojo.vo.ResultCode;
import com.zxd.forrun.service.*;
import org.apache.shiro.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/sys")
public class system {
    @Autowired
    private SystemService systemService;
    @Autowired
    private SectionService sectionService;
    @Autowired
    private MessageService messageService;
    @Autowired
    private TopicCategoryService topicCategoryService;
    @Autowired
    private TopicService topicService;
    @Autowired
    private PostService postService;

    private final Logger logger = LoggerFactory.getLogger(getClass());

    /**
     * 版块管理页面跳转
     * @param model
     * @return
     */
    @RequestMapping(value = "/sectionmanager", method = RequestMethod.GET)
    public String sectionmanager(Model model){
        //查询所有版块信息
        List<Section> sectionList = systemService.getSectionList();
        model.addAttribute("sectionList", sectionList);
        return "manager/sectionmanager";
    }

    /**
     * 查找所有版块的分类
     * @return
     */
    @RequestMapping(value = "/sectioncategorymanager", method = RequestMethod.GET)
    public String sectioncategorymanager(Model model){
        List<TopicCategoryCus> topicCategroyCusList = topicCategoryService.findTopicCategroyCusList();
        model.addAttribute("topiccus", topicCategroyCusList);
        return "manager/topicCatetorymanager";

    }

    /**
     * 分类添加
     * @param topicCategory
     * @return
     */
    @RequestMapping(value = "/sectioncategorymanager/add", method = RequestMethod.POST)
    public @ResponseBody ResultCode sectioncategorymanagerAdd(TopicCategory topicCategory){
        TopicCategory nes = new TopicCategory();
        BeanUtils.copyProperties(topicCategory, nes);
        if(topicCategory.getCategoryName().equals(""))
            return new ResultCode(0,0,"分类名称不能为空");
        nes.setCategoryCount(0);
        nes.setImage("xxxx");
        Integer code = topicCategoryService.add(nes);
        if(code==1)
            return new ResultCode(1,1,"添加成功");
        else
            return new ResultCode(0,0,"添加失败");
    }

    /**
     * 分类修改
     * @param categoryName
     * @param id
     * @return
     */
    @RequestMapping(value = "/sectioncategorymanager/edit")
    public @ResponseBody ResultCode sectioncategorymanagerEdit(@RequestParam("categoryName") String categoryName,@RequestParam("id") Integer id){
        TopicCategory topicCategory = topicCategoryService.getById(id);
        if(topicCategory==null)
            return new ResultCode(0,0,"修改失败");
        topicCategory.setCategoryName(categoryName);
        Integer code = topicCategoryService.update(topicCategory);
        if(code==1)
            return new ResultCode(1,1,"修改成功");
        else
            return new ResultCode(0,0,"修改失败");
    }

    /**
     * 分类删除
     * @param id
     * @return
     */
    @RequestMapping("/sectioncategorymanager/delete")
    public @ResponseBody ResultCode delete(@RequestParam("id") Integer id){
        TopicCategory byId = topicCategoryService.getById(id);
        if(byId==null)
            return new ResultCode(0,0,"删除失败");
        Integer code = 0;
        try {
            code =topicCategoryService.delete(id);
        }catch (Exception e){
            return new ResultCode(0,0,"当前分类已存在主题");
        }
        if(code==1)
            return new ResultCode(1,1,"删除成功");
        else
            return new ResultCode(0,0,"删除失败");
    }

    /**
     * 版块修改
     */
    @RequestMapping(value = "/sectionmanager/edit", method = RequestMethod.POST)
    public @ResponseBody ResultCode sectionmanagerEdit(@RequestParam("sectionId") Integer sectionId, @RequestParam("name") String name){
        Section sectionById = sectionService.getSectionById(sectionId);
        if(sectionById==null){
            return new ResultCode(0,0,"修改失败");
        }
        if(name.equals(""))
            return new ResultCode(0,0,"没有做任何修改操作");
        System.out.println("+++++++++++++++++++++++++++++++++++++++++++name = " + name);
        sectionById.setSectionName(name);
        try {
            sectionService.updateSection(sectionById);
        }catch (Exception e){
            logger.error("版块修改失败");
            return new ResultCode(0,0,"修改失败,请重试");
        }
        return new ResultCode(1,1,"修改成功");
    }

    /**
     * 版块添加
     * @param section
     * @return
     * @throws ParseException
     */
    @RequestMapping(value = "/sectionmanager/add")
    public @ResponseBody ResultCode sectionmanagerAdd(Section section) throws ParseException {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date formatdate = new Date();
        String dateStr = simpleDateFormat.format(formatdate);
        Date date = simpleDateFormat.parse(dateStr);
        Section newsection = new Section();
        BeanUtils.copyProperties(section, newsection);
        // 获取当前用户:默认为admin超级管理员
        Users user = (Users)SecurityUtils.getSubject().getPrincipal();
        newsection.setAuthor(user.getId());
        newsection.setOrderid(1);
        newsection.setAllCount(0);
        newsection.setTopicCount(0);
        newsection.setTopicLastupdate(date);
        Integer sectionId = null;
        try {
            sectionService.addSection(newsection);
            sectionId = sectionService.getSectionGeneral();
        }catch (Exception e){
            return new ResultCode(0,0,"添加失败");
        }
        return new ResultCode(1,sectionId,"添加成功");

    }

    @RequestMapping("/messagemanager")
    public String messagemanager(@RequestParam(defaultValue = "1") Integer start, @RequestParam(defaultValue = "20") Integer total, Model model){
        Users local = (Users) SecurityUtils.getSubject().getPrincipal();

        try {
            if(local==null){
                //交由登录控制
                return "redirect:/user/login";
            }
            PageInfo<MessageCus> messageList = messageService.getMessagesByAdminstart(start, total);
            model.addAttribute("messages", messageList);
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/user/login";
        }
        return "manager/messagemanager";
    }

    /**
     * 审核申精要去
     * @param id
     * @param code
     * @return
     */
    @RequestMapping(value = "/messagemanager/pass")
    public @ResponseBody ResultCode messagemanagerPass(Integer id, Integer code){
        Message message = messageService.getMessageById(id);
        message.setSendState(code);
        Integer update = messageService.update(message);
        if(update==1)
            return new ResultCode(1,1,"完成通过");
        else
            return new ResultCode(0,0,"错误");
    }


    /**
     * 所有B版块主题管理
     * @return
     */
    @RequestMapping(value = "/secitonItem", method = RequestMethod.GET)
    public String secitonItem(@RequestParam(defaultValue = "1") Integer start, @RequestParam(defaultValue = "20") Integer total, Model model){
        PageInfo<TopicCusAll> topicCusAllPageInfo = topicService.getTopicAll(start, total);
        model.addAttribute("topics", topicCusAllPageInfo);
        return "manager/sectionAllmanager";
    }

    @RequestMapping(value = "/sectionItem/update")
    public @ResponseBody ResultCode sectionItemUp(@RequestParam("id") Integer id, @RequestParam("orderId") Integer orderId){
        Topic topicById = topicService.getTopicById(id);
        if(topicById==null){
            return new ResultCode(0,0,"错误");
        }
        topicById.setOrderid(orderId);
        try {
            topicService.updateTopic(topicById);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultCode(0,0,"错误");
        }
        return new ResultCode(1,1,"操作成功");
    }

    /**
     * 先删除所有的回复然后删除对应主题
     * @param id
     * @return
     */
    @RequestMapping(value = "/sectionItem/delete")
    public @ResponseBody ResultCode sectionItemDelete(@RequestParam("id") Integer id){
        Topic tp = topicService.getTopicById(id);
        if(tp==null)
            return new ResultCode(0,0,"错误");
        Integer delete = postService.deleteByTopicId(tp.getId());
        Integer result = 0;
        if (delete==1)
            result = topicService.delete(tp);

        if(result==1)
            return new ResultCode(1,1,"操作成功");
        else
            return new ResultCode(0,0,"操作失败");
    }

}
