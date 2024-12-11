<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Find your mate!</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #121212;
            color: #e0e0e0;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 60%;
            margin: 2rem auto;
            padding: 2rem;
            background: #1e1e1e;
            border-radius: 10px;
        }

        h2 {
            text-align: center;
            color: white;
            margin-bottom: 30px;
        }

        /* 테이블 스타일 */
        .info-table, .details-table {
            width: 100%;
            border-collapse: collapse;
            background: #2c2c2c;
            border-radius: 10px;
            overflow: hidden;
            margin-bottom: 1rem;
        }

        .info-table th, .details-table th,
        .info-table td, .details-table td {
            padding: 15px;
            text-align: left;
            border: 3px solid #333;
        }

        .info-table th, .details-table th {
            background-color: #007bff;
            color: #fff;
        }

        .info-table td, .details-table td {
            color: #e0e0e0;
        }

        .info-table td a:hover, .details-table td a:hover {
            text-decoration: underline;
        }

        .thumbnail {
            max-width: 400px;
            border-radius: 5px;
        }

        .button-group {
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 20px 0; /* 위쪽과 아래쪽 여백 추가 */
        }

        .edit-button, .delete-button, .list-button, .submit-button {
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            color: #000;
            margin: 5px;
            background-color: #fff;
            border: none;
            display: inline-block;
        }

        .edit-button:hover, .delete-button:hover, .list-button:hover, .submit-button:hover {
            background-color: #f0f0f0;
            color: #000;
        }


        /* 댓글 섹션 스타일 */
        .comment-section {
            width: 60%;
            margin: 2rem auto;
            padding: 2rem;
            background: #1e1e1e;
            border-radius: 10px;
        }

        .comment-section h3 {
            color: #fff;
            margin-bottom: 1rem;
        }

        .comment-section textarea {
            flex: 1;
            padding: 10px;
            border-radius: 20px;
            border: 1px solid #333;
            background-color:#2c2c2c;
            color: #e0e0e0;
            resize: none;
            box-sizing: border-box;
            font-size: 1rem;
        }

        .comment-list {
            list-style: none;
            padding: 0;
        }

        .comment-list li {
            padding: 10px;
            border-bottom: 1px solid #333;
            position: relative; /* 댓글 수정/삭제 버튼 위치 조정을 위해 사용 */
        }

        .comment-list p {
            margin: 0;
        }

        .comment-list strong {
            color: #007bff;
        }

        .comment {
            display: flex;
            justify-content: center;
            gap: 55px;
        }

        .reply {
            display: flex;
            justify-content: center;
            gap: 55px;
        }

        .comment-section h3 {
            margin-bottom: 10px;
            color: #e0e0e0;
        }

        .comment-list {
            list-style: none;
            padding: 0;
        }

        .comment-list li {
            margin-bottom: 15px;
            padding: 10px;
            border-bottom: 1px solid #333;
            position: relative;
            display: flex;
            justify-content: space-between;
        }

        .comment-list p {
            margin: 5px 0;
        }

        .comment-list strong {
            color: #007bff;
        }

        .comment-list small {
            color: #999;
        }

        .comment-actions {
            margin-top: 10px;
            display: flex;
            gap: 10px;
        }

        .comment-actions button, .comment-actions a {
            margin-right: 10px;
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            background-color: #333;
            color: #fff;
            cursor: pointer;
            text-decoration: none;
            font-size: 0.9em;
            display: inline-block;
        }

        .comment-actions button:hover, .comment-actions a:hover {
            background-color: #555;
        }


        .comment_edit_button {
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            color: black;
            margin: 5px;
            border: none;
            display: inline-block;
            background-color: white;
            text-decoration: none;
        }

        .comment_edit_button:hover {
            background-color:  #f0f0f0;
        }

        .comment_delete_button {
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            color: black;
            margin: 5px;
            border: none;
            display: inline-block;
            background-color: #e04d4d;
            text-decoration: none;
        }

        .comment_delete_button:hover {
            background-color: #c03939;
        }

        .reply_button {
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            color: black;
            margin: 5px;
            border: none;
            display: inline-block;
            background-color: white;
        }

        .reply_button:hover {
            background-color: #f0f0f0;
        }

        .reply-form {
            margin-top: 10px;
            display: none; /* Initially hidden */
        }

        .reply-form textarea {
            width: calc(100% - 110px);
            padding: 10px;
            border: 1px solid #333;
            border-radius: 4px;
            background-color: #2c2c2c;
            color: #e0e0e0;
            resize: none;
        }

        .comment-reply-list {
            list-style: none;
            padding-left: 20px;
        }
        .comment-reply-list li {
            margin-bottom: 10px;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.6);
        }

        /* 모달 내용 스타일 */
        .modal-content {
            background-color: #1e1e1e;
            color: #e0e0e0;
            margin: 15% auto;
            padding: 20px;
            border-radius: 10px;
            width: 80%;
            max-width: 600px;
            position: relative;
        }


        .modal-title {
            font-size: 20px;
            margin-bottom: 20px;
            color: #e0e0e0;
        }

        .close {
            color: #e0e0e0;
            float: right;
            font-size: 24px;
            font-weight: bold;
            cursor: pointer;
        }

        .close:hover,
        .close:focus {
            color: #ffffff;
            text-decoration: none;
            cursor: pointer;
        }

        .submit-button {
            background-color: #ffffff;
            color: #000000;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s, color 0.3s;
            float: right;
            margin-top: 20px;
            margin-right: 20px;
        }

        .submit-button:hover {
            background-color: #f0f0f0;
            color: #333333;
        }

        textarea {
            width: 70%
            border: 1.5px solid #333;
            background-color: #2e2e2e;
            color: #e0e0e0;
            border-radius: 5px;
            padding: 10px;
            font-size: 15px;
            box-sizing: border-box;
            resize: vertical;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Find your mate</h2>

    <!-- 게시글 정보 테이블 -->
    <table class="info-table">
        <colgroup>
            <col width="15%" />
            <col width="35%" />
            <col width="15%" />
            <col width="*" />
        </colgroup>
        <tr>
            <td style="text-align: center"><b>번호</b></td>
            <td>${dto.num}</td>
            <td style="text-align: center"><b>작성자</b></td>
            <td>${dto.username}</td>
        </tr>
        <tr>
            <td style="text-align: center"><b>작성일</b></td>
            <td>${dto.postdate}</td>
            <td style="text-align: center"><b>조회수</b></td>
            <td>${dto.visitcount}</td>
        </tr>
    </table>

    <!-- 게시글 상세 내용 테이블 -->
    <table class="details-table">
        <colgroup>
            <col width="20%" />
            <col width="80%" />
        </colgroup>
        <tr>
            <td><b>제목</b></td>
            <td>${dto.title}</td>
        </tr>
        <tr>
            <td><b>모집일</b></td>
            <td>${dto.dates}</td>
        </tr>
        <tr>
            <td><b>종목</b></td>
            <td>${dto.sport}</td>
        </tr>
        <tr>
            <td><b>모집 인원</b></td>
            <td>${dto.people}</td>
        </tr>
        <tr>
            <td><b>내용</b></td>
            <td class="content">${dto.detail}</td>
        </tr>
        <tr>
            <td><b>사진</b></td>
            <td class="thumbnail-cell">
                <c:if test="${not empty dto.ofile and isImage == true}">
                    <img src="${pageContext.request.contextPath}/resources/img/${dto.sfile}" class="thumbnail" />
                </c:if>
            </td>
        </tr>
    </table>

    <!-- 하단 메뉴(버튼) -->
    <tr>
        <td colspan="2" class="button-group">
            <c:choose>
                <c:when test="${sessionScope.userid != null}">
                    <c:if test="${sessionScope.role == 'admin'}">
                        <!-- 관리자일 경우: 삭제하기 버튼만 표시 -->
                        <button type="button" class="delete-button" onclick="location.href='${pageContext.request.contextPath}/Board/ProjectDeleteProcess.jsp?num=${param.num}';">
                            삭제하기
                        </button>
                    </c:if>
                    <c:if test="${sessionScope.userid == dto.userid}">
                        <!-- 게시글 작성자일 경우: 수정하기와 삭제하기 버튼 표시 -->
                        <button type="button" class="edit-button" onclick="location.href='${pageContext.request.contextPath}/mvcboard/ProjectEdit.do?num=${param.num}';">
                            수정하기
                        </button>
                        <button type="button" class="delete-button" onclick="location.href='${pageContext.request.contextPath}/Board/ProjectDeleteProcess.jsp?num=${param.num}';">
                            삭제하기
                        </button>
                    </c:if>
                </c:when>
            </c:choose>
            <button type="button" class="list-button" onclick="location.href='${pageContext.request.contextPath}/mvcboard/MainHome.do';">
                목록 바로가기
            </button>
        </td>
    </tr>
    </table>
</div>

<!-- 댓글 입력 폼 -->
<div class="comment-section">
    <h3>댓글 작성</h3>
    <c:choose>
        <c:when test="${sessionScope.userid != null}">
            <form action="${pageContext.request.contextPath}/mvcboard/CommentAdd.do" method="post">
                <input type="hidden" name="postnum" value="${dto.num}" />
                <input type="hidden" name="parent_id" value="" /> <!-- 기본값 빈 문자열 -->
                <div class="comment">
                    <textarea id="commentContent" name="content" rows="2" cols="50" required></textarea>
                    <button type="submit" class="submit-button">댓글 작성</button>
                </div>
            </form>
        </c:when>
        <c:otherwise>
            <p>댓글을 작성하려면 <a href="${pageContext.request.contextPath}/Home/Login.jsp">로그인</a>하세요.</p>
        </c:otherwise>
    </c:choose>
</div>

<div class="comment-section">
    <h3>댓글 목록</h3>
    <c:if test="${not empty comments}">
        <ul class="comment-list">
            <c:forEach items="${comments}" var="comment">
                <li>
                    <p><strong>${comment.username}</strong>: ${comment.content}</p>
                    <p><small>${comment.postdate}</small></p>

                    <!-- 댓글 수정 및 삭제 버튼 -->
                    <div class="reply_button_3">
                        <c:if test="${sessionScope.username == comment.username}">
                            <!-- 수정 버튼 클릭 시 팝업 창 열기 -->
                            <a href="javascript:void(0);" class="comment_edit_button" onclick="openEditModal('${comment.id}', '${comment.content}', '${dto.num}')">수정</a>
                            <a href="${pageContext.request.contextPath}/mvcboard/CommentDelete.do?id=${comment.id}&postnum=${dto.num}" class="comment_delete_button" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
                        </c:if>

                    </div>
                </li>
            </c:forEach>
        </ul>
    </c:if>
    <c:if test="${empty comments}">
        <p>댓글이 없습니다.</p>
    </c:if>
</div>

<!-- 댓글 수정 모달 -->
<div id="editModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <div class="modal-title">댓글 수정</div>
        <form id="editForm" action="${pageContext.request.contextPath}/mvcboard/CommentEdit.do" method="post">
            <input type="hidden" id="editCommentId" name="id" value="${comment.id}" />
            <input type="hidden" id="editPostnum" name="postnum" value="${dto.num}" />
            <input type="hidden" name="returnUrl" value="${pageContext.request.contextPath}/mvcboard/ProjectView.do?num=${dto.num}" />
            <textarea id="editContent" name="content" rows="4" cols="50" required>${comment.content}</textarea>
            <button type="submit" class="submit-button">수정하기</button>
        </form>
    </div>
</div>


<script>
    function openEditModal(commentId, commentContent, postnum) {
        document.getElementById('editCommentId').value = commentId;
        document.getElementById('editPostnum').value = postnum;
        document.getElementById('editContent').value = commentContent;
        document.getElementById('editModal').style.display = 'block';
    }

    // 모달을 닫기 위한 함수
    function closeEditModal() {
        document.getElementById('editModal').style.display = 'none';
    }

    // 모달 외부 클릭 시 모달 닫기
    window.onclick = function(event) {
        var modal = document.getElementById('editModal');
        if (event.target === modal) {
            modal.style.display = 'none';
        }
    }

    // 페이지 로드 시 URL 파라미터를 검사하여 알림을 표시하고 페이지를 새로 고침
    window.onload = function() {
        var urlParams = new URLSearchParams(window.location.search);
        var editSuccess = urlParams.get('editSuccess');
        var num = urlParams.get('num');

        if (editSuccess === 'true') {
            alert('댓글 수정 성공!');
            setTimeout(function() {
                location.href = 'ProjectView.do?num=' + num; // 페이지 새로고침
            }, 1000);
        } else if (editSuccess === 'false') {
            alert('댓글 수정 실패!');
        }
    }

    // 모달 닫기 버튼 클릭 이벤트 추가
    document.addEventListener('DOMContentLoaded', function() {
        var closeBtn = document.querySelector('.close');
        closeBtn.addEventListener('click', function() {
            closeEditModal();
        });
    });

    function toggleReplyForm(commentId) {
        var form = document.getElementById('reply-form-' + commentId);
        form.style.display = (form.style.display === 'none' || form.style.display === '') ? 'block' : 'none';
    }
</script>
</body>
</html>
