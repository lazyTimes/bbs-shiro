package com.zxd.forrun.mapper;

import com.zxd.forrun.pojo.po.MessageCus;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MessageMapperCustom {

    List<MessageCus> getMessageCusList(@Param("receiveId") Integer receiveId);
}
