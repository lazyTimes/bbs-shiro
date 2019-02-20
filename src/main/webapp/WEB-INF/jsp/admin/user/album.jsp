<%--
  Created by IntelliJ IDEA.
  User: zxd
  Date: 2018/10/25
  Time: 13:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<%@ include file="../../command/command.jsp"%>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>商品添加</title>
    <!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/resources/lib/bootstrap-4.1.3-dist/css/bootstrap.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/resources/css/offcanvas.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/lib/layui/css/layui.css">


    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/font-awesome/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common/header.css" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/goodsAdd.css"/>
</head>

<body class="layui-layout-body container">
<%@ include file="../main/top.jsp"%>
<div class="layui-layout layui-layout-admin">

    <!--侧边栏-->

    <!--主体-->
    <div class="layui-body" id="admin-body">
        <!-- 内容主体区域 -->
        <form class="layui-form goodsAddForm" action="" id="imgform" method="post">
            <div class="layui-form-item">
                <label class="layui-form-label">相册名称</label>
                <div class="layui-input-block">
                    <input type="text" name="title" id="title" required lay-verify="required" placeholder="请输入相册名称" autocomplete="off" class="form-control">
                </div>
            </div>

            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">相册描述</label>
                <div class="layui-input-block">
                    <textarea name="introduce"  required placeholder="请输入相册描述" class="form-control"></textarea>
                </div>
            </div>
            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">相册密码(默认为公开)</label>
                <div class="layui-input-block">
                    <input type="password" name="password"  placeholder="请输入相册密码" class="form-control"></input>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label">商品图片上传</label>
                <div class="layui-input-block">
                    <button type="button" class="layui-btn" id="test1">
                        <i class="layui-icon">&#xe67c;</i>选择图片（最多选择20张，单张图片最大为10M）
                    </button>
                    <button type="button" class="layui-btn" id="test9">开始上传</button>
                    <button type="button" class="layui-btn" id="cleanImgs"> <i class="fa fa-trash-o fa-lg"></i>清空图片预览</button>
                </div>
                <blockquote class="layui-elem-quote layui-quote-nm" style="margin-top: 10px;">
                    预览图：
                    <div class="layui-upload-list" id="demo2"></div>
                </blockquote>
            </div>

            <input type="text" id="url" name="url" style="display: none;" class="layui-input">
            <div class="layui-form-item">
                <div class="layui-input-block">
                    <button class="layui-btn" type="submit" style="width: 800px;" id="btnSubmit">保存</button>
                </div>
            </div>
        </form>
    </div>

</div>
<script src="${pageContext.request.contextPath}/resources/lib/jquery/dist/jquery.js" type="text/javascript" charset="utf-8"></script>
<script src="${pageContext.request.contextPath}/resources/lib/layui/layui.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/common.js"></script>
<%--<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/goodsMutiUpload.js" ></script>--%>
<script>
    //JavaScript代码区域
    layui.use(['element', 'form', 'laydate'], function() {
        var element = layui.element;
        var form = layui.form;
    });

    /**
     * 图片上传数量及其大小等控制
     * 点击开始上传按钮(test9)，执行上传
     *
     */
    var success=0;
    var fail=0;
    var url="";

    $(function (){
        var imgsName="";
        layui.use(['upload','layer'],function() {
            var upload = layui.upload;
            var layer=layui.layer;

            upload.render({
                elem: '#test1',
                url: '${pageContext.request.contextPath}/img/upload',
                multiple: true,
                auto:false,
//			上传的单个图片大小
                size:10240,
//			最多上传的数量
                number:20,
//			MultipartFile file 对应，layui默认就是file,要改动则相应改动
                field:'file',
                bindAction: '#test9',
                before: function(obj) {
                    //预读本地文件示例，不支持ie8
                    obj.preview(function(index, file, result) {
                        $('#demo2').append('<img src="' + result
                            + '" alt="' + file.name
                            +'"height="92px" width="92px" class="layui-upload-img uploadImgPreView">')
                    });
                },
                done: function(res, index, upload) {
                    //每个图片上传结束的回调，成功的话，就把新图片的名字保存起来，作为数据提交
                    console.log(res.code);
                    if(res.code=="1"){
                        fail++;
                    }else{
                        success++;
                        url=url+""+res.data.src+",";
                        $('#url').val(url);
                    }
                },
                allDone:function(obj){
                    layer.msg("总共要上传图片总数为："+(fail+success)+"\n"
                        +"其中上传成功图片数为："+success+"\n"
                        +"其中上传失败图片数为："+fail
                    )
                }
            });

        });

        //清空预览图片
        cleanImgsPreview();
        //保存商品
        albumSave();
    });

    /**
     * 清空预览的图片
     * 原因：如果已经存在预览的图片的话，再次点击上选择图片时，预览图片会不断累加
     * 表面上做上传成功的个数清0
     */
    function cleanImgsPreview(){
        $("#cleanImgs").click(function(){
            success=0;
            fail=0;
            $('#demo2').html("");
            $('#url').val("");
        });
    }

    /**
     * 保存到相册
     */
    function albumSave(){
        $('#imgform').submit(function(){

            $.ajax({
                type: "POST",
                url: "${pageContext.request.contextPath}/img/phoupload",
                data:$("#imgform").serialize(),
                dataType: "json",
                success: function(date){
                    if(date.type==1){
                        alert("保存成功");
                        if(confirm("恭喜上传成功!是否继续创建新相册操作?")){
                            location.href = "/img/upload";
                        }else {
                            console.log("继续操作");
                        }
                    }else{
                        alert("请至少上传一张图片并且上传图片");
                    }
                },
                error:function (data) {
                    alert("对不起，保存失败");
                }
            });


            return false;
        });
    }
</script>
</body>

</html>
