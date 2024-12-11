<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.example.board.TestBoardDAO" %>
<%@ page import="com.example.board.TestBoardDTO" %>
<%@ page import="com.example.util.JSFunction" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8"
%>

<%
    String num = request.getParameter("num");
    TestBoardDAO dao = new TestBoardDAO();
    TestBoardDTO dto = dao.ProjectSelectView(num);

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
    <title>회원제 게시판</title>
    <style>
        body {
            background-color: #121212;
            color: #e0e0e0;
            margin: 0;
            padding: 0;
        }

        h2 {
            color: #ffffff;
            text-align: center;
            margin-top: 75px;
        }

        form {
            width: 80%;
            margin: 20px auto;
            background-color: #1e1e1e;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .form-row {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 20px;
            margin-top: 25px;
        }

        .form-row label {
            width: 150px;
            font-weight: bold;
            color: #e0e0e0;
            margin-right: 20px;
        }

        .form-row input[type="text"],
        .form-row input[type="number"],
        .form-row input[type="date"],
        .form-row select,
        .form-row textarea,
        .form-row input[type="file"] {
            flex: 1;
            padding: 12px;
            border: 1px solid #555;
            border-radius: 8px;
            background-color: #333;
            color: #e0e0e0;
            font-size: 16px;
        }

        .form-row textarea {
            height: 120px;
            resize: vertical;
        }

        .form-row input[type="file"] {
            padding: 20px;
        }

        .center {
            text-align: center;
        }

        button {
            background-color: #ffffff;
            color: #000000;
            border: 2px solid #ffffff;
            padding: 12px 24px;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s, color 0.3s, border-color 0.3s;
            margin: 10px;
            font-size: 16px;
        }

        button:hover {
            background-color: #f0f0f0;
            color: #000000;
            border-color: #f0f0f0;
        }
    </style>

    <script type="text/javascript">
        function validateNumber(input) {
            if (isNaN(input.value) || input.value.trim() === '') {
                input.value = '';
                alert('숫자만 입력할 수 있습니다.');
            }
        }

        function validateForm(form) {
            var peopleInput = form.people;
            if (peopleInput.value.trim() === '' || isNaN(peopleInput.value)) {
                alert('모집 인원은 필수 입력 사항이며 숫자만 입력할 수 있습니다.');
                peopleInput.focus();
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
<h2>게시글 수정하기</h2>
<form name="writeFrm" method="post" action="/mvcboard/ProjectEdit.do"
      enctype="multipart/form-data" onsubmit="return validateForm(this)">
    <input type="hidden" name="num" value="<%=dto.getNum()%>">
    <input type="hidden" name="prevOfile" value="${dto.ofile}">
    <input type="hidden" name="prevSfile" value="${dto.sfile}">

    <div class="form-row">
        <label for="title">제목</label>
        <input type="text" id="title" name="title" value="<%=dto.getTitle()%>">
    </div>

    <div class="form-row">
        <label for="dates">날짜</label>
        <input type="date" id="dates" name="dates" value="<%=dto.getDates()%>">
    </div>

    <div class="form-row">
        <label for="sport">종목</label>
        <select name="sport" id="sport">
            <option value="배드민턴" <%=dto.getSport().equals("배드민턴") ? "selected" : ""%>>배드민턴</option>
            <option value="탁구" <%=dto.getSport().equals("탁구") ? "selected" : ""%>>탁구</option>
            <option value="클라이밍" <%=dto.getSport().equals("클라이밍") ? "selected" : ""%>>클라이밍</option>
            <option value="테니스" <%=dto.getSport().equals("테니스") ? "selected" : ""%>>테니스</option>
        </select>
    </div>

    <div class="form-row">
        <label for="people">모집 인원</label>
        <input type="number" id="people" name="people" value="<%=dto.getPeople()%>" oninput="validateNumber(this)">
    </div>

    <div class="form-row">
        <label for="detail">내용</label>
        <textarea id="detail" name="detail"><%=dto.getDetail()%></textarea>
    </div>

    <div class="form-row">
        <label for="ofile">썸네일 수정</label>
        <input type="file" id="ofile" name="ofile">
    </div>

    <div class="form-row center">
        <button type="button" onclick="location.href='../mvcboard/MainHome.do';">목록 보기</button>
        <button type="reset">다시 입력</button>
        <button type="submit">작성 완료</button>
    </div>
</form>
<script>
    // 현재 날짜를 기준으로 최대 2달까지 선택가능
    const today = new Date();
    const twoMonthsLater = new Date(today);
    twoMonthsLater.setMonth(today.getMonth() + 2);

    const formatDate = (date) => {
        return date.toISOString().split('T')[0];
    };

    document.getElementById('dates').setAttribute('min', formatDate(today));
    document.getElementById('dates').setAttribute('max', formatDate(twoMonthsLater));
</script>
</body>
</html>

