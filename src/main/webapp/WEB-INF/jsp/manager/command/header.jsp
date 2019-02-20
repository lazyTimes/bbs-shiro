<%--
  Created by IntelliJ IDEA.
  User: zxd
  Date: 2018/11/2
  Time: 14:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="layui-header">
    <div class="layui-logo">后台系统</div>
    <!-- 头部区域（可配合layui已有的水平导航） -->
    <ul class="layui-nav layui-layout-left">
        <%--<li class="layui-nav-item"><a href="">控制台</a></li>--%>
        <%--<li class="layui-nav-item"><a href="">商品管理</a></li>--%>
        <%--<li class="layui-nav-item"><a href="">用户</a></li>--%>
        <%--<li class="layui-nav-item">--%>
        <%--<a href="javascript:;">其它系统</a>--%>
        <%--<dl class="layui-nav-child">--%>
        <%--<dd><a href="">邮件管理</a></dd>--%>
        <%--<dd><a href="">消息管理</a></dd>--%>
        <%--<dd><a href="">授权管理</a></dd>--%>
        <%--</dl>--%>
        <%--</li>--%>
    </ul>
    <ul class="layui-nav layui-layout-right">
        <li class="layui-nav-item">
            <a href="javascript:;">
                <img src="http://t.cn/RCzsdCq" class="layui-nav-img">
                admin
            </a>
            <dl class="layui-nav-child">
                <dd><a href="${pageContext.request.contextPath}/user/center">基本资料</a></dd>

            </dl>
        </li>
        <li class="layui-nav-item"><a href="${pageContext.request.contextPath}/section/main">退了</a></li>
    </ul>
</div>
