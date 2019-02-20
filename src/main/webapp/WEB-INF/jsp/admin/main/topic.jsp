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
        <a class="nav-link active" href="${pageContext.request.contextPath}/section/sec/${sectionId}">全部分类</a>

        <c:forEach items="${categoryList}" var="catelist">
            <a class="nav-link" href="${pageContext.request.contextPath}/section/sec/${sectionId}?categoryId=${catelist.id}">${catelist.categoryName}
                <span class="badge badge-pill bg-light align-text-bottom">${catelist.categoryCount}</span>
            </a>
        </c:forEach>
    </nav>
</div>


<main role="main" class="container">

    <nav aria-label="Page navigation example">
        <ul class="pagination">
            <c:if test="${topics.pageNow != topics.beginPage}">
                <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/topic/sec/${sectionId}?start=${topics.pageNow-1}">上一页</a></li>
            </c:if>
            <c:if test="${topics.pageNow == topics.beginPage}">
                <li class="page-item disabled"><a class="page-link " href="#">上一页</a></li>
            </c:if>
            <c:forEach begin="${topics.beginPage}" end="${topics.endPage}" var="page">
                <c:if test="${page==topics.pageNow}">
                    <li class="page-item"><a class="page-link d-block" href="${pageContext.request.contextPath}/topic/sec/${sectionId}?start=${page}">
                            ${page}</a>
                    </li>
                </c:if>
                <c:if test="${page!=topics.pageNow}">
                    <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/topic/sec/${sectionId}?start=${page}">${page}</a></li>

                </c:if>
            </c:forEach>
            <c:if test="${topics.pageNow != topics.endPage}">
                <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/topic/sec/${sectionId}?start=${topics.pageNow+1}">下一页</a></li>
            </c:if>
            <c:if test="${topics.pageNow == topics.endPage}">
                <li class="page-item disabled"><a class="page-link" href="#">下一页</a></li>
            </c:if>
        </ul>
    </nav>
    <div class="btn-group offset-10" role="group" aria-label="">
        <a href="${pageContext.request.contextPath}/section/main" class="btn-danger btn">返回首页</a>
        <a href="${pageContext.request.contextPath}/topic/add?sectionId=${sectionId}" id="addsec">

        <button type="button" class="btn btn-outline-danger">发表主题</button></a>
        <%--<button type="button" class="btn btn-secondary">Middle</button>--%>
        <%--<button type="button" class="btn btn-secondary">Right</button>--%>
    </div>

    <!--公告-->


    <%--置顶--%>
    <section>

        <div class="d-flex align-items-center p-3 my-3 text-white-50 bg-purple rounded box-shadow">

            <div class="lh-100">
                <h6 class="mb-0 text-white lh-100">主题内容</h6>

            </div>
        </div>

        <div class="media text-muted pt-2">
            <%--<img data-src="holder.js/32x32?theme=thumb&bg=007bff&fg=007bff&size=1" alt="" class="mr-2 rounded">--%>
            <ul class="list-unstyled">

                <c:forEach items="${topics.pageList}" var="tp">
                    <li class="media">
                        <img class="mr-3 rounded-circle" style="width: 50px;height: 50px" src="${pageContext.request.contextPath}/resources/img/back1.jpg"  alt="Generic placeholder image">
                        <div class="media-body">
                            <h5 class="mt-0 mb-1"><a href="${pageContext.request.contextPath}/post/post/${tp.id}?sectionId=${sectionId}">
                                    <c:if test="${tp.orderid==2}">
                                        <span style="color:red;"> ${tp.title}</span>
                                    </c:if>
                                    <c:if test="${tp.orderid==1}">
                                        <span style="color:blue;"> ${tp.title}</span>
                                    </c:if>
                                    <c:if test="${tp.orderid==0}">
                                        <span > ${tp.title}</span>
                                    </c:if>


                            </a>

                            </h5>
                            <div class="d-flex align-items-end">
                                <div class="p-1 flex-fill bd-highlight">发帖人：
                                    <span class="d-block">${tp.username}</span>
                                </div>
                                <div class="p-1 flex-fill bd-highlight">回复数：
                                    <span class="d-block">${tp.postCount}</span>
                                </div>
                                <div class="p-1 flex-fill bd-highlight">发表日期：
                                    <span class="d-block"><fmt:formatDate value="${tp.createDate}" pattern="yyyy-MM-dd HH.mm.ss" /></span>
                                </div>
                                <div class="p-1 flex- bd-highlight">最后更新时间：
                                    <span class="d-block"><fmt:formatDate value="${tp.lastUpdate}" pattern="yyyy-MM-dd HH.mm.ss" /></span>
                                </div>
                                <%--<div class="p-1 flex- bd-highlight">最后回复用户名：--%>
                                    <%--<span class="d-block"><fmt:formatDate value="${tp.lastUpdate}" pattern="yyyy-MM-dd HH.mm.ss" /></span>--%>
                                <%--</div>--%>

                            </div>
                            <span class="d-block">介绍: ${tp.content}</span>
                                <%--最新回复--%>

                        </div>
                    </li>
                    <hr/>
                </c:forEach>
            </ul>

        </div>
    </section>

    <%--主题列表--%>
    <%--<section>--%>
        <%--<div class="d-flex align-items-center p-3 my-3 text-white-50 bg-purple rounded box-shadow">--%>

            <%--<div class="lh-100">--%>
                <%--<h6 class="mb-0 text-white lh-100">${categoryName}</h6>--%>

            <%--</div>--%>
        <%--</div>--%>

        <%--<div class="media text-muted pt-3">--%>
            <%--&lt;%&ndash;<img data-src="holder.js/32x32?theme=thumb&bg=007bff&fg=007bff&size=1" alt="" class="mr-2 rounded">&ndash;%&gt;--%>
            <%--<ul class="list-unstyled">--%>
                <%--<li class="media">--%>
                    <%--<img class="mr-3 rounded-circle" style="width: 50px;height: 50px" src="${pageContext.request.contextPath}/resources/img/back1.jpg"  alt="Generic placeholder image">--%>
                    <%--<div class="media-body">--%>
                        <%--<h6 class="mt-0 mb-1">List-based media object</h6>--%>
                        <%--&lt;%&ndash;最新回复&ndash;%&gt;--%>
                        <%--<div class="d-flex align-items-end">--%>
                            <%--<div class="p-2 flex-fill bd-highlight">Flex item</div>--%>
                            <%--<div class="p-2 flex-fill bd-highlight">Flex item</div>--%>
                            <%--<div class="p-2 flex-fill bd-highlight">Flex item</div>--%>
                            <%--<div class="p-2 flex-fill bd-highlight">Flex item</div>--%>
                            <%--<div class="p-2 flex-fill bd-highlight">Flex item</div>--%>
                            <%--<div class="p-2 flex-fill bd-highlight">Flex item</div>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                <%--</li>--%>

            <%--</ul>--%>

        <%--</div>--%>
    <%--</topic>--%>
</main>

<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<%@include file="../../command/commandJS.jsp"%>
<%--<script src="../../../../assets/js/vendor/holder.min.js"></script>--%>
<script src="${pageContext.request.contextPath}/resources/js/offcanvas.js"></script>
<script>
    $(function () {

    });

</script>
</body>
</html>





