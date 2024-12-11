<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile</title>
    <style>
        body {
            background-color: #121212;
            color: #e0e0e0;
        }

        .profile {
            margin: 20px;
            padding: 20px;
            background-color: #1e1e1e;
            border-radius: 8px;
        }

        h2 {
            color: #ffffff;
        }

        p, h3 {
            color: #e0e0e0;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            color: #e0e0e0;
        }

        th, td {
            border: 1px solid #333;
            padding: 8px;
        }

        th {
            background-color: #333;
            color: #ffffff;
        }

        tr:nth-child(even) {
            background-color: #2c2c2c;
        }

        tr:nth-child(odd) {
            background-color: #1e1e1e;
        }

        a {
            color: #ffffff;
            text-decoration: none;
            padding: 10px;
            border: 1px solid #ffffff;
            border-radius: 4px;
            display: inline-block;
            margin-top: 10px;
            background-color: #333;
        }

        a:hover {
            background-color: #555;
        }
    </style>
</head>
<body>
<div class="profile">
    <h2>Profile</h2>
    <p><b>닉네임:</b> <c:out value="${user.username}" /></p>
    <p><b>점수:</b> <c:out value="${user.userpt}" /></p>

    <h3>Recent Posts:</h3>
    <table>
        <thead>
        <tr>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="post" items="${userPosts}">
            <tr>
                <td><c:out value="${post.title}" /></td>
                <td><c:out value="${post.username}" /></td>
                <td><c:out value="${post.postdate}" /></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <a id="closeButton" href="#" style="display: flex; justify-content: center; margin-left: 220px; margin-right: 220px">Close</a>
</div>

<script>
    document.getElementById('closeButton').addEventListener('click', function(event) {
        event.preventDefault();
        window.close();
    });
</script>

</body>
</html>
