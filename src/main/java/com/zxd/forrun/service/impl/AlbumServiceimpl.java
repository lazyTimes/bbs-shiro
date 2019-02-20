package com.zxd.forrun.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.zxd.forrun.mapper.AlbumMapper;
import com.zxd.forrun.mapper.PhotoMapper;
import com.zxd.forrun.mapper.AlbumMapperCustom;
import com.zxd.forrun.pojo.Album;
import com.zxd.forrun.pojo.AlbumExample;
import com.zxd.forrun.pojo.Photo;
import com.zxd.forrun.pojo.PhotoExample;
import com.zxd.forrun.pojo.vo.PageInfo;
import com.zxd.forrun.service.AlbumService;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
@Transactional
public class AlbumServiceimpl implements AlbumService {

    @Resource
    private AlbumMapper albumMapper;
    @Autowired
    private AlbumMapperCustom albumMapperCustom;
    @Autowired
    private PhotoMapper photoMapper;

    private static Logger logger = Logger.getLogger(AlbumServiceimpl.class);

    public void addPhoto(List<Photo> photoList) throws Exception{
        for (Photo p : photoList)
            System.out.println(p);
        try {
            for(Photo photo : photoList){
                photoMapper.insertSelective(photo);
            }
        }catch (Exception e){
            throw new RuntimeException("批量添加失败");
        }
        logger.info("批量添加成功");
    }

    public Integer addAlbum(Album newalbum) throws Exception{
        try {
            albumMapper.insertSelective(newalbum);
        }catch (Exception e){
            logger.info("添加失败错误原因是"+e);
            throw new RuntimeException("相册添加失败");
        }
        return albumMapperCustom.getNowAlbumId();
    }



    public PageInfo<Album> findAlbumByUserId(Integer start, Integer total, Integer id) {
        AlbumExample albumExample = new AlbumExample();
        AlbumExample.Criteria criteria = albumExample.createCriteria();
        criteria.andUserIdEqualTo(id);
        Page<Object> objects = PageHelper.startPage(start, total);
        List<Album> albums = albumMapper.selectByExample(albumExample);
        com.github.pagehelper.PageInfo pageInfo = new com.github.pagehelper.PageInfo(objects);
        if(albums!=null && albums.size()>0){
            PageInfo page = new PageInfo(start, total, (int)pageInfo.getTotal(), albums );
            return page;
        }

        return null;
    }

    public List<Photo> findPhotos(Integer albumId) throws Exception{
        if(albumId==null)
            throw  new RuntimeException("找不到相册");
        PhotoExample example = new PhotoExample();
        PhotoExample.Criteria criteria = example.createCriteria();
        criteria.andAlbumIdEqualTo(albumId);
        List<Photo> photos = photoMapper.selectByExample(example);
        if(photos!=null && photos.size()>0)
            return photos;
        return null;
    }
}
