<%--
  Created by IntelliJ IDEA.
  User: zxd
  Date: 2018/10/25
  Time: 23:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../command/command.jsp"%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <%--<link rel="icon" href="../../../../favicon.ico">--%>

    <title>申请加精</title>

    <!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/resources/lib/bootstrap-4.1.3-dist/css/bootstrap.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/resources/css/dashboard2.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container-fluid">
    <%@include file="../main/top.jsp"%>
    <div class="row">
        <%@include file="../../command/centercommand.jsp"%>

        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 pt-3 px-4">
            <div class="card">
                <div class="card-header">
                    ....
                </div>
                <div class="card-body">
                    <form id="forms" method="post">
                        <input name="title" value="${topic.title}" type="hidden" />
                        <h5>申请加精</h5>
                        <input class="form-control form-control-lg" type="text" readonly placeholder="标题: ${topic.title}">
                        <input class="form-control form-control-lg" type="text" readonly placeholder="内容: ${topic.content}">
                        <div class="form-group">

                            <h6 for="exampleInputEmail1">加精理由</h6>
                            <textarea  required class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" name="content" placeholder="加精理由"></textarea>
                            <small id="emailHelp"  class="form-text text-muted">请认真填写加精理由</small>
                        </div>


                        <button type="submit" class="btn btn-primary">提交</button>
                    </form>
                </div>
            </div>
        </main>
    </div>
</div>
</body>
<%@include file="../../command/commandJS.jsp"%>
<script>window.jQuery || document.write('<script src="../../../../assets/js/vendor/jquery-slim.min.js"><\/script>')</script>
<script src="${pageContext.request.contextPath}/resources/js/popper.js"></script>
<script src="${pageContext.request.contextPath}/resources/lib/bootstrap-4.1.3-dist/js/bootstrap.js"></script>

<!-- Icons -->
<script src="https://unpkg.com/feather-icons/dist/feather.min.js"></script>
<script>

    $(function () {
        feather.replace();
        $("#forms").submit(function () {
            $.post("${pageContext.request.contextPath}/topic/sentGreat",$("#forms").serialize() ,function(data){
                if(data.message){
                    alert(data.message);

                    location.href = "${pageContext.request.contextPath}/user/center/allTopic";
                    // window.location.reload();
                }else{
                    alert("必须登录之后才能操作");
                    location.href = "${pageContext.request.contextPath}/user/login";
                }
            });
            return false;
        });
    });


    function subs(){



    }
</script>

</html>
