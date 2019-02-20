<%--
  Created by IntelliJ IDEA.
  User: zxd
  Date: 2018/10/27
  Time: 16:19
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
                    <th>介绍</th>
                    <th>创建时间</th>

                    <th>修改</th>

                </tr>
                </thead>
                <tbody>
                    <c:forEach items="${sectionList}" var="list">
                    <tr>
                        <td class="layui-bg-red"><span style="font-size: 18px">${list.sectionName}</span> </td>
                        <td>${list.description}</td>
                        <td>
                            <fmt:formatDate value="${list.topicLastupdate}" pattern="yyyy-MM-dd HH.mm.ss" />
                        </td>
                        <td><a href="#" id="edit" onclick="edit(${list.id}, '${list.sectionName}')" class="layui-btn">修改</a></td>

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

        layui.use('form', function(){
            var form = layui.form;

            //监听提交
            form.on('submit(formDemo1)', function(data){
                layer.msg(JSON.stringify(data.field));
                $.post("${pageContext.request.contextPath}/sys/sectionmanager/add",data.field ,function(data){
                    if (data.type == 1) {
                        layer.msg(data.message);
                        location.href = "${pageContext.request.contextPath}/topic/add?sectionId="+data.messageCode;

                    } else {
                        layer.msg("失败，原因是：" +data.message);

                    }
                });
                return false;
            });

            add();
        });




    });

    function add(){
        //弹出一个页面层
        $('#test2').on('click', function(){
            layer.open({
                type: 1,
                area: ['600px', '360px'],
                shadeClose: true, //点击遮罩关闭
                content: '<div style="padding:20px;" id="box">\n' +
                '                <form class="layui-form" action="" method="post">\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">版块名称</label>\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <input type="text" name="sectionName" required  lay-verify="required" placeholder="请输入版块信息" autocomplete="off" class="layui-input">\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <label class="layui-form-label">介绍</label>\n' +
                '                        <div class="layui-input-inline">\n' +
                '                            <input type="text" name="description" required lay-verify="required" placeholder="请输入介绍内容" autocomplete="off" class="layui-input">\n' +
                '                        </div>\n' +
                '                        <div class="layui-form-mid layui-word-aux">版块信息</div>\n' +
                '                    </div>\n' +
                '\n' +
                '                    <div class="layui-form-item">\n' +
                '                        <div class="layui-input-block">\n' +
                '                            <button class="layui-btn" lay-submit lay-filter="formDemo1">立即提交</button>\n' +
                '                            <button type="reset" class="layui-btn layui-btn-primary">重置</button>\n' +
                '                        </div>\n' +
                '                    </div>\n' +
                '                </form>\n' +
                '\n' +
                '            </div>'
            });
        });
    }

    function edit(id, name){

        layer.prompt(function(val, index){
            $.post("${pageContext.request.contextPath}/sys/sectionmanager/edit",{
                sectionId:id,
                name:val
            },function(data){
                if (data.type == 1) {
                    layer.msg(data.message);
                    setTimeout(function () {
                        location.href = "${pageContext.request.contextPath}/sys/sectionmanager";

                    }, 1000);

                } else {
                    layer.msg("失败，原因是：" +data.message);

                }
            });

            layer.close(index);
        });

    }


</script>
</body>
</html>
