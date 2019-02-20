package com.zxd.forrun.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.zxd.forrun.mapper.MessageMapper;
import com.zxd.forrun.mapper.MessageMapperCustom;
import com.zxd.forrun.pojo.Message;
import com.zxd.forrun.pojo.MessageExample;
import com.zxd.forrun.pojo.Users;
import com.zxd.forrun.pojo.po.MessageCus;
import com.zxd.forrun.pojo.vo.PageInfo;
import com.zxd.forrun.service.MessageService;
import com.zxd.forrun.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class MessageServiceimpl implements MessageService {

    @Autowired
    private MessageMapper messageMapper;
    @Autowired
    private UserService userService;
    @Autowired
    private MessageMapperCustom messageMapperCustom;

    public void addSenderMessages(Message msg) throws Exception{
        MessageExample messageExample = new MessageExample();

        try {
            messageMapper.insertSelective(msg);
        }catch (Exception e){
            e.printStackTrace();
            throw new RuntimeException("发送失败");
        }
    }

    public PageInfo<Message> getMessagesByUserId(Integer start, Integer total, Integer localId) throws Exception{
        if(localId==null)
            throw new RuntimeException("找不到用户");
        MessageExample messageExample = new MessageExample();
        messageExample.setOrderByClause("send_time DESC");
        MessageExample.Criteria criteria = messageExample.createCriteria();
        criteria.andRecIdEqualTo(localId);
        Page<Object> objects = PageHelper.startPage(start, total);
        List<Message> posts = messageMapper.selectByExampleWithBLOBs(messageExample);
        com.github.pagehelper.PageInfo pageInfo = new com.github.pagehelper.PageInfo(objects);
        PageInfo<Message> pageInfo1 = new PageInfo<Message>(start, total, (int)pageInfo.getTotal(), posts);
        if(posts!=null && posts.size()>0)
            return pageInfo1;
        return null;
    }

    public PageInfo<MessageCus> getMessagesByAdminstart(Integer start, Integer total) {
        Users admin = userService.getUserByName("admin");
        Page<Object> objects = PageHelper.startPage(start, total);
        List<MessageCus> messageCusList = messageMapperCustom.getMessageCusList(admin.getId());
        com.github.pagehelper.PageInfo pageInfo = new com.github.pagehelper.PageInfo(objects);
        PageInfo<MessageCus> pageInfo1 = new PageInfo<MessageCus>(start, total, (int)pageInfo.getTotal(), messageCusList);
        if(messageCusList!=null && messageCusList.size()>0)
            return pageInfo1;
        return null;
    }

    public Message getMessageById(Integer id) {
        return messageMapper.selectByPrimaryKey(id);
    }

    public Integer update(Message message) {
        return messageMapper.updateByPrimaryKeySelective(message);
    }
}
