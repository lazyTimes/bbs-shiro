
<%@ page import="com.zxd.forrun.pojo.Users" %>
<%@ page import="org.apache.shiro.SecurityUtils" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Users user = (Users) SecurityUtils.getSubject().getPrincipal();
    if(user!=null)
        request.setAttribute("username", user.getUsername());
%>
<nav class="navbar navbar-expand-md fixed-top navbar-dark bg-dark">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/section/main">校园趣闻论坛</a>
    <button class="navbar-toggler p-0 border-0" type="button" data-toggle="offcanvas">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="navbar-collapse offcanvas-collapse" id="navbarsExampleDefault">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="${pageContext.request.contextPath}/user/center">个人中心<span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">消息</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">反馈</a>
            </li>


            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="http://example.com" id="dropdown01" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">设置</a>
                <div class="dropdown-menu" aria-labelledby="dropdown01">
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/sys/sectionmanager">版块管理</a>
                    <a class="dropdown-item" href="#">系统设置</a>
                    <a class="dropdown-item" href="#">待开发</a>
                </div>
            </li>



            <li class="nav-item">
                <a class="nav-link" href="#">反馈</a>
            </li>
        </ul>

        <div class="dropdown show">
            <a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <c:if test="${username!=null}">
                    欢迎${username}
                </c:if>
                <c:if test="${username==null}">
                    您还没有登录
                </c:if>
            </a>

            <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">

                <c:if test="${username!=null}">
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/user/logout">退出</a>
                </c:if>
                <c:if test="${username==null}">
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/user/login">登录</a>
                </c:if>


            </div>
        </div>
        <form class="form-inline my-2 my-lg-0">
            <input name="topicName" class="form-control mr-sm-2" type="text" placeholder="Search" aria-label="Search">
            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">查找主题</button>
        </form>
    </div>
</nav>
