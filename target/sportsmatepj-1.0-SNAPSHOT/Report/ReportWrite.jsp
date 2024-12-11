<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8"
%>

<html lang="en">
<%
    String userid = (String) session.getAttribute("userid");
    System.out.println("userid: " + userid);

%>

<head>
    <meta charset="UTF-8">
    <title>신고 게시판 글쓰기</title>
    <script>
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
            } else if (!form.dates.value){
                alert("날짜를 입력하세요");
                form.dates.focus();
                return false;
            }
            else if (!form.report.value){
                alert("신고 사유를 선택하세요");
                form.report.focus();
                return false;
            }
            else if (!form.detail.value) {
                alert("세부내용을 입력하세요");
                form.detail.focus();
                return false;
            }
        }
    </script>

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
            margin-top: 40px;
        }

        form {
            width: 50%;
            margin: 50px auto;
            background-color: #2a2a2a;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        table {
            width: 100%;
            border-spacing: 0;
        }

        td {
            padding: 12px;
        }

        input[type="text"],
        textarea {
            width: calc(100% - 24px);
            padding: 12px;
            border: 1.5px solid #444;
            border-radius: 8px;
            background-color: #333;
            color: #e0e0e0;
            font-size: 16px;
            margin-bottom: 20px;
        }

        textarea {
            height: 150px;
            resize: none;
        }

        select {
            width: calc(100% - 24px);
            padding: 12px;
            border: 1.5px solid #444;
            border-radius: 8px;
            background-color: #333;
            color: #e0e0e0;
            font-size: 16px;
            margin-bottom: 20px;
        }

        input[type="file"] {
            border: 1.5px solid #444;
            border-radius: 8px;
            background-color: #333;
            color: #e0e0e0;
            padding: 10px;
            width: 100%;
        }

        input[type="submit"] {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            border: none;
            border-radius: 8px;
            background-color: #9ab4d0; /* 밝은 시에라 블루 */
            color: white;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #8fa1c4; /* 조금 더 어두운 밝은 시에라 블루 */
        }

        .header {
            font-size: 18px;
            color: #ffffff;
        }
    </style>
</head>
<body>
<form name="writeFrm" method="post" action="../mvcboard/ReportWrite.do" onsubmit="return validateForm(this);"
        enctype="multipart/form-data">
    <h2>글쓰기</h2>
    <table>
        <tr>
            <td class="header">제목</td>
        </tr>
        <tr>
            <td><input type="text" placeholder="제목을 입력하세요" style="font-family: LINESeedKR-Bd" name="title"></td>
        </tr>

        <tr>
            <td class="header">신고 사유</td>
        </tr>
        <tr>
            <td>
                <select name="report" id="report" style="font-family: LINESeedKR-Bd">
                    <option value="폭행 및 폭언">폭행 및 폭언</option>
                    <option value="먹튀">먹튀</option>
                    <option value="지각">지각</option>
                    <option value="사기">사기</option>
                    <option value="기타">기타</option>
                </select>
            </td>
        </tr>

        <tr>
            <td class="header">세부내용</td>
        </tr>
        <tr>
            <td><textarea placeholder="세부 내용을 입력하세요" style="font-family: LINESeedKR-Bd" name="detail"></textarea></td>
        </tr>

        <tr>
            <td class="header">사진 첨부</td>
        </tr>
        <tr>
            <td><input type="file" name="ofile"></td>
        </tr>

        <tr>
            <td><input type="submit" value="등록" style="font-family: LINESeedKR-Bd"></td>
        </tr>
    </table>
</form>
</body>
</html>
