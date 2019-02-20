package com.zxd.forrun.service;

import com.zxd.forrun.pojo.Album;
import com.zxd.forrun.pojo.Photo;
import com.zxd.forrun.pojo.vo.PageInfo;

import java.util.List;

public interface AlbumService {
    /**
     * 批量添加图片
     * @param photoList
     */
    void addPhoto(List<Photo> photoList) throws Exception;

    /**
     * 添加一个相册并且返回最新的id
     * @param newalbum
     * @return
     * @throws Exception
     */
    Integer addAlbum(Album newalbum) throws Exception;

    /**
     * 查找用户所有的相册
     * @param id
     * @return
     */
    PageInfo<Album> findAlbumByUserId(Integer start, Integer total, Integer id);

    /**
     * 根据相册获取id
     * @param albumId
     * @return
     */
    List<Photo> findPhotos(Integer albumId) throws Exception;
}
