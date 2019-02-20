<%--
  Created by IntelliJ IDEA.
  User: zxd
  Date: 2018/10/26
  Time: 17:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav class="col-md-2 d-none d-md-block bg-light sidebar">
    <div class="sidebar-sticky">


        <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
            <span>用户个人信息页面</span>
            <a class="d-flex align-items-center text-muted" href="#">
                <span data-feather="plus-circle"></span>
            </a>
        </h6>
        <ul class="nav flex-column mb-2">
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/user/center">
                    <span data-feather="file-text"></span>
                    个人信息详情
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/img/albumpage">
                    <span data-feather="file-text"></span>
                    我的相册
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/user/center/allPost">
                    <span data-feather="file-text"></span>
                    我的回帖
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/user/center/allTopic">
                    <span data-feather="file-text"></span>
                    我发表的主题
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/user/center/receive">
                    <span data-feather="file-text"></span>
                    收信箱
                </a>
            </li>
        </ul>
    </div>
</nav>
