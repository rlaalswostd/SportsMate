<%@ page import="com.example.common.JDBCConnect" %>
<%@ page import="com.example.main.UserDTO" %>
<%@ page import="com.example.main.UserDAO" %>
<%@ page import="java.sql.Connection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>

<%
    String driver = application.getInitParameter("OracleDriver");
    String url = application.getInitParameter("OracleURL");
    String dbId = application.getInitParameter("OracleId");
    String dbPwd = application.getInitParameter("OraclePwd");

    JDBCConnect jdbc = new JDBCConnect(driver, url, dbId, dbPwd);
    Connection conn = jdbc.conn;

    if (conn == null) {
        out.println("Database connection failed.");
    } else {
        String userId = (String) session.getAttribute("userid");
        if (userId == null) {
            response.sendRedirect("index.jsp");
        } else {
            UserDAO userDAO = new UserDAO(conn);
            UserDTO user = userDAO.getUserById(userId);

            if (user == null) {
//                out.println("<script>alert('사용자 정보를 가져오는 데 실패했습니다.'); location.href='MainHome.jsp';</script>");
                out.println("<script>alert('사용자 정보를 가져오는 데 실패했습니다.'); location.href='/mvcboard/MainHome.do';</script>");
            } else {
                request.setAttribute("user", user);
                RequestDispatcher dispatcher = request.getRequestDispatcher("MyPageContent.jsp");
                dispatcher.forward(request, response);
            }
        }
        jdbc.close();
    }
%>