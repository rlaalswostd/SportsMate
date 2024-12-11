<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.example.board.ReportDAO" %>
<%@ page import="com.example.board.ReportDTO" %>
<%@ page import="com.example.util.JSFunction" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8"
%>

<%
    String num = request.getParameter("num");
    ReportDAO dao = new ReportDAO();
    ReportDTO dto = dao.ProjectSelectView(num);

    String sessionId = session.getAttribute("userid").toString();
    if (!sessionId.equals(dto.getUserid())) {
        JSFunction.alertBack("작성자 본인만 수정할 수 있습니다.", out);
        return;
    }

    dao.close();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>신고 게시판 수정하기</title>
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
            font-size: 24px; /* 제목 글자 크기 */
        }

        form {
            width: 60%;
            margin: 0 auto;
            background-color: #2a2a2a;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            border-radius: 12px; /* 테두리 둥글게 */
            overflow: hidden; /* 테두리 둥근 부분을 감추기 위해 */
        }

        th, td {
            padding: 15px;
            text-align: left;
            border: 1px solid #444;
            font-size: 18px; /* 글자 크기 */
        }

        th {
            background-color: #333;
            color: white;
            font-size: 15px;
        }

        td {
            background-color: #333;
            color: #e0e0e0;
        }

        input[type="text"], textarea, select {
            width: calc(100% - 24px);
            padding: 12px;
            border: 1.5px solid #444;
            border-radius: 8px;
            background-color: #333;
            color: #e0e0e0;
            box-sizing: border-box;
            font-size: 15px; /* 입력 필드 글자 크기 */
        }

        textarea {
            resize: vertical;
            height: 150px;
        }

        input[type="file"] {
            border: 1.5px solid #444;
            border-radius: 8px;
            background-color: #333;
            color: #e0e0e0;
            padding: 10px;
            width: 100%;
            font-size: 15px; /* 파일 입력 필드 글자 크기 */
        }

        button {
            background-color: #9ab4d0;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s;
            font-size: 16px; /* 버튼 글자 크기 */
            margin: 10px;
        }

        button:hover {
            background-color: #8fa1c4;
        }

        button:focus {
            outline: none;
        }

        .button-container {
            text-align: center;
            margin-top: 20px;
        }

        img {
            max-width: 100%;
            border-radius: 8px;
        }
    </style>
</head>
<body>
<h2>게시글 수정하기</h2>

<form name="writeFrm" method="post" action="/mvcboard/ReportEdit.do" enctype="multipart/form-data" onsubmit="return validateForm(this)">
    <input type="hidden" name="num" value="<%=dto.getNum()%>">
    <input type="hidden" name="prevOfile" value="${dto.ofile}">
    <input type="hidden" name="prevSfile" value="${dto.sfile}">
    <table>
        <tr>
            <th>제목</th>
            <td><input type="text" name="title" value="<%=dto.getTitle()%>" /></td>
        </tr>
        <tr>
            <th>신고 사유</th>
            <td>
                <select name="report" id="report">
                    <option value="폭행 및 폭언" ${dto.getReport().equals("폭행 및 폭언") ? "selected" : ""}>폭행 및 폭언</option>
                    <option value="먹튀" ${dto.getReport().equals("먹튀") ? "selected" : ""}>먹튀</option>
                    <option value="지각" ${dto.getReport().equals("지각") ? "selected" : ""}>지각</option>
                    <option value="사기" ${dto.getReport().equals("사기") ? "selected" : ""}>사기</option>
                    <option value="기타" ${dto.getReport().equals("기타") ? "selected" : ""}>기타</option>
                </select>
            </td>
        </tr>
        <tr>
            <th>내용</th>
            <td><textarea name="detail"><%=dto.getDetail()%></textarea></td>
        </tr>
        <tr>
            <th>첨부파일 수정</th>
            <td>
                <input type="file" name="ofile">
                <%-- 기존 첨부파일 미리보기 --%>
                <c:if test="${not empty dto.ofile and isImage == true}">
                    <img src="/Testupload/${dto.sfile}" alt="첨부파일"/>
                </c:if>
            </td>
        </tr>
    </table>

    <div class="button-container">
        <button type="button" onclick="location.href='../mvcboard/ReportList.do';">목록 보기</button>
        <button type="reset">다시 입력</button>
        <button type="submit">작성 완료</button>
    </div>
</form>

<script type="text/javascript">
    function validateNumber(input) {
        if (isNaN(input.value) || input.value.trim() === '') {
            input.value = '';
            alert('숫자만 입력할 수 있습니다.');
        }
    }
    function validateForm(form) {
        if (!form.title.value) {
            alert("제목을 입력하세요");
            form.title.focus();
            return false;
        } else if (!form.dates.value) {
            alert("날짜를 입력하세요");
            form.dates.focus();
            return false;
        } else if (!form.report.value) {
            alert("신고 사유를 선택하세요");
            form.report.focus();
            return false;
        } else if (!form.detail.value) {
            alert("세부내용을 입력하세요");
            form.detail.focus();
            return false;
        }
        return true;
    }
</script>
</body>
</html>
