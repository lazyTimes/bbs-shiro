package com.zxd.forrun.mapper;

import com.zxd.forrun.pojo.Photo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AlbumMapperCustom {

    Integer getNowAlbumId();

    /**
     * 批量插入图片
     * @param photos
     */
    void insertPhotoAsList(@Param("photos") List<Photo> photos);
}
