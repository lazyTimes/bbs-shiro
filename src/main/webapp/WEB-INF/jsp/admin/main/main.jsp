<%--
  Created by IntelliJ IDEA.
  User: zxd
  Date: 2018/10/18
  Time: 14:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../../command/command.jsp"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <%--<link rel="icon" href="../../../../favicon.ico">--%>

    <title>趣闻论坛</title>

    <!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/resources/lib/bootstrap-4.1.3-dist/css/bootstrap.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/resources/css/offcanvas.css" rel="stylesheet">
</head>

<body class="bg-light">


<%@ include file="top.jsp"%>

<div class="nav-scroller bg-white box-shadow">
    <nav class="nav nav-underline">
        <a class="nav-link active" href="#">主题板块</a>
        <c:forEach items="${sections}" var="section">
            <a class="nav-link" href="${pageContext.request.contextPath}/section/sec/${section.id}">${section.sectionName}</a>
        </c:forEach>
    </nav>
</div>

<%--轮播图版块--%>
<section>
    <div class="container">
        <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
            <ol class="carousel-indicators">
                <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
                <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
                <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
            </ol>
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img class="d-block w-100" src="${pageContext.request.contextPath}/resources/img/back3.jpg" alt="First slide">
                </div>
                <div class="carousel-item">
                    <img class="d-block w-100" src="${pageContext.request.contextPath}/resources/img/back2.jpg" alt="Second slide">
                </div>
                <div class="carousel-item">
                    <img class="d-block w-100" src="${pageContext.request.contextPath}/resources/img/back3.jpg" alt="Third slide">
                </div>
            </div>
            <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
        </div>
    </div>
</section>

<main role="main" class="container">
    <div class="d-flex align-items-center p-3 my-3 text-white-50 bg-purple rounded box-shadow">
        <img class="mr-3" src="https://getbootstrap.com/assets/brand/bootstrap-outline.svg" alt="" width="48" height="48">
        <div class="lh-100">
            <h6 class="mb-0 text-white lh-100">最新回复</h6>
            <small>Since 2018</small>
        </div>
    </div>

    <div class="my-3 p-3 bg-white rounded box-shadow">
        <h6 class="border-bottom border-gray pb-2 mb-0">最新消息</h6>

        <c:forEach items="${lastposts.pageList}" var="last">
        <div class="media text-muted pt-3">
            <img data-src="holder.js/32x32?theme=thumb&bg=007bff&fg=007bff&size=1" alt="" class="mr-2 rounded">
            <p class="media-body pb-3 mb-0 small lh-125 border-bottom border-gray">
                <strong class="d-block text-gray-dark">@${last.user.username}
                    标题: ${last.title}

                </strong>

            </p>
                ${last.content}
        </div>
        </c:forEach>

        <small class="d-block text-right mt-3">
            <a href="#">更新</a>
        </small>
    </div>

    <%--版块分区--%>
    <section>
        <div class="d-flex align-items-center p-3 my-3 text-white-50 bg-purple rounded box-shadow">
            <img class="mr-3" src="https://getbootstrap.com/assets/brand/bootstrap-outline.svg" alt="" width="48" height="48">
            <div class="lh-100">
                <h6 class="mb-0 text-white lh-100">主题板块</h6>
                <small>Since 2018</small>
            </div>
        </div>
        <div class="my-3 p-3 bg-white rounded box-shadow">
            <h6 class="border-bottom border-gray pb-2 mb-0">版块分区</h6>

            <%--</div>--%>
            <c:forEach items="${sections}" var="section">
                <div class="media text-muted pt-3">
                    <img src="${pageContext.request.contextPath}/resources/img/back1.jpg" alt="" class="mr-2 rounded w-25 h-0">

                    <div class="media-body pb-3 mb-0 small lh-125 border-bottom border-gray">

                        <div class="d-flex justify-content-between align-content-center w-100">
                            <a href="${pageContext.request.contextPath}/section/sec/${section.id}" ><h4>${section.sectionName}</h4></a>
                            <strong class="text-gray-dark">主题数/总数
                                <span class="d-block">${section.topicCount} / ${section.allCount}</span>
                            </strong>

                            <strong class="text-gray-dark">版主
                                <span class="d-block">${section.username}</span>
                            </strong>
                            <strong class="text-gray-dark">最后更新时间
                                <span class="d-block">
                                    <fmt:formatDate value="${section.topicLastupdate}" pattern="yyyy年MM月dd日" />
                                </span>
                            </strong>
                        </div>
                        <!--分类子版块s-->
                        <div class="d-flex flex-row">
                            <div class="p-2">Flex item 1</div>
                            <div class="p-2">Flex item 2</div>
                            <div class="p-2">Flex item 3</div>
                        </div>
                    </div>
                </div>
            </c:forEach>


            <small class="d-block text-right mt-3">
                <a href="#">全部分区</a>
            </small>
        </div>
    </section>
</main>

<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script>window.jQuery || document.write('<script src="../../../../assets/js/vendor/jquery-slim.min.js"><\/script>')</script>
<script src="${pageContext.request.contextPath}/resources/js/popper.js"></script>
<script src="${pageContext.request.contextPath}/resources/lib/bootstrap-4.1.3-dist/js/bootstrap.js"></script>
<%--<script src="../../../../assets/js/vendor/holder.min.js"></script>--%>
<script src="${pageContext.request.contextPath}/resources/js/offcanvas.js"></script>
<script>
    $(function () {

    });

</script>
</body>
</html>





