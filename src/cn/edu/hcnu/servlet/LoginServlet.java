package cn.edu.hcnu.servlet;

import cn.edu.hcnu.Dal.Dal;
import cn.edu.hcnu.model.Emp;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;
import java.util.List;

public class LoginServlet extends javax.servlet.http.HttpServlet {
    protected void doPost(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
        String uri = request.getRequestURI();
        uri = uri.substring(1);
        if ("LoginServlet".equals(uri)){
            select(request,response);
        }else if ("exit".equals(uri)){
            HttpSession session = request.getSession();
            session.invalidate();
            response.sendRedirect("login.html");
        }
    }

    void select(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
        Dal dal = new Dal();
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Connection conn = null;
        ResultSet reset = null;
        PreparedStatement pstm = null;

        String sql_user_id = "SELECT * FROM t_users where user_id = ? and password = ?";
        String sql_emp = "select * from (select ROWNUM rn,t.* from(select * from EMP) t where ROWNUM<=?) where rn>=?";

        dal.currentPage = 1;
        int startRow = (dal.currentPage-1)*dal.pageSize+1;
        int endRow = dal.currentPage*dal.pageSize;

        //加载驱动
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(dal.url, dal.username, dal.password);

            pstm = conn.prepareStatement(sql_user_id);
            pstm.setString(1, username);
            pstm.setString(2, password);
            reset = pstm.executeQuery();

            if (reset.next()) {
                QueryRunner queryRunner = new QueryRunner();
                HttpSession httpSession = request.getSession();

                List empList = queryRunner.query(conn,sql_emp,new BeanListHandler<Emp>(Emp.class),endRow,startRow);
                request.setAttribute("empList", empList);
                httpSession.setAttribute("username", username);
                //请求转发
                response.sendRedirect("viewEmp");
                //request.getRequestDispatcher("selectEmp.jsp").forward(request, response);
            } else {
                response.sendRedirect("login.html");
            }

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                reset.close();
                pstm.close();
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
