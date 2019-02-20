package com.zxd.forrun.mapper;

import com.zxd.forrun.pojo.po.PostCus;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface PostMapperCustom {

    List<PostCus> getPostList(@Param("topicId") Integer topicId);

    List<PostCus> getLastPostCusList();
}
