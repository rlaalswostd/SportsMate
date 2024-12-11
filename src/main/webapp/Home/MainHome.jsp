<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8"%>
<%@ page import="com.example.main.UserDTO" %>
<%@ page import="com.example.main.UserDAO" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>


<%
    UserDTO user = (UserDTO) request.getAttribute("user");
    String userid = (String) session.getAttribute("userid");
    String username = (String) session.getAttribute("username");
    String profilepic = (String) session.getAttribute("userPic");
    //System.out.println("Profile Picture Path: " + session.getAttribute("userPic"));
%>
<%-- USERID --%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>SportsMate</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/static/css/Sportsmate3.css">

    <style>
        @font-face {
            font-family: 'Cafe24Decobox';
            src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/2405-3@1.1/Cafe24Decobox.woff2') format('woff2');
            font-weight: normal;
            font-style: normal;
        }

        @font-face {
            font-family: 'LeeSeoyun';
            src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_2202-2@1.0/LeeSeoyun.woff') format('woff');
            font-weight: normal;
            font-style: normal;
        }

        @font-face {
            font-family: 'LINESeedKR-Bd';
            src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_11-01@1.0/LINESeedKR-Bd.woff2') format('woff2');
            font-weight: 700;
            font-style: normal;
        }

        @font-face {
            font-family: 'PTBandocheB';
            src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/2408@1.0/PTBandocheB.woff2') format('woff2');
            font-weight: 700;
            font-style: normal;
        }
    </style>

</head>

<body>

<div id="main1">
    <header>
        <nav>
            <ul>
                <li><a href="#main1" style="scroll-behavior: smooth">홈</a></li>
                <% if (session.getAttribute("loggedIn") != null && (Boolean) session.getAttribute("loggedIn")) { %>
                <li><a href="../Home/Mypage.jsp">마이페이지</a></li>
                <% } else { %>
                <li><a href="../Home/Login.jsp" style="scroll-behavior: smooth">로그인</a></li>
                <% } %>
                <li><a href="#main2" style="scroll-behavior: smooth">게시판</a></li>
                <li><a href="/mvcboard/ReportList.do" style="scroll-behavior: smooth">신고 및 질문</a></li>
            </ul>
        </nav>

        <div class="hero">
            <h1>당신의 운동 파트너를 찾아보세요!</h1>
            <p>건강한 라이프 스타일을 위한 첫 걸음</p>
            <a href="#main2" class="start_btn">지금 시작하기</a>
        </div>

        <script>
            document.querySelector(".start_btn").addEventListener("click", (e) => {
                document.querySelector("#main2").scrollIntoView({behavior:"smooth"});
            });
        </script>
    </header>

    <section id="features" class="features">
        <div class="feature">
            <img src="../resources/img/gabin-vallet-J154nEkpzlQ-unsplash.jpg">
            <h2>기능 1</h2>
            <p>나의 운동 목표에 맞는 파트너를 <br> 찾아보세요.</p>
        </div>
        <div class="feature">
            <img src="../resources/img/berend-van-rossum-Lq5JlXJrx2k-unsplash.jpg">
            <h2>기능 2</h2>
            <p>랭커들과의 경쟁을 통해 동기부여를 얻고, <br> 더 나은 성과를 기록해보세요.</p>
        </div>
        <div class="feature">
            <img src="../resources/img/andres-urena-qSw5XKtUyus-unsplash.jpg">
            <h2>기능 3</h2>
            <p>당신의 운동 기록을 확인하고, <br> 자신의 목표를 달성해보세요.</p>
        </div>
    </section>

    <div class="footer">
        <p>&copy; Sportsmate</p>
    </div>
</div>


<div id="main2">
    <div class="main-content">
        <aside class="sidebar">
            <div class="login-container">
                <%
                    if (userid == null){
                %>
                <form action="../Home/Login-data.jsp" method="post" class="login-form">
                    <div class="login_mini">
                        <section class = "login_form_mini">
                            <%--로그인폼--%>
                            <h2 class="login_title_mini" style="font-family: Cafe24Decobox;">Sportsmate</h2>
                            <div class="user_info_mini">
                                <input type="text" name="USERID" id="id" autocomplete="off" required placeholder="ID">
                                <label for="id"></label>
                            </div>
                            <div class="user_info_mini">
                                <input type="password" name="USERPWD" id="pw" autocomplete="off" required  placeholder="PWD">
                                <label for="pw"></label>
                            </div>

                            <div class="form-button_mini">
                                <input type="submit" id="login_button_mini" value="로그인">
                                <a href="../Home/MemPlus.jsp" target="_blank"><input type="button" id="memplus_button_mini" value="회원가입"></a>
                            </div>
                        </section>
                    </div>
                </form>
            </div>
            <%-- 로그인 했을때 --%>
            <%
            } else {
            %>
            <div class="login_box_mini">
                <h2 class="login_box_title_mini" style="font-family: Cafe24Decobox">Sportsmate</h2>
                <div class="profile_mini_container">
                    <div class="profile_mini">
                        <%
                            String userId = (String)session.getAttribute("userId");
                            String userpic = (String)session.getAttribute("userPic");
                            if (userpic != null) {
                        %>
                        <img src="<%= request.getContextPath() + "../uploads/" + userid + "propic.jpg" %>" alt="프로필 사진">
                        <%
                        } else {
                        %>
                        <img src="<%= request.getContextPath() + "../resources/img/profile.png" %>" alt="기본 프로필 사진">
                        <%
                            }
                        %>
                    </div>
                </div>

                <div class="hello_mini">
                    어서오세요 <%= username %> 님
                </div>

                <div class="box-button_mini">
                    <a href="../Home/Mypage.jsp"><input type="button" class="mypage_button_mini" value="마이페이지"></a>
                    <a href="../Home/Logout.jsp"><input type="button" class="logout_button_mini" value="로그아웃"></a>
                </div>
            </div>
            <%
                }
            %>

            <div class="menu">
                <button onclick="location.href='#main1'" class="menu_btn">홈</button>
                <button onclick="location.href='#main2'" class="menu_btn">게시판</button>
                <button onclick="location.href='/mvcboard/ReportList.do'" class="menu_btn">신고 및 질문</button>
            </div>


            <%--    점수 표시     --%>
            <div class="ranking">
                <h2 style="color: white; font-size: 18px; text-align: center; margin-bottom: 20px; margin-top: 20px">Top 10 Users</h2>
                <table class="ranking_table">
                    <thead>
                    <tr>
                        <th>Rank</th>
                        <th>Username</th>
                        <th>Points</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="user" items="${rankingList}">
                        <tr>
                            <td>${user.rank}</td>
                            <td>${user.username}</td>
                            <td>${user.userpt}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </aside>


        <div class="board">
            <h1 style="color: white; font-family: Cafe24Decobox">Find your Mate!</h1>
            <div class="board-controls">
                <div class="search-container">
                    <form class="search-form" method="get">
                        <select name="searchField" id="search-category">
                            <option value="title">제목</option>
                            <option value="detail">내용</option>
                        </select>
                        <input type="text" name="searchWord" value="${param.searchWord}" placeholder="검색어를 입력하세요">
                        <%--                        <input type="submit" value="검색">--%>
                        <button type="submit">검색</button>
                    </form>
                </div>
                <div class="write-button-container">
                    <button class="write-button" onclick="window.location.href='../Board/ProjectWrite.jsp'">글쓰기</button>
                </div>
            </div>


            <table>
                <thead>
                <tr>
                    <th style="width: 40px">번호</th>
                    <th>사진</th>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>조회수</th>
                    <th>작성일</th>
                </tr>
                </thead>

                <%-- 게시물이 유무에 따른 상태 --%>
                <c:choose>
                    <c:when test="${empty boardList}">
                        <%--게시글이 없을 때 --%>
                        <tr>
                            <td colspan="6" align="center">
                                등록된 게시물이 없습니다.
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <%--게시글이 있을 때--%>
                        <c:forEach items="${boardList}" var="row" varStatus="loop">
                            <tr align="center">
                                    <%-- 번호  --%>
                                <td>${row.num}</td>
                                <td>
                                        <%-- 썸네일  --%>
                                    <c:choose>
                                        <c:when test="${not empty row.ofile}">
                                            <img src="/resources/img/${row.sfile}" alt="썸네일" style="object-fit: cover; border-radius: 10px;" width="200px" height="150px">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="/resources/img/No-image.png" alt="기본 썸네일" style="object-fit: cover" width="125px" height="120px">
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                    <%-- 제목  --%>
                                <td align="left">
                                    <span><a href="../mvcboard/ProjectView.do?num=${row.num}" target="_blank">${row.title}</a></span>
                                </td>
                                    <%-- 작성자  --%>
                                        <td><a href="#" onclick="openPopup('../mvcboard/UserProfileServlet?userId=${row.userid}'); return false;">${row.username}</a></td>
<%--                                        <td>${row.username}</td>--%>
<%--                                        <td>${row.username}</td>--%>
                                    <%-- 조회수  --%>
                                <td>${row.visitcount}</td>
                                    <%-- 작성일  --%>
                                <td>${row.postdate}</td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </table>
            <div class="pagination">
                ${map.pagingImg}
            </div>

        </div>

        <script>
            // 페이지 로드 시 스크롤 위치 복원
            window.addEventListener('load', () => {
                const scrollPos = localStorage.getItem('scrollPosition');
                if (scrollPos !== null) {
                    window.scrollTo(0, parseInt(scrollPos, 10));
                    localStorage.removeItem('scrollPosition'); // 위치를 복원한 후 저장된 위치 제거
                }
            });

            // 페이지 언로드 시 스크롤 위치 저장
            window.addEventListener('beforeunload', () => {
                localStorage.setItem('scrollPosition', window.scrollY);
            });

            function openPopup(url) {
                window.open(url, 'popupWindow', 'width=600,height=400,scrollbars=yes,resizable=yes,toolbar=no,location=no,status=no');
            }

        </script>
    </div>
</div>
</body>
</html>