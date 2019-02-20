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
            <div class="card text-center">
                <div class="card-header">
                    ...
                </div>
                <ul class="nav">
                    <li class="nav-item">
                        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
                            修改个人信息
                        </button>
                    </li>
                    <li class="nav-item">

                        <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#exampleModa2">
                            更改密码
                        </button>
                    </li>
                </ul>

                <div class="card-body text-center">

                        <img class="card-img-top" src="${pageContext.request.contextPath}/resources/img/back1.jpg" alt="Card image cap">
                        <div class="card-body">
                            <h5 class="card-title">${user.nickname}</h5>
                            <p class="card-text">${user.address}</p>
                        </div>
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item">E-mail:${user.email}</li>
                            <li class="list-group-item">性别 :
                                <c:if test="${user.gender == 1}">
                                    男
                                </c:if>
                                <c:if test="${user.gender == 2}">
                                    女
                                </c:if>
                            </li>
                            <li class="list-group-item">QQ:${user.qqNumber}</li>
                            <li class="list-group-item">注册日期:
                                <fmt:formatDate value="${user.registerDate}" pattern="yyyy-MM-dd HH.mm.ss" />
                            </li>
                            <li class="list-group-item">最后登录时间:
                                <fmt:formatDate value="${user.lastLogintime}" pattern="yyyy-MM-dd HH.mm.ss" />
                            </li>

                        </ul>


                </div>
                <div class="card-footer text-muted">
                    本网站仅供学习交流使用
                </div>
            </div>
        </main>
    </div>
</div>

<!-- 修改个人信息 -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">修改个人信息</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                ...
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
        </div>
    </div>
</div>

<!-- 修改密码 -->
<div class="modal fade" id="exampleModa2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel2" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel2">修改密码</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
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

