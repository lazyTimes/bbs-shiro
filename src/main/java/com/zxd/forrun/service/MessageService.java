package com.zxd.forrun.service;

import com.zxd.forrun.pojo.Message;
import com.zxd.forrun.pojo.po.MessageCus;
import com.zxd.forrun.pojo.vo.PageInfo;
import org.apache.ibatis.annotations.Param;

public interface MessageService {

    /**
     * 发送一个消息
     * @param msg
     * @throws Exception
     */
    void addSenderMessages(@Param("msg") Message msg) throws Exception;

    /**
     * 分页查找收件箱
     * @param start
     * @param total
     * @param localId
     * @return
     * @throws Exception
     */
    PageInfo<Message> getMessagesByUserId(Integer start, Integer total, Integer localId) throws Exception;

    /**
     * 分页查找管理员邮件
     * @param start
     * @param total
     * @return
     */
    PageInfo<MessageCus> getMessagesByAdminstart(Integer start, Integer total);

    Message getMessageById(Integer id);

    Integer update(Message message);
}
