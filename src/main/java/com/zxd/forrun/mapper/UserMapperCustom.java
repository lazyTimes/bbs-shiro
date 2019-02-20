package com.zxd.forrun.mapper;


import org.apache.ibatis.annotations.Param;

import java.util.Set;

public interface UserMapperCustom {

    /**
     * 根据用户名查找用户的角色
     * @param name
     * @return
     */
    Set<String> findRoles(@Param("name") String name);

    /**
     * 根据用户名查找用户角色对应的权限
     * @param name 用户名
     * @return
     */
    Set<String> findPermissions(@Param("rname") String rname);

    /**
     * 根据角色名称查找用户权限
     * @param rolename
     * @return
     */
    Set<String> findPermissionsByRole(@Param("rolename") String rolename);


}
