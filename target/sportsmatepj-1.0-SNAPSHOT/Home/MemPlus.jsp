<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8"
%>

<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>

    <link rel="stylesheet" href="../resources/static/css/MemPlus.css">
</head>
<body>
<div class="memplus">
    <div class="memberdata" style="text-align: center">
        <form action="MemData.jsp" method="post">

            <div class="memplus-container">
                <div class="memplus-form">
                    <h1 style="line-height: 60px;"> Sportsmate <br> 회 원 가 입</h1>
                    <form action="#" method="post">
                        <div class="form-group">
                            <label>아이디</label>
                            <input type="text" name="USERID" class="MemID" placeholder="사용하실 ID 입력" required>
                        </div>

                        <div class="form-group">
                            <label>비밀번호</label>
                            <input type="password" name="USERPWD" class="MemPWD"  placeholder="영문, 숫자, 특수문자 중 2종류 이상을 조합하여 최소 10자리 이상 최소 8자리 이상의 길이로 구성" required>
                        </div>

                        <div class="form-group">
                            <label>닉네임</label>
                            <input type="text" name="USERNAME" class="MemNAME" placeholder="한글 8자,영어 16자 내로 작성" required>
                        </div>

                        <button type="submit">회원가입</button>
                    </form>
                </div>

            </div>
        </form>

    </div>
</div>

</body>
</html>
