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
            <div class="card">
                <div class="card-header">
                    ....
                </div>
                <div class="card-body">
                    <table class="table">
                        <thead>
                        <tr>

                            <th scope="col">标题</th>
                            <th scope="col">内容</th>
                            <th scope="col">回复数</th>
                            <th scope="col">最后更新时间</th>
                            <th scope="col">申请加精</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${topics.pageList}" var="item">
                            <tr>
                                <th scope="row">${item.title}</th>
                                <td>
                                    ${item.content}
                                </td>
                                <td>
                                    ${item.postCount}
                                </td>
                                <td>
                                    <fmt:formatDate value="${item.lastUpdate}" pattern="yyyy-MM-dd HH.mm.ss" />
                                </td>
                                <c:if test="${item.orderid!=1}">
                                    <td>
                                        <a href="${pageContext.request.contextPath}/user/center/messsage?topicId=${item.id}" class="btn btn-danger">申请加精</a>
                                    </td>
                                </c:if>


                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
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

