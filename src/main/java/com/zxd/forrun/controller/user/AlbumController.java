package com.zxd.forrun.controller.user;

import com.zxd.forrun.pojo.Album;
import com.zxd.forrun.pojo.Photo;
import com.zxd.forrun.pojo.Users;
import com.zxd.forrun.pojo.vo.ImgResult;
import com.zxd.forrun.pojo.vo.PageInfo;
import com.zxd.forrun.pojo.vo.ResultCode;
import com.zxd.forrun.service.AlbumService;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/img")
public class AlbumController {
    @Autowired
    private AlbumService albumService;


    /**
     * 跳转到上传页面
     * @return
     */
    @RequestMapping(value = "/upload", method = RequestMethod.GET)
    public String upload(Model model){
        return "admin/user/album";
    }

    /**
     * 文件上传的处理操作
     * @param file 文件处理
     * @param request
     * @return
     */
    @SuppressWarnings("deprecation")
    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    public @ResponseBody ImgResult upload(MultipartFile file, HttpServletRequest request){

        String desFilePath = "";
        String oriName = "";
        ImgResult result = new ImgResult();
        Map<String, String> dataMap = new HashMap<String, String>();
        ImgResult imgResult = new ImgResult();

        try {
            Users user = (Users)SecurityUtils.getSubject().getPrincipal();

            // 1.获取原文件名
            oriName = file.getOriginalFilename();
            // 2.获取原文件图片后缀，以最后的.作为截取(.jpg)
            String extName = oriName.substring(oriName.lastIndexOf("."));
            // 3.生成自定义的新文件名，这里以UUID.jpg|png|xxx作为格式（可选操作，也可以不自定义新文件名）
            String uuid = UUID.randomUUID().toString();
            String newName = uuid + extName;
            // 4.获取要保存的路径文件夹 使用 用户名/相册名/照片存储
            String realPath = request.getRealPath("resources/upload/");
            //创建文件夹
            File folder = new File(realPath);
            if(!folder.exists()){
                folder.mkdir();
            }
            // 5.保存
            desFilePath = realPath + "\\" + newName;
            File desFile = new File(desFilePath);

            file.transferTo(desFile);
            System.out.println(desFilePath);
            // 数据操作
            // 6.返回保存结果信息
            result.setCode(0);
            dataMap = new HashMap<String, String>();
            dataMap.put("src", "resources/upload/" +newName);
            result.setData(dataMap);
            result.setMsg(oriName + "上传成功！");
            return result;
        } catch (IllegalStateException e) {
            imgResult.setCode(1);
            System.out.println(desFilePath + "图片保存失败");
            return imgResult;
        } catch (IOException e) {
            imgResult.setCode(1);
            System.out.println(desFilePath + "图片保存失败--IO异常");
            return imgResult;
        }
    }

    /**
     * 用户个人相册的查找
     * @param start
     * @param total 默认分5
     * @param model
     * @return
     */
    @RequestMapping(value = "/albumpage", method = RequestMethod.GET)
    public String albumpage(@RequestParam(defaultValue = "1") Integer start, @RequestParam(defaultValue = "5") Integer total, Model model){
        Users user = (Users) SecurityUtils.getSubject().getPrincipal();
        if(user==null)
            return "admin/login/login";
        //查找当前用户下所有的相册
        PageInfo<Album> albumByUserId = albumService.findAlbumByUserId(start, total, user.getId());
        model.addAttribute("albums", albumByUserId);
        model.addAttribute("username", user.getUsername());
        return "admin/user/albumpage";
    }

    /**
     * 相册下所有图片信息
     * @param albumId
     * @param model
     * @return
     */
    @RequestMapping(value = "/albumitems", method = RequestMethod.GET)
    public String albumitems(Integer albumId, Model model){
        try {
            List<Photo> photos = albumService.findPhotos(albumId);
            model.addAttribute("photos", photos);
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/img/albumpage";
        }
        return "admin/user/albumitems";

    }

    /**
     * 相册以及相册下面对应相片的保存处理
     * @param album
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "/phoupload", method = RequestMethod.POST)
    public @ResponseBody ResultCode phoUpload( Album album) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date formatdate = new Date();
        String dateStr = simpleDateFormat.format(formatdate);
        Date date = null;
        Users user = (Users) SecurityUtils.getSubject().getPrincipal();

        try {
            date = simpleDateFormat.parse(dateStr);
        } catch (ParseException e) {
            e.printStackTrace();
            return new ResultCode(0,0,"非法操作!");
        }
        String[] split = null;
        Album newalbum = new Album();
        BeanUtils.copyProperties(album, newalbum);

        if(album.getUrl()!=null && album.getUrl().length()>0) {
            split = album.getUrl().split(",");
            newalbum.setFrontCover(split[0]);
            newalbum.setUserId(user.getId());
            newalbum.setUrl(split[0]);
        }else{
            return new ResultCode(0,0,"请至少上传一张扸");
        }

        //相册保存
        newalbum.setCreateDate(date);
//        System.out.println(newalbum);
        Integer integer = null;
        try {
            integer = albumService.addAlbum(newalbum);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultCode(0,0,"保存失败!请重试");
        }

        if(integer==null)
            return new ResultCode(0,0,"保存失败!请重试");

        //使用图片创建
        List<Photo> photoList = new ArrayList<Photo>();
        for(String ul : split){
            Photo photo = new Photo();
            photo.setAlbumId(integer);
            photo.setUserId(user.getId());
            photo.setUrl(ul);
            photo.setCreateDate(date);
            photo.setTitle(ul);
            photo.setIntroduce("-------------");
            System.out.println(photo);
            photoList.add(photo);

        }
        //批量添加图片
        try {

            albumService.addPhoto(photoList);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultCode(0,0,"保存失败!请重试");
        }

        return new ResultCode(1,1,"我在测试中");
    }
}
