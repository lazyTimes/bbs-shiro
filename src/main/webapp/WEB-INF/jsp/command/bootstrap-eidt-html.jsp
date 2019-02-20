<%--
  Created by IntelliJ IDEA.
  User: zxd
  Date: 2018/10/23
  Time: 16:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="container">
    <div style="margin-top:50px" class="input-group input-group-lg"><span class="input-group-addon"></span><input
            type="text" placeholder="标题" name="title" class="form-control">

    </div>
    <div style="margin-top:20px" data-role="editor-toolbar" data-target="#editor" class="btn-toolbar">
        <div class="btn-group"><a data-toggle="dropdown" title="Font" class="btn dropdown-toggle"><i
                class="glyphicon glyphicon-font"></i><b class="caret"></b></a>
            <ul class="dropdown-menu"></ul>
        </div>
        <div class="btn-group"><a data-toggle="dropdown" title="Font Size" class="btn dropdown-toggle"><i
                class="glyphicon glyphicon-text-height"></i><b class="caret"></b></a>
            <ul class="dropdown-menu">
                <li><a data-edit="fontSize 5"><font size="5">Huge</font></a></li>
                <li><a data-edit="fontSize 3"><font size="3">Normal</font></a></li>
                <li><a data-edit="fontSize 1"><font size="1">Small</font></a></li>
            </ul>
        </div>
        <div class="btn-group"><a data-edit="bold" title="Bold (Ctrl/Cmd+B)" class="btn"><i class="icon-bold"></i></a><a
                data-edit="italic" title="Italic (Ctrl/Cmd+I)" class="btn"><i class="icon-italic"></i></a><a
                data-edit="strikethrough" title="Strikethrough" class="btn"><i class="icon-strikethrough"></i></a><a
                data-edit="underline" title="Underline (Ctrl/Cmd+U)" class="btn"><i class="icon-underline"></i></a>
        </div>
        <div class="btn-group"><a data-edit="insertunorderedlist" title="Bullet list" class="btn"><i
                class="icon-list-ul"></i></a><a data-edit="insertorderedlist" title="Number list" class="btn"><i
                class="icon-list-ol"></i></a><a data-edit="outdent" title="Reduce indent (Shift+Tab)" class="btn"><i
                class="icon-indent-left"></i></a><a data-edit="indent" title="Indent (Tab)" class="btn"><i
                class="icon-indent-right"></i></a></div>
        <div class="btn-group"><a data-edit="justifyleft" title="Align Left (Ctrl/Cmd+L)" class="btn"><i
                class="icon-align-left"></i></a><a data-edit="justifycenter" title="Center (Ctrl/Cmd+E)" class="btn"><i
                class="icon-align-center"></i></a><a data-edit="justifyright" title="Align Right (Ctrl/Cmd+R)"
                                                     class="btn"><i class="icon-align-right"></i></a><a
                data-edit="justifyfull" title="Justify (Ctrl/Cmd+J)" class="btn"><i class="icon-align-justify"></i></a>
        </div>
        <div class="btn-group"><a data-toggle="dropdown" title="Hyperlink" class="btn dropdown-toggle"><i
                class="icon-link"></i></a>

            <div class="dropdown-menu input-append"><input placeholder="URL" type="text" data-edit="createLink"
                                                           class="span2">
                <button type="button" class="btn">Add</button>
            </div>
            <a data-edit="unlink" title="Remove Hyperlink" class="btn"><i class="icon-cut"></i></a></div>
        <div class="btn-group"><a id="pictureBtn" title="Insert picture (or just drag &amp; drop)" class="btn"><i
                class="icon-picture"></i></a><input type="file" data-role="magic-overlay" data-target="#pictureBtn"
                                                    data-edit="insertImage">

            <div class="btn-group"><a data-edit="undo" title="Undo (Ctrl/Cmd+Z)" class="btn"><i
                    class="icon-undo"></i></a><a data-edit="redo" title="Redo (Ctrl/Cmd+Y)" class="btn"><i
                    class="icon-repeat"></i></a></div>
            <input id="voiceBtn" type="text" data-edit="inserttext" x-webkit-speech=""></div>
    </div>
    <div id="editor">请输入文本内容&hellip;</div>
</div>