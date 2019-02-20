package com.zxd.forrun.mapper;

import com.zxd.forrun.pojo.PermissionRole;
import com.zxd.forrun.pojo.PermissionRoleExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface PermissionRoleMapper {
    long countByExample(PermissionRoleExample example);

    int deleteByExample(PermissionRoleExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(PermissionRole record);

    int insertSelective(PermissionRole record);

    List<PermissionRole> selectByExample(PermissionRoleExample example);

    PermissionRole selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") PermissionRole record, @Param("example") PermissionRoleExample example);

    int updateByExample(@Param("record") PermissionRole record, @Param("example") PermissionRoleExample example);

    int updateByPrimaryKeySelective(PermissionRole record);

    int updateByPrimaryKey(PermissionRole record);
}