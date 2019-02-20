package com.zxd.forrun.service.impl;

import com.zxd.forrun.mapper.UserMapperCustom;
import com.zxd.forrun.mapper.UsersMapper;
import com.zxd.forrun.pojo.Users;
import com.zxd.forrun.pojo.UsersExample;
import com.zxd.forrun.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Set;

@Service
@Transactional
public class UserServiceimpl implements UserService {
    @Autowired
    private UsersMapper userMapper;
    @Autowired
    private UserMapperCustom userMapperCustom;


    public Users getUserById(int id) {
        return userMapper.selectByPrimaryKey(id);
    }

    public Users getUserByName(String name) {
        UsersExample userExample = new UsersExample();
        UsersExample.Criteria criteria = userExample.createCriteria();
        criteria.andUsernameEqualTo(name);
        List<Users> users = userMapper.selectByExample(userExample);
        if(users!=null && users.size()>0)
            return users.get(0);
        return null;

    }

    public Set<String> getRoles(String name) {
        Users userByName = getUserByName(name);
        if(userByName==null)
            throw new RuntimeException("没有找到对应用户");
        Set<String> roles = (Set<String>) userMapperCustom.findRoles(name);
        return roles;
    }



    public Set<String> getPermissions(String name) {
        Users userByName = getUserByName(name);
        if(userByName==null)
            throw new RuntimeException("没有找到对应用户");
        Set<String> permissions = userMapperCustom.findPermissions(name);
        return permissions;
    }


    public Set<String> getPermissionByRolename(String rolename) {
        Set<String> permissionsByRole = userMapperCustom.findPermissionsByRole(rolename);
        return permissionsByRole;
    }

    public void add(Users user) {
        Users userByName = getUserByName(user.getUsername());
        if(userByName != null)
            throw new RuntimeException("对不起，用户已经存在");

        userMapper.insertSelective(user);


    }

    public Users check(String username, String password) {
        UsersExample userExample = new UsersExample();
        UsersExample.Criteria criteria = userExample.createCriteria();
        criteria.andUsernameEqualTo(username);
        criteria.andPasswordEqualTo(password);
        List<Users> users = userMapper.selectByExample(userExample);
        if(users!=null && users.size()>0)
            return users.get(0);
        return null;
    }

    public Users getUserByTelephone(String telephone) {
        UsersExample userExample = new UsersExample();
        UsersExample.Criteria criteria = userExample.createCriteria();
        criteria.andTelephoneEqualTo(telephone);
        List<Users> users = userMapper.selectByExample(userExample);
        if(users!=null && users.size()>0)
            return users.get(0);
        return null;

    }

    public void update(Users login) {
        userMapper.updateByPrimaryKeySelective(login);
    }


}
