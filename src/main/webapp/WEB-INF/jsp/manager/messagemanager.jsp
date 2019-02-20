<%--
  Created by IntelliJ IDEA.
  User: zxd
  Date: 2018/11/2
  Time: 12:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../command/command.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>后台管理</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/lib/layui/css/layui.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/lib/layer-v3.1.1/layer/theme/default/layer.css">

</head>
<body class="layui-layout-body">
<div class="layui-layout layui-layout-admin">
    <%@include file="./command/header.jsp"%>

    <%@include file="./command/left.jsp"%>

    <div class="layui-body">
        <!-- 内容主体区域 -->
        <div style="padding: 15px;">

            <table class="layui-table">
                <colgroup>
                    <col width="150">
                    <col width="200">
                    <col>
                </colgroup>
                <thead>
                <tr>
                    <th>申请转台</th>
                    <th>介绍</th>
                    <th>创建时间</th>
                    <th>发帖人</th>
                    <th>操作</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${messages.pageList}" var="list">
                    <c:if test="${list.sendState==2}">
                    <tr>
                        <td class="layui-bg-red">

                                正在申请

                        </td>
                        <td>${list.content}</td>

                        <td>
                            <fmt:formatDate value="${list.sendTime}" pattern="yyyy-MM-dd HH.mm.ss" />
                        </td>
                        <td>${list.username}</td>
                        <td><a href="#" id="pass" onclick="myclick(${list.id}, 1)" class="layui-btn">通过</a></td>
                        <td><a href="#" id="no" onclick="myclick(${list.id}, 0)" class="layui-btn">拒绝</a></td>
                    </tr>
                    </c:if>
                </c:forEach>
                </tbody>
            </table>

        </div>
    </div>

    <div class="layui-footer">
        <!-- 底部固定区域 -->
        © 本网站仅供学习交流使用
    </div>
</div>
<script src="${pageContext.request.contextPath}/resources/lib/layui/layui.js"></script>
<script src="${pageContext.request.contextPath}/resources/lib/jquery/dist/jquery.js"></script>
<script src="${pageContext.request.contextPath}/resources/lib/layer-v3.1.1/layer/layer.js"></script>
<script>

    $(function () {
        //JavaScript代码区域
        layui.use('element', function(){
            var element = layui.element;

        });

        layui.use('form', function(){
            var form = layui.form;


        });


    });

    function myclick(id, code){
        $.get("${pageContext.request.contextPath}/sys/messagemanager/pass",{
            id:id,
            code:code
        } ,function(data){
            if (data.type == 1) {
                layer.msg(data.message);
                location.href ="${pageContext.request.contextPath}/sys/messagemanager";
            } else {
                layer.msg("构建失败失败，原因是：" +data.message);

            }
        });
    }
</script>
</body>
</html>
