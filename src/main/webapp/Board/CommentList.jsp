<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8"
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
<c:forEach items="${comments}" var="comment">
    <li id="comment-${comment.id}">
        <p><strong>${comment.username}</strong>: ${comment.content}</p>
        <p><small>${comment.postdate}</small></p>
        <c:if test="${sessionScope.username == comment.username}">
            <a href="#" class="delete-comment" data-id="${comment.id}">삭제</a>
        </c:if>
    </li>
</c:forEach>

</body>
</html>
