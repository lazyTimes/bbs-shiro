<%--
  Created by IntelliJ IDEA.
  User: zxd
  Date: 2018/10/23
  Time: 20:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ include file="../../command/command.jsp"%>
<%--<%@ include file="../../command/bootstrap-edit.jsp"%>--%>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <%--<link rel="icon" href="${pageContext.request.contextPath}../../../../favicon.ico">--%>

    <title>趣闻论坛</title>

    <!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/resources/lib/bootstrap-4.1.3-dist/css/bootstrap.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/resources/css/offcanvas.css" rel="stylesheet">
</head>
<body class="bg-light">
<%@ include file="top.jsp"%>
<main role="main" class="container-fluid">


    <section>
        <%--分页--%>
        <div class="row">

            <div class=" offset-md-7 col-md-2">

                <nav aria-label="Page navigation example">
                    <ul class="pagination justify-content-end">
                        <c:if test="${postList.pageNow!=postList.beginPage}">
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/post/post/${postList.pageList.get(0).topicId}?start=${postList.pageNow-1}" tabindex="-1">上一页</a>
                            </li>
                        </c:if>
                        <c:if test="${postList.pageNow==postList.beginPage}">
                            <li class="page-item disabled">
                                <a class="page-link" href="#" tabindex="-1">上一页</a>
                            </li>
                        </c:if>

                        <c:forEach begin="${postList.beginPage}" end="${postList.endPage}" varStatus="be">
                            <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/post/post/${postList.pageList.get(0).topicId}?start=${be.current}">${be.current}</a></li>
                        </c:forEach>

                        <c:if test="${postList.pageNow!=postList.endPage}">
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/post/post/${postList.pageList.get(0).topicId}?start=${postList.pageNow+1}">下一页</a>
                            </li>
                        </c:if>
                        <c:if test="${postList.pageNow==postList.endPage}">
                            <li class="page-item disabled">
                                <a class="page-link" href="#">下一页</a>
                            </li>
                        </c:if>

                    </ul>
                </nav>
            </div>
            <div class="offset-md-2 col-md-4">
                <a href="${pageContext.request.contextPath}/section/sec/${sectionId}" class="btn-danger btn">返回上一步</a>
                <!-- Button trigger modal -->
                <button type="button" class="btn btn-warning" data-toggle="modal" data-target="#exampleModal">
                    发表回复
                </button>
            </div>
        </div>

    </section>
    <%--左边半部分--%>
    <section>
        <c:forEach items="${postList.pageList}" var="po" varStatus="round">



            <div class="container-fluid p-3 offset-md-1">
                <div class="row">
                    <div class="card text-center col-2" style="width: 18rem;">
                        <img class="img-fluid img-thumbnail p-2" src="${pageContext.request.contextPath}/resources/img/back1.jpg" alt="Card image cap">
                        <div class="card-body">
                            <h6 class="card-title">用户名: ${po.user.username}</h6>
                            <%--<p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>--%>
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item">性别:
                                    <c:if test="${po.user.gender == 1}">
                                        男
                                    </c:if>
                                    <c:if test="${po.user.gender == 2}">
                                        女
                                    </c:if>
                                </li>
                                <li class="list-group-item">地址: ${po.user.address}</li>
                                <li class="list-group-item">最后登录时间:
                                    <fmt:formatDate value="${po.user.lastLogintime}" pattern="yyyy-MM-dd HH.mm.ss" />

                                </li>
                            </ul>
                            <div class="card-body">
                                <a href="#" class="card-link">关注</a>
                                <a href="#" class="card-link">发送消息</a>
                            </div>
                        </div>

                    </div>

                    <div class="col-8">
                        <div class="container-fluid">

                            <div class="card">
                                <div class="card-header">
                                        ${po.title}
                                </div>
                                <div class="card-body">
                                    <blockquote class="blockquote mb-0">
                                        <p>
                                           ${po.content}
                                        </p>
                                        <footer >


                                            <button type="button" class="btn btn-primary" onclick="btnclick(${po.id})">
                                               点赞
                                                <span class="badge badge-light">${po.click}</span>

                                            </button>


                                            <!-- Button trigger modal -->
                                            <%--<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#exampleModal">--%>
                                                <%--回复--%>
                                            <%--</button>--%>

                                        </footer>
                                        <footer class="blockquote-footer">
                                            <fmt:formatDate value="${po.createDate}" pattern="yyyy-MM-dd HH.mm.ss" />
                                            <span class="d-block">
                                                ${round.index + 1} 楼
                                            </span>
                                        </footer>

                                        <%--子回复框--%>
                                        <footer>
                                            <c:forEach items="${po.child.pageList}" var="chi">
                                            <div class="card">
                                                <div class="card-header">
                                                        ${chi.title}
                                                </div>
                                                <div class="card-body">
                                                    <h5 class="card-title">
                                                    </h5>
                                                    <p class="card-text">
                                                       ${chi.content}
                                                    </p>
                                                    <footer class="blockquote-footer">
                                                        <fmt:formatDate value="${chi.createDate}" pattern="yyyy-MM-dd HH.mm.ss" />
                                                    </footer>
                                                </div>
                                            </div>
                                            </c:forEach>

                                            <nav aria-label="Page navigation example">
                                                <ul class="pagination">
                                                    <li class="page-item">
                                                        <a class="page-link" href="#">
                                                            页码
                                                        </a>
                                                    </li>
                                                    <c:forEach begin="${po.child.beginPage}" varStatus="in" end="${po.child.endPage}">
                                                        <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/post/post/${postList.pageList.get(0).topicId}?childStart=${in.current}">${in.current}</a></li>
                                                    </c:forEach>

                                                </ul>
                                            </nav>
                                        </footer>
                                        <%--回复栏目--%>
                                        <section>
                                            <div class="card">

                                                <div class="card-body">
                                                        <form class="replyforms" method="post">
                                                            <input type="hidden" name="parentId" value="${po.id}">
                                                            <input type="hidden" name="topicId" value="${postList.pageList.get(0).topicId}">
                                                            <div class="form-group" >
                                                                <label for="exampleInputEmail1"></label>
                                                                <input type="hidden" name="title" value="回复${po.user.nickname}">

                                                            </div>

                                                            <div class="form-group">
                                                                <small  class="form-text text-muted">请注意文明用词哦</small>
                                                                <label for="message${round.index}">内容</label>
                                                                <textarea minlength="6" required class="form-control" id="message${round.index}" name="content" rows="3"></textarea>
                                                            </div>

                                                            <div class="modal-footer">
                                                                <button type="submit" class="btn btn-danger">回复ヽ( o･ｪ･)ﾉ</button>
                                                            </div>
                                                        </form>
                                                </div>
                                            </div>
                                        </section>
                                    </blockquote>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

    </section>
    </c:forEach>


    <%--尾部回复--%>
    <section>
        <div class="container-fluid">
        <div class="card">
            <h5 class="card-header">快速回复</h5>
            <div class="card-body">

                <form id="quickform" method="post">
                    <input type="hidden" name="topicId" value="${postList.pageList.get(0).topicId}">
                    <div class="form-group" >
                        <label for="exampleInputEmail1">标题</label>
                        <input type="text" required class="form-control" name="title" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="请输入标题">
                        <small id="emailHelp" class="form-text text-muted">请注意文明用词哦</small>
                    </div>

                    <div id="ee">
                        <p>请输入文本内容</p>
                    </div>
                    我是隐藏
                    <input id="content" name="content" type="hidden">
                    <%--<h5 class="card-title">Special title treatment</h5>--%>
                    <%--<p class="card-text">With supporting text below as a natural lead-in to additional content.</p>--%>

                    <button type="submit" id="model" class="btn btn-primary">回复该主题</button>

                </form>

            </div>
        </div>
        </div>
    </section>

    <!-- 模态框 -->
    <section>

        <%--发表新回复--%>
        <div class="modal fade " id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">回复${po.id}</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">

                        <form id="reply" class="replyforms" method="post">

                            <input type="hidden" name="parentId" value="${po.id}">
                            <input type="hidden" name="topicId" value="${postList.pageList.get(0).topicId}">
                            <div class="form-group" >
                                <label for="exampleInputEmail1">标题</label>
                                <input type="text" required class="form-control" name="title" aria-describedby="emailHelp" placeholder="请输入标题">
                                <small  class="form-text text-muted">请注意文明用词哦</small>
                            </div>

                            <div class="form-group">
                                <label for="exampleFormControlTextarea1">内容</label>
                                <textarea class="form-control" id="exampleFormControlTextarea1" name="content" rows="3"></textarea>
                            </div>

                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">关闭</button>
                                <button type="submit" class="btn btn-primary">回复该主题</button>
                            </div>
                        </form>

                    </div>

                </div>
            </div>
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


    </section>
</main>

</body>
<%--<%@include file="../../command/commandJS.jsp"%>--%>
<script src="${pageContext.request.contextPath}/resources/lib/jquery/dist/jquery.js"></script>
<script src="${pageContext.request.contextPath}/resources/lib/bootstrap-4.1.3-dist/js/bootstrap.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/wangEditor.js"></script>
<script type="text/javascript">
    $(function () {
        window.alert = function(msg){
            $("#alertContentId").html(msg);
            $("#alertModalId").modal('show');
            setTimeout('$("#alertModalId").modal("hide")',2000);
        };
        $('.alert').alert();

        // var E2 = window.wangEditor;
        // var editor22 = new E('#editor2');
        // editor22.create();
        //模态框设置
        // $('#model').modal({
        //     keyboard: false
        // });


        quickformsub();
        replyForm();
        // click();
    });

    var E = window.wangEditor;
    var editor2 = new E('#editor');
    editor2.create();

    var E2 = window.wangEditor;
    var e2 = new E2('#ee');
    e2.create();

    function quickformsub(){

        $("#quickform").submit(function () {

            var cotentvalue = e2.txt.html();
            // alert(cotentvalue);

            var str = new String(cotentvalue);
            // alert(str);
            $('#content').val(str);
            $.post("${pageContext.request.contextPath}/post/add",$('#quickform').serialize() ,function(data){
                if(data.message){
                    alert(data.message);

                    var timestamp = Date.parse(new Date());
                    setTimeout(function () {
                        location.href = "${pageContext.request.contextPath}/post/post/${postList.pageList.get(0).topicId}?time="+timestamp;
                    }, 1000);
                    // window.location.reload();
                } else{
                    alert("必须登录之后才能操作");
                    setTimeout(function () {
                        location.href = "${pageContext.request.contextPath}/user/login";
                    }, 1000);
                }
            });
            return false;
        });
    }

    function replyForm(){
        $('.replyforms').each(function(index, element){
            var el = $(element);
            el.submit(function () {

                $.post("${pageContext.request.contextPath}/post/add",el.serialize() ,function(data){
                    if(data.message){
                        alert(data.message);
                        var timestamp = Date.parse(new Date());
                        setTimeout(function () {
                            location.href = "${pageContext.request.contextPath}/post/post/${postList.pageList.get(0).topicId}?time="+timestamp;
                        }, 1000);

                        // window.location.reload();
                    }
                    else{
                        alert("必须登录之后才能操作");
                        setTimeout(function () {
                            location.href = "${pageContext.request.contextPath}/user/login";
                        }, 1000);
                    }
                });
                return false;
            });
        });
    }

    function btnclick(postId){
        $.get("${pageContext.request.contextPath}/post/click",{
            postId:postId
        } ,function(data){
            if(data.message){
                alert(data.message);
                setTimeout(function () {
                    location.href = "${pageContext.request.contextPath}/post/post/${postList.pageList.get(0).topicId}?time="+timestamp;
                }, 1000);
            }
            else{
                alert("必须登录之后才能点赞");
                setTimeout(function () {
                    location.href = "${pageContext.request.contextPath}/user/login";
                }, 1000);
            }
        });

    }
</script>
</html>
