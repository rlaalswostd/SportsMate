<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>회원 탈퇴 완료</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #121212;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            color: #e0e0e0;
        }
        .container {
            background-color: #1e1e1e;
            border-radius: 12px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
            padding: 60px;
            max-width: 400px;
            text-align: center;
        }
        h1 {
            color: #e0e0e0;
            margin-bottom: 30px;
        }
        p {
            color: #b0b0b0;
            font-size: 16px;
            margin-bottom: 40px;
        }
        .button {
            display: inline-block;
            padding: 10px 20px;
            font-size: 16px;
            color: #ffffff;
            background-color: #b0d6f3;
            border: none;
            border-radius: 4px;
            text-decoration: none;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }
        .button:hover {
            background-color: #8ec4e6; 
            transform: scale(1.05);
        }
    </style>
</head>
<body>

<div class="container">
    <h1>회원 탈퇴 완료</h1>
    <p>안녕히 가세요! <br> ( _ _ )</p>
    <a href="${pageContext.request.contextPath}/index.jsp" class="button">홈으로 돌아가기</a>
</div>

</body>
</html>
