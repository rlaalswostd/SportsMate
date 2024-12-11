<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8"%>
<%@ page import="com.example.main.UserDTO" %>
<%@ page import="com.example.main.UserDAO" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%
    UserDTO user = (UserDTO) request.getAttribute("user");
    String userid = (String) session.getAttribute("userid");
    String username = (String) session.getAttribute("username");
    String profilepic = (String) session.getAttribute("userPic");
    System.out.println("Profile Picture Path: " + session.getAttribute("userPic"));
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sportsmate 로그인</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/Login.css">
</head>
<body>
<div class="container">
    <div class="login-section">
        <div id="login" class="login-container">
            <%
                if (userid == null) {
            %>
            <form action="/Home/Login-data.jsp" method="post" class="login-form">
                <h2 class="login_title">Sportsmate</h2>
                <p class="login_subtitle"><b>회 원 로 그 인</b></p>
                <div class="user_info">
                    <input type="text" name="USERID" id="id" autocomplete="off" required placeholder="ID">
                    <label for="id"></label>
                </div>
                <div class="user_info">
                    <input type="password" name="USERPWD" id="pw" autocomplete="off" required placeholder="PWD">
                    <label for="pw"></label>
                </div>
                <div class="login_btn">
                    <input type="submit" id="login_button" value="로그인">
                </div>

                <div class="caption">
                    <p>혹시 Sportsmate가 처음이세요?
                    <a href="../Home/MemPlus.jsp" target="_blank" class="signup-link"> 회원가입</a></p>
                </div>
            </form>
            <%
            } else {
            %>
            <div class="login_box">
                <h2 class="login_title">Sportsmate</h2>
                <div class="profile">
                    <%
                        String userId = (String)session.getAttribute("userId");
                        String userpic = (String)session.getAttribute("userPic");
                        if (userpic != null) {
                    %>
                    <img src="<%= request.getContextPath() + "../uploads/" + userid + "propic.jpg" %>" alt="프로필 사진">
                    <%
                    } else {
                    %>
                    <img src="<%= request.getContextPath() + "../resources/img/profile.png" %>" alt="기본 프로필 사진">
                    <%
                        }
                    %>
                </div>
                <div class="hello">어서오세요 <%= username %> 님</div>
                <div class="box-button">
                    <a href="../Home/Mypage.jsp" class="mypage-button">마이페이지</a>
                    <a href="../Home/Logout.jsp" class="logout-button">로그아웃</a>
                </div>

                <div class="box-button2">
                    <a href="../Home/MainHome.jsp" class="Home-button">Home</a>
                </div>
            </div>
            <%
                }
            %>
        </div>
    </div>
</div>
</body>
</html>


