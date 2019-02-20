<%--
  Created by IntelliJ IDEA.
  User: zxd
  Date: 2018/10/25
  Time: 23:52
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

    <title>个人中心</title>

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
            <section>
                <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
                    <ol class="carousel-indicators">
                        <c:forEach items="${albums.pageList}" var="al" varStatus="in">
                            <c:if test="${in.index==0}">
                                <li data-target="#carouselExampleIndicators" data-slide-to="${in.index}" class="active"></li>
                            </c:if>
                            <c:if test="${in.index!=0}">
                                <li data-target="#carouselExampleIndicators" data-slide-to="${in.index}"></li>
                            </c:if>
                        </c:forEach>

                    </ol>
                    <div class="carousel-inner">
                        <c:forEach items="${albums.pageList}" var="al" varStatus="in">
                            <c:if test="${in.index==0}">
                                <div class="carousel-item active">
                                    <img class="d-block w-100 h-25"  src="/${al.frontCover}" >
                                </div>
                            </c:if>
                            <c:if test="${in.index!=0}">
                                <div class="carousel-item">
                                    <img class="d-block w-100 h-25" src="/${al.frontCover}" >
                                </div>
                            </c:if>
                        </c:forEach>

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
            </section>
            <section>
                <a href="${pageContext.request.contextPath}/img/upload">
                <button type="button" class="btn btn-primary btn-lg">新建相册</button></a>

                <div class="card-deck">
                    <c:forEach items="${albums.pageList}" var="al" >
                        <div class="card col-md-2">
                        <a href="${pageContext.request.contextPath}/img/albumitems?albumId=${al.id}">
                        <img class="card-img-top p-2" style="width: 200px;height: 200px;" src="${pageContext.request.contextPath}/${al.frontCover}" alt="Card image cap"></a>
                            <div class="card-body">
                                <h5 class="card-title">${al.title}</h5>
                                <p class="card-text">${al.introduce}</p>
                            </div>
                            <div class="card-footer">
                                <small class="text-muted">
                                    <fmt:formatDate value="${al.createDate}" pattern="yyyy-MM-dd HH.mm.ss" />
                                </small>
                            </div>
                        </div>

                    </c:forEach>
                </div>
            </section>
        </main>
    </div>
</div>


<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script>window.jQuery || document.write('<script src="../../../../assets/js/vendor/jquery-slim.min.js"><\/script>')</script>
<script src="${pageContext.request.contextPath}/resources/js/popper.js"></script>
<script src="${pageContext.request.contextPath}/resources/lib/bootstrap-4.1.3-dist/js/bootstrap.js"></script>

<!-- Icons -->
<script src="https://unpkg.com/feather-icons/dist/feather.min.js"></script>
<script>
    feather.replace()
</script>

<!-- Graphs -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.1/Chart.min.js"></script>
<script>
    var ctx = document.getElementById("myChart");
    var myChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"],
            datasets: [{
                data: [15339, 21345, 18483, 24003, 23489, 24092, 12034],
                lineTension: 0,
                backgroundColor: 'transparent',
                borderColor: '#007bff',
                borderWidth: 4,
                pointBackgroundColor: '#007bff'
            }]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: false
                    }
                }]
            },
            legend: {
                display: false,
            }
        }
    });
</script>
</body>
</html>

