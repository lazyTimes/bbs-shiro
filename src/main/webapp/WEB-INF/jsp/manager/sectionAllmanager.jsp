<%--
  Created by IntelliJ IDEA.
  User: zxd
  Date: 2018/11/6
  Time: 10:35
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
            <a  class="layui-btn" id="test2">添加版块</a>
            <table class="layui-table">
                <colgroup>
                    <col width="150">
                    <col width="200">
                    <col>
                </colgroup>
                <thead>
                <tr>
                    <th>版块名称</th>
                    <th>主题名称</th>
                    <th>创建时间</th>
                    <th>最后更新时间</th>
                    <th>IP地址</th>
                    <th>删除</th>
                    <th colspan="3" style="text-align: center">相关操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${topics.pageList}" var="top">
                    <tr>

                        <td>${top.sectionName}</td>
                        <c:if test="${top.orderid==2}">
                            <td class="layui-bg-orange">
                                    <span style="font-size: 16px;">${top.title}</span> </td>
                        </c:if>
                        <c:if test="${top.orderid==1}">
                            <td class="layui-bg-blue"><span style="font-size: 16px;">${top.title}</span></td>
                        </c:if>
                        <c:if test="${top.orderid==0}">
                            <td class="layui-bg-green"><span style="font-size: 16px;">${top.title}</span></td>
                        </c:if>

                        <td>
                            <fmt:formatDate value="${top.createDate}" pattern="yyyy-MM-dd HH.mm.ss" />
                        </td>
                        <td>
                            <fmt:formatDate value="${top.lastUpdate}" pattern="yyyy-MM-dd HH.mm.ss" />
                        </td>
                        <td>
                            ${top.ipaddr}
                        </td>
                        <td><a href="#" id="delete" onclick="del(${top.id})" class="layui-btn layui-btn-danger">删除</a></td>

                        <c:if test="${top.orderid==2}">
                            <td><a href="#" onclick="edit(${top.id}, 0)" class="layui-btn layui-btn-primary">普通</a></td>
                            <td><a href="#" onclick="edit(${top.id}, 1)" class="layui-btn layui-btn-normal">精华</a></td>
                        </c:if>
                        <c:if test="${top.orderid==1}">
                            <td><a href="#" onclick="edit(${top.id}, 2)" class="layui-btn layui-btn-warm">置顶</a></td>
                            <td><a href="#" onclick="edit(${top.id}, 0)" class="layui-btn layui-btn-primary">普通</a></td>
                        </c:if>
                        <c:if test="${top.orderid==0}">
                            <td><a href="#" onclick="edit(${top.id}, 1)" class="layui-btn layui-btn-normal">精华</a></td>
                            <td><a href="#" onclick="edit(${top.id}, 2)" class="layui-btn layui-btn-warm">置顶</a></td>
                        </c:if>
                    </tr>
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

        // layui.use('form', function(){
        //     var form = layui.form;
        //
        // });




    });

    function del(id){

        layer.confirm("确定要删除该主题吗?",function () {
            $.post("${pageContext.request.contextPath}/sys/sectionItem/delete",{
                id:id
            },function(data){
                if (data.type == 1) {
                    layer.msg(data.message);
                    setTimeout(function () {
                        location.href = "${pageContext.request.contextPath}/sys/secitonItem";

                    }, 1000);
                } else {
                    layer.msg("失败，原因是：" +data.message);

                }
            });
        })


    }

    function edit(id, orderId){
        $.post("${pageContext.request.contextPath}/sys/sectionItem/update",{
            id:id,
            orderId:orderId
        },function(data){
            if (data.type == 1) {
                layer.msg(data.message);
                setTimeout(function () {
                    location.href = "${pageContext.request.contextPath}/sys/secitonItem";

                }, 1000);
            } else {
                layer.msg("失败，原因是：" +data.message);

            }
        });

    }


</script>
</body>
</html>
