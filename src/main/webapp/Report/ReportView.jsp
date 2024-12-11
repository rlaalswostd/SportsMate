<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.example.board.ReportDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>신고 상세 보기</title>
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
            margin-top: 70px;
            margin-bottom: 50px;
        }

        table {
            width: 70%;
            margin: 20px auto;
            border-collapse: separate;
            border-spacing: 0;
            background-color: #2a2a2a;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        th, td {
            padding: 12px;
            text-align: center;
            border-bottom: 2px solid #444;
        }

        th {
            background-color: #9ab4d0; /* 밝은 시에라 블루 */
            color: white;
        }

        td {
            background-color: #333;
            color: #e0e0e0;
        }

        .button-container {
            text-align: center;
            margin: 20px auto;
        }

        button {
            background-color: #9ab4d0; /* 밝은 시에라 블루 */
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s;
            font-size: 16px;
            margin: 10px;
        }

        button:hover {
            background-color: #8fa1c4; /* 조금 더 어두운 밝은 시에라 블루 */
        }

        .section-container {
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
<h2>신고 상세 보기</h2>

<!-- 게시글 정보 테이블 -->
<div class="section-container">
    <table border="1">
        <colgroup>
            <col width="15%" />
            <col width="35%" />
            <col width="15%" />
            <col width="*" />
        </colgroup>
        <tr>
            <td>번호</td>
            <td>${dto.num}</td>
            <td>작성자</td>
            <td>${dto.userid}</td>
        </tr>
        <tr>
            <td>작성일</td>
            <td>${dto.postdate}</td>
            <td>조회수</td>
            <td>${dto.visitcount}</td>
        </tr>
    </table>
</div>

<div class="section-separator"></div>

<!-- 게시글 상세 내용 테이블 -->
<div class="section-container">
    <table border="1">
        <colgroup>
            <col width="15%" />
            <col width="*" />
        </colgroup>
        <tr>
            <td>제목</td>
            <td>${dto.title}</td>
        </tr>
        <tr>
            <td>신고 사유</td>
            <td>${dto.report}</td>
        </tr>
        <tr>
            <td>내용</td>
            <td>${dto.detail}</td>
        </tr>
        <tr>
            <td>첨부파일</td>
            <td>
                <c:if test="${not empty dto.sfile and isImage}">
                    <img src="${pageContext.request.contextPath}/resources/img/${dto.sfile}" style="max-width: 100%; border-radius: 8px;" />
                </c:if>
                <c:if test="${empty dto.sfile or not isImage}">
                    <p>첨부파일이 없습니다.</p>
                </c:if>
            </td>
        </tr>
    </table>
</div>

<div class="button-container">
    <%
        ReportDTO dto = (ReportDTO) request.getAttribute("dto");
        // 세션과 게시글 작성자 정보 가져오기
        String sessionId = (String) session.getAttribute("userid");
        String role = (String) session.getAttribute("role");
        String postUserId = dto.getUserid(); // 게시글의 작성자 ID
        String num = request.getParameter("num");

        if (sessionId != null) {
            if ("admin".equals(role) && !sessionId.equals(postUserId)) {
                // 관리자인 경우: 삭제하기 버튼만 표시
    %>
    <button type="button" onclick="location.href='/Report/ReportDeleteProcess.jsp?num=<%= num %>';">
        (관리자 권한) 삭제하기
    </button>
    <%
    } else if (sessionId.equals(postUserId)) {
        // 게시글 작성자일 경우: 수정하기와 삭제하기 버튼 표시
    %>
    <button type="button" onclick="location.href='/mvcboard/ReportEdit.do?num=<%= num %>';">
        수정하기
    </button>
    <button type="button" onclick="location.href='/Report/ReportDeleteProcess.jsp?num=<%= num %>';">
        삭제하기
    </button>
    <%
            }
        }
    %>
    <button type="button" onclick="location.href='../mvcboard/ReportList.do';">
        목록 바로가기
    </button>
</div>
</body>
</html>
