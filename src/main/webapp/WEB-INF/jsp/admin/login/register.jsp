<%--
  Created by IntelliJ IDEA.
  User: zxd
  Date: 2018/10/18
  Time: 10:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../command/command.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="${pageContext.request.contextPath}/resources/img/bitbug_favicon.ico">

    <title>用户注册</title>

    <!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/resources/lib/bootstrap/css/bootstrap.css" rel="stylesheet">


    <!--[if lt IE 9]>
    <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->



</head>
<body >

<%--登录主页--%>
<div class="container">

    <div class="container">
        <div class="jumbotron">
            <h2>欢迎来到校园趣闻论坛</h2>
            <p>本页面是注册页面</p>
            <p><a class="btn btn-success btn-lg" href="${pageContext.request.contextPath}/user/login" role="button">已有本站用户?现在登录</a></p>
        </div>


    </div>
    <div class="container">
        <form class="form-horizontal" method="post" id="theForm">
            <div class="form-group">
                <label for="input1" class="col-sm-2 control-label">用户名</label>
                <div class="col-sm-5">
                    <input type="text" required minlength="6" maxlength="12" name="username" class="form-control" id="input1" placeholder="username">
                </div>
            </div>
            <div class="form-group">
                <label for="input2" class="col-sm-2 control-label">密码</label>
                <div class="col-sm-5">
                    <input type="password" required minlength="6" maxlength="12" name="password" class="form-control" id="input2" placeholder="password">
                </div>
            </div>

            <div class="form-group">
                <label for="input3" class="col-sm-2 control-label">昵称</label>
                <div class="col-sm-5">
                    <input type="text" required minlength="6" maxlength="12" name="nickname" class="form-control" id="input3" placeholder="nickname">
                </div>
            </div>
            <%--性别--%>
            <div class="form-group">
                <label for="input3" class="col-sm-2 control-label">性别</label>
                <div class="col-sm-3">
                    <select class="form-control"  name="gender">
                        <option value="1">男</option>
                        <option value="2">女</option>

                    </select>
                </div>
            </div>
            <div class="form-group">
                <label for="em" class="col-sm-2 control-label">邮箱<span style="color: gray;">(选填)</span></label>
                <div class="col-sm-5">
                    <input type="email" required name="email" class="form-control" id="em" placeholder="email">
                </div>
            </div>
            <div class="form-group">
                <label for="telephone" class="col-sm-2 control-label">手机号(必填)</label>
                <div class="col-sm-5">
                    <input type="text" required minlength="11" phone=true maxlength="11" name="telephone" class="form-control" id="telephone" placeholder="telephone">
                </div>
            </div>

            <div class="form-group">
                <label for="Address" class="col-sm-2 control-label">地址</label>
                <div class="col-sm-5">
                    <input type="text" required minlength="6" maxlength="12" name="address" class="form-control" id="Address" placeholder="address">
                </div>
            </div>

            <div class="form-group">
                <label for="QQ" class="col-sm-2 control-label">QQ<span style="color: gray;">(选填)</span></label>
                <div class="col-sm-5">
                    <input type="text" name="qq_number" class="form-control" id="QQ" placeholder="qq">
                </div>
            </div>

            <div class="form-group">
                <label for="Question" class="col-sm-2 control-label">问题</label>
                <div class="col-sm-4">
                    <select class="form-control" name="question" id="Question">
                        <option>你的父亲姓名是</option>
                        <option>你的名字是</option>
                    </select>

                </div>
            </div>

            <div class="form-group">
                <label for="Answer" class="col-sm-2 control-label">回答</label>
                <div class="col-sm-5">
                    <input type="text" required name="answer" minlength="3" maxlength="12" class="form-control" id="Answer" placeholder="answer">
                </div>
            </div>



            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-5">
                    <button type="submit"  class="btn btn-danger">注册</button>
                </div>
            </div>

            <div class="form-group" id="errs">
                <div class="col-sm-5 col-sm-offset-2">
                    <ul id="errorcon">

                    </ul>
                </div>
            </div>

        </form>
    </div>
    <!-- 网上拷贝alert样式 -->
    <div class="modal fade" id="alertModalId" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" style="z-index: 9999">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title text-center" id="myModalLabel">操作结果</h4>
                </div>
                <div class="modal-body">
                    <p id="alertContentId" class="text-center"></p>
                </div>
            </div>
        </div>
    </div>

</div>
</body>
<%@include file="../../command/commandJS.jsp"%>
<script>
    $(function(){
        window.alert = function(msg){
            $("#alertContentId").html(msg);
            $("#alertModalId").modal('show');
            setTimeout('$("#alertModalId").modal("hide")',2000);
        };


        //注册方式验证
        $('#theForm').submit(function () {
            $.post("${pageContext.request.contextPath}/user/register", $("#theForm").serialize(),function(data){
                if (data.type == 1) {
                    alert("注册成功，现在赶紧登陆吧！！！");
                    setTimeout(function () {
                        location.href = "${pageContext.request.contextPath}/user/login";
                    }, 1000);


                } else {
                    alert("注册失败，原因是：" + data.message);
                }
            });
            return false;
        });



    });

</script>
</html>
