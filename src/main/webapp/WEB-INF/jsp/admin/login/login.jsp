<%--
  Created by IntelliJ IDEA.
  User: zxd
  Date: 2018/10/18
  Time: 10:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="${pageContext.request.contextPath}/resources/img/bitbug_favicon.ico">

    <title>登录页面</title>

    <!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/resources/lib/bootstrap/css/bootstrap.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->


</head>
<body>

<%--登录主页--%>
<div class="container">

    <div class="container">
        <div class="jumbotron">
            <h2>欢迎来到校园趣闻论坛</h2>
            <p>本平台基于学习使用</p>
            <p><a class="btn btn-primary btn-lg" href="${pageContext.request.contextPath}/user/register" role="button">马上注册</a></p>
        </div>
    </div>

    <%--登录模块--%>
    <form id="loginsub"  method="post" class="form-horizontal">
        <div class="form-group">
            <label for="inputEmail3" class="col-sm-2 control-label">用户名</label>
            <div class="col-sm-10">
                <input type="text" name="username" class="form-control" minlength="4" required id="inputEmail3" placeholder="请输入用户名">
            </div>
        </div>
        <div class="form-group">
            <label for="inputPassword3"  class="col-sm-2 control-label">密码</label>
            <div class="col-sm-10">
                <input type="password" name="password" class="form-control" id="pass" required minlength="6" id="inputPassword3" placeholder="请输入密码">
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-10">
                <div class="checkbox">
                    <label>
                        <input type="checkbox"> 记住我
                    </label>
                </div>
            </div>
        </div>
        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-12">
                <button type="subm<it" class="btn btn-danger">登录</button>

            </div>
        </div>
    </form>


</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/lib/jquery/dist/jquery.js"></script>

<script type="text/javascript">
    $(function () {
        $('#loginsub').submit(function () {
            $.post("${pageContext.request.contextPath}/user/login", $("#loginsub").serialize(),function(data){
                if (data.type == 0) {
                    alert("登录失败，原因是：" + data.message);
                } else {
                    location.href = "${pageContext.request.contextPath}/section/main";
                }
            });
            return false;
        });
    });

</script>
</body>
</html>
