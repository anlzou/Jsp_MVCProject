<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>员工后端管理</title>
    <link rel="stylesheet" href="css/bootstrap.css">
    <script src="js/jquery-3.3.1.js"></script>
    <script src="js/bootstrap.js"></script>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<nav class="navbar navbar-inverse">
    <div class="navbar-header">
        <button class="navbar-toggle" data-toggle="collapse" data-target="#slider-left">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a href="#" class="navbar-brand">员工后端管理</a>
    </div>
    <ul class="nav navbar-nav navbar-right ul-right">
        <li class="col-xs-6"><a href="#"><span class="glyphicon glyphicon-user"> ${sessionScope.username}</span></a>
        </li>
        <li class="col-xs-6"><a href="exit"><span class="glyphicon glyphicon-off"></span>&nbsp;注销</a></li>
    </ul>
    <div id="slider-left" class="navbar-default navbar-collapse collapse slider-left">
        <ul class="nav">
            <li><a href="#sub1" data-toggle="collapse">员工信息管理<span
                    class="glyphicon glyphicon-menu-right pull-right"></span></a></li>
            <ul id="sub1" class="nav collapse">
                <li><a href="viewEmp"><span class="glyphicon glyphicon-search"></span>信息查询</a></li>
                <li><a href="addEmp.jsp"><span class="glyphicon glyphicon-plus"></span>增加信息</a></li>
            </ul>
        </ul>
        <ul class="nav">
            <li><a href="#sub2" data-toggle="collapse">用户信息管理<span
                    class="glyphicon glyphicon-menu-right pull-right"></span></a></li>
            <ul id="sub2" class="nav collapse">
                <li><a href="#"><span class="glyphicon glyphicon-home"></span>系统信息</a></li>
                <li><a href="#"><span class="glyphicon glyphicon-user"></span>管理员信息</a></li>
                <li><a href="#"><span class="glyphicon glyphicon-info-sign"></span>日志信息</a></li>
                <li><a href="#"><span class="glyphicon glyphicon-off"></span>退出</a></li>
            </ul>
        </ul>
    </div>
</nav>
<div class="page_main">
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    员工信息
                </div>
                <div class="panel-body">
                    <table class="table table-bordered table-striped table-hover" id="table">
                        <tr>
                            <th>EMPNO</th>
                            <th>ENAME</th>
                            <th>JOB</th>
                            <th>MGR</th>
                            <th>HIREDATE</th>
                            <th>SAL</th>
                            <th>COMM</th>
                            <th>DEPTNO</th>
                            <th>操作</th>
                        </tr>
                        <tbody id="tbody">
                        <c:forEach items="${requestScope.pm.list}" var="emp">
                            <tr>
                                <td>${emp.empno}</td>
                                <td>${emp.ename}</td>
                                <td>${emp.job}</td>
                                <td>${emp.mgr} </td>
                                <td>${emp.hiredate}</td>
                                <td>${emp.sal}</td>
                                <td>${emp.comm}</td>
                                <td>${emp.deptno}</td>
                                <td><a href="javascript:void(0)" onclick="delete_data(${emp.empno})">删除</a>&nbsp;<a
                                        href="javascript:void(0)" onclick="update_data(${emp.empno})">修改</a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <input type="button" id="first" value="首页"
                           onclick="myClick(1)">
                    <input type="button" id="previous" value="上一页"
                           onclick="myClick(2)">
                    <input type="button" id="next" value="下一页"
                           onclick="myClick(3)">
                    <input type="button" id="end" value="尾页"
                           onclick="myClick(4)">
                    <span id="span">&nbsp;&nbsp;第${requestScope.pm.currentPage}页/共${requestScope.pm.totalPage}页&nbsp;&nbsp;</span>
                    <input type="text" id="go">
                    <input type="button" id="ok" value="跳转" onclick="goPage()">
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    window.onload = init;

    function init() {
        var butFirst = document.getElementById("first");
        var butPrevious = document.getElementById("previous");
        butFirst.disabled = "disabled";
        butPrevious.disabled = "disabled";
    }

    xmlHttp = new XMLHttpRequest();
    xmlHttp.onreadystatechange = showData;//设置回调函数：服务器返回了数据，哪个函数来负责处理数据

    function myClick(x) {
        var currentPage = "${requestScope.pm.currentPage}";
        var totalPage = "${requestScope.pm.totalPage}";
        currentPage = Number(currentPage);
        totalPage = Number(totalPage);
        var page;
        if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
            var data = JSON.parse(xmlHttp.responseText);
            currentPage = data.currentPage;
        }

        var butFirst = document.getElementById("first");
        var butPrevious = document.getElementById("previous");
        var butNext = document.getElementById("next");
        var butEnd = document.getElementById("end");

        switch (x) {
            case 1:
                if (currentPage == 1) {
                    page = currentPage;
                    butFirst.disabled = "disabled";
                    butPrevious.disabled = "disabled";
                    butNext.disabled = "";
                    butEnd.disabled = "";
                } else {
                    page = 1;
                    butFirst.disabled = "disabled";
                    butPrevious.disabled = "disabled";
                    butNext.disabled = "";
                    butEnd.disabled = "";
                }
                break;
            case 2:
                if (currentPage == 1) {
                    page = currentPage;
                    butFirst.disabled = "disabled";
                    butPrevious.disabled = "disabled";
                    butNext.disabled = "";
                    butEnd.disabled = "";
                    alert("已经是第一页了！🤣");
                } else {
                    page = currentPage - 1;
                    butFirst.disabled = "";
                    butPrevious.disabled = "";
                    butNext.disabled = "";
                    butEnd.disabled = "";
                }
                break;
            case 3:
                if (currentPage == totalPage) {
                    page = currentPage;
                    butFirst.disabled = "";
                    butPrevious.disabled = "";
                    butNext.disabled = "disabled";
                    butEnd.disabled = "disabled";
                    alert("已经是最后一页了！🐷");
                } else {
                    page = currentPage + 1;
                    butFirst.disabled = "";
                    butPrevious.disabled = "";
                    butNext.disabled = "";
                    butEnd.disabled = "";
                }
                break;
            case 4:
                if (currentPage != totalPage) {
                    page = totalPage;
                    butFirst.disabled = "";
                    butPrevious.disabled = "";
                    butNext.disabled = "disabled";
                    butEnd.disabled = "disabled";
                } else {
                    page = totalPage;
                    butFirst.disabled = "";
                    butPrevious.disabled = "";
                    butNext.disabled = "disabled";
                    butEnd.disabled = "disabled";
                }
                break;
        }
        xmlHttp.open("GET", "viewEmp?page=" + page);//打开连接
        xmlHttp.send(null);//发送请求
    }

    function showData() {
        if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
            var span = document.getElementById("span");//标签插入”第x页/共n页“
            var table = document.getElementById("table"); //定位到table上
            var tbody_old = document.getElementsByTagName("tbody")[1];//
            table.removeChild(tbody_old);

            var data = JSON.parse(xmlHttp.responseText);
            var newtbody = document.createElement("tbody");
            for (prop in data) {
                if (prop = 'list') {
                    for (p in data[prop]) {
                        var empNo = data[prop][p].empno;
                        var tr = document.createElement("tr");

                        var td1 = document.createElement("td");
                        var td2 = document.createElement("td");
                        var td3 = document.createElement("td");
                        var td4 = document.createElement("td");
                        var td5 = document.createElement("td");
                        var td6 = document.createElement("td");
                        var td7 = document.createElement("td");
                        var td8 = document.createElement("td");
                        var td9 = document.createElement("td");//给删除和更新的链接

                        var a_delete = document.createElement("a");
                        a_delete.setAttribute("href", "javascript:void(0)");
                        a_delete.setAttribute("onclick", "delete_data(" + empNo + ")");
                        a_delete.innerText = "删除  ";
                        td9.appendChild(a_delete);
                        var a_update = document.createElement("a");
                        a_update.setAttribute("href", "javascript:void(0)");
                        a_update.setAttribute("onclick", "update_data(" + empNo + ")");
                        a_update.innerText = "修改";
                        td9.appendChild(a_update);

                        td1.innerHTML = data[prop][p].empno;
                        td2.innerHTML = data[prop][p].ename;
                        td3.innerHTML = data[prop][p].job;
                        td4.innerHTML = data[prop][p].mgr;
                        td5.innerHTML = data[prop][p].hiredate;
                        td6.innerHTML = data[prop][p].sal;
                        td7.innerHTML = data[prop][p].comm;
                        td8.innerHTML = data[prop][p].deptno;

                        tr.appendChild(td1);
                        tr.appendChild(td2);
                        tr.appendChild(td3);
                        tr.appendChild(td4);
                        tr.appendChild(td5);
                        tr.appendChild(td6);
                        tr.appendChild(td7);
                        tr.appendChild(td8);
                        tr.appendChild(td9);

                        newtbody.appendChild(tr);
                    }
                    table.appendChild(newtbody);
                    break;
                }
            }
            span.innerHTML = "&nbsp;&nbsp;第" + data.currentPage + "页" + "/共" + data.totalPage + "页&nbsp;&nbsp;";
        }
    }

    function goPage() {
        //var go = document.getElementById("go");
        alert("未完成！")
    }

    function delete_data(empno) {
        window.location.href = "deleteEmp?empno=" + empno;
    }

    function update_data(empno) {
        window.location.href = "updateEmp?empno=" + empno;
    }
</script>
</body>
</html>