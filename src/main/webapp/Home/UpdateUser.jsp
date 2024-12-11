<%@ page import="com.example.common.JDBCConnect" %>
<%@ page import="com.example.main.UserDTO" %>
<%@ page import="com.example.main.UserDAO" %>
<%@ page import="java.sql.Connection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>

<%
  // 데이터베이스 연결 정보를 가져옵니다.
  String driver = application.getInitParameter("OracleDriver");
  String url = application.getInitParameter("OracleURL");
  String dbId = application.getInitParameter("OracleId");
  String dbPwd = application.getInitParameter("OraclePwd");

  // 데이터베이스 연결을 설정합니다.
  JDBCConnect jdbc = new JDBCConnect(driver, url, dbId, dbPwd);
  Connection conn = jdbc.conn;

  if (conn == null) {
    out.println("Database connection failed.");
  } else {
    UserDAO userDAO = new UserDAO(conn);

    // 사용자 입력 값 가져오기
    String userId = request.getParameter("USERID");
    String userPwd = request.getParameter("USERPWD");
    String userName = request.getParameter("USERNAME");

    boolean isUserUpdated = false;
    boolean isPasswordUpdated = false;

    // 현재 DB에 저장된 사용자 정보 가져오기
    UserDTO currentUser = userDAO.getUserById(userId);
    String currentPassword = currentUser.getUserpwd();
    String currentUsername = currentUser.getUsername();

      // 사용자 정보 업데이트 처리
//      if (userId != null && userName != null) {
//          // UserDTO 객체를 생성하여 사용자 정보를 설정합니다.
//          UserDTO user = new UserDTO(userId, userPwd, userName, null, null);
//
//          if (userDAO.isUsernameUN(userName)) {
//              out.println("<script>alert('중복된 이름입니다. 다른 이름을 사용해주세요.'); location.href='/mvcboard/MainHome.do';</script>");
////        out.println("<script>alert('중복된 이름입니다. 다른 이름을 사용해주세요.'); location.href='MyPage.jsp';</script>");
//          } else {
//              // 사용자 정보 업데이트
//              isUserUpdated = userDAO.updateUser(user);
//          }
//      }

    // 사용자 정보 업데이트 처리
    if (userName != null && !userName.trim().isEmpty() && !userName.equals(currentUsername)) {
      userName = userName.trim();  // 공백 제거 후 다시 userName에 저장
      if (!userDAO.isUsernameUN(userName)) {
        currentUser.setUsername(userName);
        isUserUpdated = userDAO.updateUser(currentUser);
      } else {
        out.println("<script>alert('중복된 이름입니다. 다른 이름을 사용해주세요.'); location.href='Mypage.jsp';</script>");
//          out.println("<script>alert('중복된 이름입니다. 다른 이름을 사용해주세요.'); location.href='/mvcboard/MainHome.do';</script>");
        return;
      }
    }

    // 비밀번호 업데이트 처리
    if (userPwd != null && !userPwd.trim().isEmpty() && !userPwd.equals(currentPassword)) {
      currentUser.setUserpwd(userPwd);
      isPasswordUpdated = userDAO.updatePassword(userId, userPwd);
    }

    // 변경된 정보가 없는 경우 처리
    if (!isUserUpdated && !isPasswordUpdated) {
      out.println("<script>alert('변경된 정보가 없습니다. 현재 비밀번호로는 변경되지 않습니다.'); location.href='Mypage.jsp';</script>");
      return;
    }

    if (isUserUpdated || isPasswordUpdated) {
      if (isUserUpdated) {
        session.setAttribute("username", userName); // 세션에 USERNAME 저장
      }
      out.println("<script>alert('정보 수정 성공'); location.href='/mvcboard/MainHome.do';</script>");
    } else {
      out.println("<script>alert('정보 수정 실패'); location.href='/mvcboard/MainHome.do';</script>");
    }

    jdbc.close();
  }
%>
