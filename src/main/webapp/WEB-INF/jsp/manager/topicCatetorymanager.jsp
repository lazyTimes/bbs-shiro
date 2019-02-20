<%--
  Created by IntelliJ IDEA.
  User: zxd
  Date: 2018/11/2
  Time: 15:29
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
            <button class="layui-btn layui-btn-primary" id="adbtn">添加</button>
            <c:forEach items="${topiccus}" var="cus">
                <div class="layui-collapse ">
                    <div class="layui-colla-item ">
                        <h2 class="layui-colla-title layui-bg-green">${cus.sectionName}

                        </h2>

                        <div class="layui-colla-content layui-show">

                                <table class="layui-table">
                                    <colgroup>
                                        <col width="150">
                                        <col width="200">
                                        <col>
                                    </colgroup>
                                    <thead>
                                    <tr>
                                        <th>子版块名称</th>
                                        <th>修改</th>
                                        <th>删除</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${cus.categorys}" var="cat">
                                    <tr>
                                        <td>${cat.categoryName}</td>
                                        <td>
                                            <input type="hidden" name="look" value="${cat.id}">
                                            <button class="update layui-btn-warm layui-btn">修改</button>
                                        </td>
                                        <td><a onclick="del(${cat.id})" class="layui-btn-danger layui-btn">删除</a></td>
                                    </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>

                        </div>
                    </div>

                </div>
            </c:forEach>

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

            edit();
            adds();


        });

        layui.use('form', function(){
            var form = layui.form;

            //监听提交
            form.on('submit(formDemo)', function(data){
                // alert(JSON.stringify());

                $.post("${pageContext.request.contextPath}/sys/sectioncategorymanager/add",$("#ff").serialize(),function(data){
                    if (data.type == 1) {
                        layer.msg(data.message);
                        setTimeout(function () {
                            location.href = "${pageContext.request.contextPath}/sys/sectioncategorymanager";

                        }, 1000);


                    } else {
                        layer.msg("构建失败失败，原因是：" +data.message);

                    }
                });
                return false;
            });
        });


    });


    function adds(){
        $("#adbtn").click(function () {
            layer.open({
                type: 1,
                area: ['600px', '360px'],
                shadeClose: true, //点击遮罩关闭
                content: '<form id="ff" method="post">\n' +
                '\n' +
                '            <div class="layui-form-item">\n' +
                '                <select id="sel" name="sectionId" style="padding: 5px; margin-left: 50px; margin-top: 10px" lay-ignore="true">\n' +
                '                    <c:forEach items="${topiccus}" var="cus">\n' +
                '                        <option value="${cus.id}">${cus.sectionName}</option>\n' +
                '                    </c:forEach>\n' +
                '                </select>\n' +
                '            </div>\n' +
                '            <div class="layui-form-item">\n' +
                '                <label class="layui-form-label">分类名称</label>\n' +
                '                <div class="layui-input-block">\n' +
                '                    <input name="categoryName" required minlength="2" id="cat">\n' +
                '\n' +
                '                    </input>\n' +
                '                </div>\n' +
                '            </div>\n' +
                '\n' +
                '            <div class="layui-form-item">\n' +
                '                <div class="layui-input-block">\n' +
                '                    <button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>\n' +
                '                    <button type="reset" class="layui-btn layui-btn-primary">重置</button>\n' +
                '                </div>\n' +
                '            </div>\n' +
                '        </form>'
            });
        });

    }

    function edit(){
        $('.update').each(function(index, el) {
            $(el).on('click',function () {
                var pr = $(el).prev('input[type=hidden]').val();
                layer.prompt(function(val, index){

                    $.get("${pageContext.request.contextPath}/sys/sectioncategorymanager/edit",{
                        categoryName:val,
                        id:pr
                    },function(data){
                        if (data.type == 1) {
                            layer.msg(data.message);
                            setTimeout(function () {
                                location.href = "${pageContext.request.contextPath}/sys/sectioncategorymanager";

                            }, 1000);

                        } else {
                            layer.msg("构建失败失败，原因是：" +data.message);

                        }
                    });

                    layer.close(index);
                });
            })


        });
    }

    function del(id){

        layer.confirm("确定要删除该主题吗?",function () {
            $.get("${pageContext.request.contextPath}/sys/sectioncategorymanager/delete",{
                id:id
            },function(data){
                if (data.type == 1) {
                    layer.msg(data.message);
                    setTimeout(function () {
                        location.href = "${pageContext.request.contextPath}/sys/sectioncategorymanager";

                    }, 1000);

                } else {
                    layer.msg("删除失败，原因是：" +data.message);

                }
            });
        });

    }

</script>
</body>
</html>

