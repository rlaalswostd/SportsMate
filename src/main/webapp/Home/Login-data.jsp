<%@ page import="com.example.common.JDBCConnect" %>
<%@ page import="com.example.main.UserDTO" %>
<%@ page import="com.example.main.UserDAO" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.text.ParseException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>

<%
    // 데이터베이스 연결 정보 설정
    String driver = application.getInitParameter("OracleDriver");
    String url = application.getInitParameter("OracleURL");
    String dbId = application.getInitParameter("OracleId");
    String dbPwd = application.getInitParameter("OraclePwd");

    JDBCConnect jdbc = new JDBCConnect(driver, url, dbId, dbPwd);
    Connection conn = jdbc.conn;

    if (conn == null) {
        out.println("Database connection failed.");
    } else {
        // 요청 파라미터 가져오기
        String userId = request.getParameter("USERID");
        String userPwd = request.getParameter("USERPWD");

        // UserDAO와 UserDTO를 사용하여 사용자 인증
        UserDAO userDAO = new UserDAO(conn);

        // 사용자 인증 및 사용자 정보 가져오기
        if (userDAO.validateUser(new UserDTO(userId, userPwd, null, null, null, null))) {
            UserDTO user = userDAO.getUserById(userId);
            if (user != null) {
                String userName = user.getUsername();
                String userPic = user.getUserpic(); // 프로필 사진 경로

                // 세션에 사용자 정보 저장
                session.setAttribute("loggedIn", true);
                session.setAttribute("userid", userId);
                session.setAttribute("username", userName);
                session.setAttribute("userPic", userPic);
                session.setAttribute("role", user.getRole()); // 사용자 역할 설정

//                response.sendRedirect("MainHome.jsp");
                response.sendRedirect("/mvcboard/MainHome.do");
            } else {
                out.println("<script>alert('사용자 정보를 찾을 수 없습니다.'); location.href='Login.jsp';</script>");
            }
        } else {
            out.println("<script>alert('ID 또는 PWD가 맞지 않습니다'); location.href='Login.jsp';</script>");
        }

        jdbc.close();
    }
%>