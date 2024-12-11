<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>댓글 수정</title>
    <style>
        /* 스타일 정의는 필요에 따라 추가하거나 조정하세요. */
        .modal {
            display: none; /* 기본적으로 숨김 */
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.4);
        }

        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 80%;
            max-width: 600px;
            border-radius: 10px;
        }

        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }

        .submit-button {
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            color: #000;
            background-color: #fff;
            border: none;
        }

        .submit-button:hover {
            background-color: #f0f0f0;
        }
    </style>
</head>
<body>
<h2>댓글 수정</h2>
<div id="editModal" class="modal">
    <div class="modal-content">
        <span class="close">&times;</span>
        <form id="editForm" action="${pageContext.request.contextPath}/mvcboard/CommentEdit.do" method="post">
            <input type="hidden" id="editCommentId" name="id" value="${param.id}" />
            <input type="hidden" id="editPostnum" name="postnum" value="${param.postnum}" />
            <textarea id="editContent" name="content" rows="4" cols="50" required>${param.content}</textarea>
            <button type="submit" class="submit-button">수정하기</button>
        </form>
    </div>
</div>

<script>
    // 모달 열기
    function openEditModal(commentId, commentContent, postnum) {
        document.getElementById('editCommentId').value = commentId;
        document.getElementById('editPostnum').value = postnum;
        document.getElementById('editContent').value = commentContent;
        document.getElementById('editModal').style.display = 'block';
    }

    // 모달 닫기
    document.querySelector('.close').onclick = function() {
        document.getElementById('editModal').style.display = 'none';
    }

    // 모달 외부 클릭 시 닫기
    window.onclick = function(event) {
        if (event.target == document.getElementById('editModal')) {
            document.getElementById('editModal').style.display = 'none';
        }
    }

    // 페이지 로드 시 URL 파라미터 검사
    window.onload = function() {
        var urlParams = new URLSearchParams(window.location.search);
        var editSuccess = urlParams.get('editSuccess');

        if (editSuccess === 'true') {
            alert('댓글 수정 성공!');
            setTimeout(function() {
                window.location.href = '${pageContext.request.contextPath}/mvcboard/ProjectView.do?num=' + urlParams.get('postnum');
            }, 1000);
        } else if (editSuccess === 'false') {
            alert('댓글 수정 실패!');
        }
    }
</script>
</body>
</html>
