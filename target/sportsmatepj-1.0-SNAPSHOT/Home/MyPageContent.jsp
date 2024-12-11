<%@ page import="com.example.main.UserDTO" %>
<%@ page import="com.example.main.UserDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>

<%
  UserDTO user = (UserDTO) request.getAttribute("user");
  session.setAttribute("userId", user.getUserid());
  session.setAttribute("userPic", user.getUserpic());
  String profilepic = (String)session.getAttribute("userpic");

%>

<html>
<head>
  <meta charset="UTF-8">
  <title>마이페이지</title>

  <style>
    body {
      background-color: #121212;
      color: #e0e0e0;
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
    }

    .Mypage {
      display: flex;
      flex-direction: column;
      align-items: center;
      min-height: 100vh;
      padding: 50px;
    }

    .section {
      background-color: #1e1e1e;
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.5);
      padding: 35px;
      margin-bottom: 30px;
      width: 100%;
      max-width: 600px;
      text-align: center;
    }

    .section h1, .section h2 {
      color: #ffffff;
    }

    .section img {
      border-radius: 15px;
      margin-bottom: 20px;
      display: block; /* Ensure the image is treated as a block element */
      margin-left: auto;
      margin-right: auto;
    }

    .form-group {
      text-align: left;
      display: flex;
      flex-direction: column;
      align-items: center;
    }

    label {
      display: block;
      margin-bottom: 8px;
      color: #ffffff;
      width: 100%;
    }

    input[type="text"], input[type="password"], input[type="file"] {
      width: 100%;
      padding: 15px;
      margin-bottom: 35px;
      border: 1.5px solid #333;
      border-radius: 15px;
      background-color: #2e2e2e;
      color: #e0e0e0;
      font-size: 16px;
      box-sizing: border-box;
    }

    input[type="submit"], button {
      background-color: #ffffff;
      color: #000000;
      border: none;
      padding: 12px 20px;
      border-radius: 5px;
      font-size: 16px;
      cursor: pointer;
      transition: background-color 0.3s, color 0.3s;
      margin: 10px;
    }

    input[type="submit"]:hover, button:hover {
      background-color: #f0f0f0;
      color: #333333;
    }

    .upload_btn {
      background-color: #ffffff;
      color: #000000;
      border: none;
      padding: 12px 30px;
      border-radius: 5px;
      font-size: 16px;
      cursor: pointer;
      transition: background-color 0.3s, color 0.3s;
      margin-top: 20px;
      display: inline-block; /* Make the button an inline block to center */
    }

    .upload_btn:hover {
      background-color: #f0f0f0;
      color: #333333;
    }

    .edit_btn {
      background-color: #ffffff;
      color: #000000;
      border: none;
      padding: 12px 60px;
      border-radius: 15px;
      font-size: 16px;
      cursor: pointer;
      transition: background-color 0.3s, color 0.3s;
      margin: 10px;
    }

    .edit_btn:hover {
      background-color: #f0f0f0;
      color: #333333;
    }

    .footer {
      text-align: center;
    }

    .footer a {
      color: #ffffff;
      text-decoration: none;
      font-size: 16px;
      display: block;
      margin-top: 10px;
    }

    .footer a:hover {
      text-decoration: underline;
    }
  </style>
</head>

<body>
<div class="Mypage">
  <div class="section">
    <h1>마 이 페 이 지</h1>

    <div>
      <!-- 프로필 사진 표시 -->
      <%
        String userId = (String)session.getAttribute("userId");
        String userpic = (String)session.getAttribute("userPic"); // DB에서 가져온 프로필 사진 경로
        if (userpic != null) {
      %>
      <img src="<%= request.getContextPath() + "/uploads/" + userId + "propic.jpg" %>" alt="프로필 사진" style="width: 200px;" />
      <%
      } else {
      %>
      <img src="<%= request.getContextPath() + "/resources/img/profile.png" %>" alt="기본 프로필 사진" style="width: 150px;" />
      <%
        }
      %>
    </div>

    <form action="UpdateUser.jsp" method="post">
      <div class="form-group">
        <label>회원님의 ID</label>
        <input type="text" name="USERID" value="<%= user.getUserid() %>" readonly>

        <label>변경할 비밀번호</label>
        <input type="password" name="USERPWD" placeholder="새 비밀번호를 입력하세요">

        <label>변경할 닉네임</label>
        <input type="text" name="USERNAME" placeholder="<%= user.getUsername() %>">

        <button type="submit" class="edit_btn">수정완료</button>
        <button type="button" class="edit_btn" onclick="history.back()">돌아가기</button>
      </div>
    </form>
  </div>

  <div class="section">
    <h2>프로필 사진 변경</h2>
    <form action="../MyPageContent.do" method="post" enctype="multipart/form-data">
      <input type="file" class="upload_btn" name="USERPIC" />
      <input type="submit" class="upload_btn" value="변경완료" />
    </form>
  </div>

  <div class="footer">
    <form action="${pageContext.request.contextPath}/DeleteUserServlet" method="post">
      <input type="hidden" name="userId" value="${sessionScope.user.userId}">
      <button style="background-color: transparent; color: white;" type="submit" onclick="return confirm('정말로 탈퇴하시겠습니까?')">회원 탈퇴</button>
    </form>
  </div>
</div>
</body>
</html>

