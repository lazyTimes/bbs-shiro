package com.zxd.forrun.controller.section;

import com.zxd.forrun.pojo.TopicCategory;
import com.zxd.forrun.pojo.po.PostCus;
import com.zxd.forrun.pojo.po.SectionCus;
import com.zxd.forrun.pojo.po.TopicCus;
import com.zxd.forrun.pojo.vo.PageInfo;
import com.zxd.forrun.service.PostService;
import com.zxd.forrun.service.SectionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
@RequestMapping("/section")
public class SectionController {
    @Autowired
    private SectionService sectionService;
    @Autowired
    private PostService postService;

    /**
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "/main", method = RequestMethod.GET)
    public String main(Model model){
        List<SectionCus> sectionCuses = sectionService.sectionList();
        // 查找按时间排序的三个最新回复
        PageInfo<PostCus> posts = postService.getLastPosts();
        model.addAttribute("sections", sectionCuses);
        model.addAttribute("lastposts", posts);
        return "admin/main/main";
    }

    /**
     * 查找某个板块下面的内容
     * @param start
     * @param total
     * @param sectionId
     * @param categoryId
     * @param model
     * @param topicName
     * @return
     */
    @RequestMapping(value = "/sec/{sectionId}", method = RequestMethod.GET)
    public String section(@RequestParam(defaultValue = "1") Integer start,@RequestParam(defaultValue = "20") Integer total,
                          @PathVariable Integer sectionId, Integer categoryId, Model model, String topicName){
        //查看是否为空
        if(sectionId==null)
            return "admin/error/error";
//        System.out.println(sectionId);
        PageInfo<TopicCus> topicBySectionId = null;
        try {
            topicBySectionId = sectionService.getTopicBySectionId(start, total, sectionId, categoryId);
        }catch (Exception e){
            return "admin/error/error";
        }
        String categoryName;
        //查找分类名称
        List<TopicCategory> topicCategoryList = null;
        if(topicBySectionId != null && topicBySectionId.getPageList().size()>0) {
            TopicCus topicCus = topicBySectionId.getPageList().get(0);

            categoryName = sectionService.getTopicCategoryName(topicCus.getType());
//            System.out.println("获取"+topicCus.getSectionId());
            topicCategoryList = sectionService.getTopicCategoryList(topicCus.getSectionId());
            //传递数据到页面
            model.addAttribute("categoryName", categoryName);
            model.addAttribute("categoryList", topicCategoryList);
            model.addAttribute("sectionId", topicBySectionId.getPageList().get(0).getSectionId());
        }

        model.addAttribute("topics", topicBySectionId);
//        System.out.println("是否有数据"+topicBySectionId);
        return "admin/main/topic";
    }



}
