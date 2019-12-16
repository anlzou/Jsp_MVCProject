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
    <script src="js/myjs.js"></script>
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
    <div class="container-fluid page-main">
        <form action="saveEmp">
            <div class="form-group">
                <label for="empno">员工编号</label>
                <input type="text" class="form-control" id="empno" name="empno" placeholder="员工编号">
            </div>
            <div class="form-group">
                <label for="ename">员工姓名</label>
                <input type="text" class="form-control" id="ename" name="ename" placeholder="员工姓名">
            </div>
            <div class="form-group">
                <label for="job">JOB</label>
                <input type="text" class="form-control" id="job" name="job" placeholder="JOB">
            </div>
            <div class="form-group">
                <label for="mgr">MGR</label>
                <input type="text" class="form-control" id="mgr" name="mgr" placeholder="MGR">
            </div>
            <div class="form-group">
                <label for="hiredate">HIREDATE</label>
                <input type="text" class="form-control" id="hiredate" name="hiredate" placeholder="入职日期">
            </div>
            <div class="form-group">
                <label for="sal">SAL</label>
                <input type="text" class="form-control" id="sal" name="sal" placeholder="SAL">
            </div>
            <div class="form-group">
                <label for="comm">COMM</label>
                <input type="text" class="form-control" id="comm" name="comm" placeholder="COMM">
            </div>
            <div class="form-group">
                <label for="deptno">DEPTNO</label>
                <input type="text" class="form-control" id="deptno" name="deptno" placeholder="DEPTNO">
            </div>
            <button type="submit" class="btn btn-default pull-right">保存</button>
        </form>
    </div>
</div>
</body>
</html>