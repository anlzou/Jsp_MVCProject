package cn.edu.hcnu.servlet;

import cn.edu.hcnu.dao.IEmpDao;
import cn.edu.hcnu.dao.impl.EmpDaoImlp;
import cn.edu.hcnu.model.Emp;
import cn.edu.hcnu.until.PageModel;
import com.google.gson.Gson;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;


@WebServlet(name = "EmpServlet")
public class EmpServlet extends HttpServlet {
    IEmpDao empDao = new EmpDaoImlp();
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    public void viewEmp(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String page = request.getParameter("page");
        if (page == null){
            PageModel pm = empDao.viewEmp(page);
            request.setAttribute("pm", pm);//查询后的员工信息
            request.getRequestDispatcher("selectEmp.jsp").forward(request, response);
        }else {
            PageModel pm = empDao.viewEmp(page);
            //request.setAttribute("pm", pm);//查询后的员工信息
            /*
            把Pagemodel转化为json格式
            1.fastjosn
            2.Google的gson
             */
            Gson gson = new Gson();
            //服务器要给客户端（浏览器）响应数据（把json格式的数据传给浏览器）
            response.setContentType("application/json;charset=utf-8");//设置给客户端响应的类型
            //用Java输入流把json数据发送浏览器
            PrintWriter out = response.getWriter();
            out.write(gson.toJson(pm));
            out.flush();//刷新缓冲区（把缓冲区的数据发送走，即清空缓冲区）
            out.close();
            response.sendRedirect("selectEmp.jsp");
        }
    }

    public void saveEmp(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String empno = request.getParameter("empno");
        String ename = request.getParameter("ename");
        String job = request.getParameter("job");
        String mgr = request.getParameter("mgr");
        String hiredate = request.getParameter("hiredate");
        String sal = request.getParameter("sal");
        String comm = request.getParameter("comm");
        String deptno = request.getParameter("deptno");
        Emp emp = new Emp();
        emp.setEmpno(Integer.parseInt(empno));
        emp.setEname(ename);
        emp.setJob(job);
        emp.setMgr(Integer.parseInt(mgr));
        emp.setHiredate(java.sql.Date.valueOf(hiredate));
        emp.setSal(Integer.parseInt(sal));
        emp.setComm(Integer.parseInt(comm));
        emp.setDeptno(Integer.parseInt(deptno));
        empDao.saveEmp(emp);

        request.getRequestDispatcher("viewEmp").forward(request, response);
    }

    public void deleteEmp(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String empno = request.getParameter("empno");
        empDao.deleteEmp(empno);
        response.sendRedirect("viewEmp");
    }

    public void updateEmp(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String empno = request.getParameter("empno");
        Emp emp = empDao.updateEmp(empno);
        request.setAttribute("emp", emp);
        //请求转发
        request.getRequestDispatcher("updateEmp.jsp").forward(request, response);
    }

    public void modifyEmp(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String empno = request.getParameter("empno");
        String ename = request.getParameter("ename");
        String job = request.getParameter("job");
        String mgr = request.getParameter("mgr");
        String hiredate = request.getParameter("hiredate");
        String sal = request.getParameter("sal");
        String comm = request.getParameter("comm");
        String deptno = request.getParameter("deptno");
        Emp emp = new Emp();
        emp.setEmpno(Integer.parseInt(empno));
        emp.setEname(ename);
        emp.setJob(job);
        emp.setMgr(Integer.parseInt(mgr));
        emp.setHiredate(java.sql.Date.valueOf(hiredate));
        emp.setSal(Integer.parseInt(sal));
        emp.setComm(Integer.parseInt(comm));
        emp.setDeptno(Integer.parseInt(deptno));
        empDao.modifyEmp(emp);

        //request.setAttribute("page",2);
        request.getRequestDispatcher("viewEmp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uri = request.getRequestURI();
        uri = uri.substring(1);
        if ("viewEmp".equals(uri)) {
            viewEmp(request, response);
        } else if ("saveEmp".equals(uri)) {
            saveEmp(request, response);
        } else if ("deleteEmp".equals(uri)) {
            deleteEmp(request, response);
        } else if ("modifyEmp".equals(uri)) {
            modifyEmp(request, response);
        } else if ("updateEmp".equals(uri)) {
            updateEmp(request, response);
        }
    }

}
