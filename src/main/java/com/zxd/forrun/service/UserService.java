package com.zxd.forrun.service;

import com.zxd.forrun.pojo.Users;
import org.apache.ibatis.annotations.Param;

import java.util.Set;


public interface UserService {

    /**
     * 根据id获取用户信息
     * @param id
     * @return
     */
    Users getUserById(int id);

    /**
     * 获取用户名
     * @param name
     * @return
     */
    Users getUserByName(@Param("name") String name);

    /**
     * 获取用户角色列表
     * @param name
     * @return
     */
    Set<String> getRoles(@Param("name") String name);

    /**
     * 获取用户权限
     * @param name
     * @return
     */
    Set<String> getPermissions(@Param("name") String name);

    /**
     * 根据角色名称查找所有的权限
     * @param rolename
     * @return
     */
    Set<String> getPermissionByRolename(@Param("rolename") String rolename);

    /**
     * 添加用户
     * @param user
     */
    void add(Users user);

    /**
     * 用户登录校验
     * @param username
     * @return
     */
    Users check(String username, String password);

    /**
     * 使用手机号查找用户
     * @param telephone
     */
    Users getUserByTelephone(String telephone);


    /**
     * 更新用户信息
     * @param login
     */
    void update(Users login);
}
