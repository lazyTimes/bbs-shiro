package com.zxd.forrun.shiro;

import com.zxd.forrun.pojo.Users;
import com.zxd.forrun.service.UserService;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Set;

/**
 * 自定义角色验证规则
 */
public class MyRealm extends AuthorizingRealm {

    @Autowired
    private UserService userService;

    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        System.out.println("验证");
        Users user = (Users)principalCollection.getPrimaryPrincipal();
        System.out.println("用户名"+user.getUsername());
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo() ;

        try{
            Set<String> roleName = userService.getRoles(user.getUsername()) ;
            Set<String> permissions = userService.getPermissions(user.getUsername()) ;
            System.out.println("================");
            System.out.println(permissions);
            System.out.println("================");
            System.out.println("================");
            System.out.println(roleName);
            System.out.println("================");

            info.setRoles(roleName);
            info.setStringPermissions(permissions);
        } catch (Exception e){
            e.printStackTrace();
            return null;
        }
        return info;
//        return null;
    }

    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        //获取用户账号
        String username = token.getPrincipal().toString() ;
        System.out.println(username);
        Users user = userService.getUserByName(username);
        if (user != null){
            System.out.println("验证成功");
            //将查询到的用户账号和密码存放到 authenticationInfo用于后面的权限判断。第三个参数传入realName。
            AuthenticationInfo authenticationInfo = new SimpleAuthenticationInfo(user,user.getPassword(),
                    "a") ;
            return authenticationInfo ;
        }else {
            System.out.println("验证失败");
            return null;
        }

    }
}
