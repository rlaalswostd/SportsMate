<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.main.UserDTO" %>
<html>
<head>
    <style>
        .profile-info img {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 50%;
        }
        .profile-info p {
            margin: 5px 0;
        }
    </style>
</head>
<body>
<div class="profile-info">
    <img src="<c:out value='${user.userpic}' />" alt="Profile Picture" />
    <p><strong>Username:</strong> <c:out value="${user.username}" /></p>
    <p><strong>Score:</strong> <c:out value="${user.userpt}" /></p>
</div>
</body>
</html>