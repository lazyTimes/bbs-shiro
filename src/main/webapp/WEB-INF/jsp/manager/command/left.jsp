<%--
  Created by IntelliJ IDEA.
  User: zxd
  Date: 2018/11/2
  Time: 12:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="layui-side layui-bg-black">
    <div class="layui-side-scroll">
        <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
        <ul class="layui-nav layui-nav-tree"  lay-filter="test">
            <li class="layui-nav-item"><a href="${pageContext.request.contextPath}/sys/sectionmanager">版块管理</a></li>
            <li class="layui-nav-item"><a href="${pageContext.request.contextPath}/sys/sectioncategorymanager">版块分类管理</a></li>
            <li class="layui-nav-item"><a href="${pageContext.request.contextPath}/sys/messagemanager">申请消息</a></li>
            <li class="layui-nav-item"><a href="${pageContext.request.contextPath}/sys/secitonItem">版块内容管理</a></li>
        </ul>
    </div>
</div>