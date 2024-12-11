<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>신고 게시판</title>
    <style>
        body {
            background-color: #1e1e1e;
            color: #e0e0e0;
            margin: 0;
            padding: 0;
        }

        h2 {
            color: #ffffff;
            text-align: center;
            margin-top: 50px;
        }

        .search-container {
            display: flex;
            justify-content: center;
            margin: 30px auto;
            width: 80%;
        }

        .search-form {
            display: flex;
            width: 100%;
            gap: 10px;
        }

        .search-form select,
        .search-form input[type="text"],
        .search-form input[type="submit"] {
            padding: 12px;
            border: 1px solid #444;
            border-radius: 8px;
            background-color: #333;
            color: #e0e0e0;
            font-size: 16px;
        }

        .search-form input[type="submit"] {
            background-color: #9ab4d0; /* 더 밝은 시에라 블루 */
            border: none;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s;
            padding: 12px 24px;
        }

        .search-form input[type="submit"]:hover {
            background-color: #8fa1c4; /* 조금 더 어두운 밝은 시에라 블루 */
        }

        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: separate;
            border-spacing: 0;
            background-color: #2a2a2a;
            border-radius: 12px;
            border: 2px solid #333;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        th, td {
            padding: 12px;
            text-align: center;
        }

        th {
            background-color: #9ab4d0; /* 더 밝은 시에라 블루 */
            color: white;
        }

        .hidden-info {
            color: #888;
        }

        .button-container {
            text-align: center;
            margin: 20px auto;
        }

        button {
            background-color: #9ab4d0; /* 더 밝은 시에라 블루 */
            color: white; /* 글자색 */
            border: none;
            padding: 12px 24px;
            border-radius: 8px; /* 둥근 모서리 */
            cursor: pointer;
            transition: background-color 0.3s;
            font-size: 16px;
            margin: 10px;
        }

        button:hover {
            background-color: #8fa1c4; /* 조금 더 어두운 밝은 시에라 블루 */
        }

        .question-container {
            text-align: center;
            margin: 150px auto;
        }

        .question-button {
            background-color: #f4b400;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s;
            font-size: 16px;
            margin: 10px;
        }

        .question-button:hover {
            background-color: #c77c0f;
        }
    </style>
</head>
<body>
<h2>신고 게시판</h2>

<!-- 검색 폼 -->
<div class="search-container">
    <form class="search-form" method="get">
        <select name="searchField">
            <option value="title">제목</option>
            <option value="userid">작성자</option>
        </select>
        <input type="text" name="searchWord" value="${param.searchWord}" placeholder="검색어를 입력하세요">
        <input type="submit" value="검색">
    </form>
</div>

<!-- 게시물 목록 테이블 -->
<table>
    <tr>
        <th>번호</th>
        <th>신고 사유</th>
        <th>제목</th>
        <th>작성자</th>
        <th>조회수</th>
        <th>작성일</th>
    </tr>

    <!-- 게시물이 유무에 따른 상태 -->
    <c:choose>
        <c:when test="${empty boardList}">
            <!-- 게시글이 없을 때 -->
            <tr>
                <td colspan="6" align="center">
                    등록된 게시물이 없습니다.
                </td>
            </tr>
        </c:when>
        <c:otherwise>
            <!-- 게시글이 있을 때 -->
            <c:forEach items="${boardList}" var="row" varStatus="loop">
                <tr>
                    <!-- 번호 -->
                    <td>${row.num}</td>

                    <!-- 신고 사유 -->
                    <td>${row.report}</td>

                    <!-- 제목 -->
                    <td align="left">
                        <c:choose>
                            <c:when test="${sessionScope.userid != null && (sessionScope.userid == row.userid || sessionScope.role == 'admin')}">
                                <a href="../mvcboard/ReportView.do?num=${row.num}" style="color: #007bff; text-decoration: none;">${row.title}</a>
                            </c:when>
                            <c:otherwise>
                                <span class="hidden-info">***</span>
                            </c:otherwise>
                        </c:choose>
                    </td>

                    <!-- 작성자 -->
                    <td>
                        <c:choose>
                            <c:when test="${sessionScope.userid != null && (sessionScope.userid == row.userid || sessionScope.role == 'admin')}">
                                ${row.userid}
                            </c:when>
                            <c:otherwise>
                                <span class="hidden-info">***</span>
                            </c:otherwise>
                        </c:choose>
                    </td>

                    <!-- 조회수 -->
                    <td>${row.visitcount}</td>

                    <!-- 작성일 -->
                    <td>${row.postdate}</td>
                </tr>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</table>

<div style="text-align: center">${map.pagingImg}</div>

<!-- 버튼 컨테이너 -->
<div class="button-container">
    <!-- 글쓰기 버튼 -->
    <button type="button" id="write-button" onclick="location.href='../mvcboard/ReportWrite.do'">
        글쓰기
    </button>

    <!-- 메인으로 이동 버튼 -->
    <button type="button" onclick="location.href='../mvcboard/MainHome.do'">메인으로 이동</button>
</div>

<!-- 질문하기 버튼 -->
<div class="question-container">
    <p>질문 사항이 있으신 분은 '질문하기' 버튼을 눌러주세요</p>
    <button class="question-button" onclick="window.open('https://pf.kakao.com/yourchannel', '_blank')">
        질문하기
    </button>
</div>

<script>
    document.getElementById('write-button').addEventListener('click', function() {
        const isLoggedIn = ${sessionScope.userid != null}; // JSP에서 로그인 여부를 JavaScript로 전달
        if (isLoggedIn) {
            window.location.href = '../mvcboard/ReportWrite.do';
        } else {
            alert('로그인 해주세요');
            window.location.href = '../Home/Login.jsp'; // 로그인 페이지로 리디렉션
        }
    });
</script>
</body>
</html>
