package com.example.board;

import com.example.common.DBConnPool;
import com.example.main.UserDAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CommentDAO extends DBConnPool {

    public CommentDAO() {
        super();
    }
    public int addComment(String postnum, String username, String content, String parentId) {
        int result = 0;
        String query = "INSERT INTO scott.\"COMMENT\" (id, postnum, username, content, postdate, parent_id)"
                + " VALUES (scott.SEQ_COMMENT_ID.nextval, ?, ?, ?, SYSDATE, ?)";

        try {
            psmt = conn.prepareStatement(query);
            psmt.setInt(1, Integer.parseInt(postnum));
            psmt.setString(2, username);
            psmt.setString(3, content);
            psmt.setString(4, parentId); // parent_id를 추가합니다.
            result = psmt.executeUpdate();

            if (result > 0) {
                // UserDAO 객체 생성
                UserDAO userDAO = new UserDAO(conn);
                // username을 통해 userId 조회
                String userId = userDAO.getUserIdByUsername(username);

                if (userId != null) {
                    // 로그: userId 확인
                    System.out.println("UserID found: " + userId);

                    // 점수 업데이트
                    userDAO.updateUserPoints(userId, 3); // 예를 들어 3점을 추가
                } else {
                    // 로그: userId가 null일 경우
                    System.out.println("No userId found for username: " + username);
                }
            } else {
                // 로그: 댓글 삽입 실패
                System.out.println("Failed to insert comment.");
            }


        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("addComment 오류 발생");
        }
        return result;
    }



    // 게시글의 댓글 목록 조회
    public List<CommentDTO> getComments(String postNum) {
        List<CommentDTO> comments = new ArrayList<>();
        String query = "SELECT * FROM scott.\"COMMENT\" WHERE postnum = ? AND parent_id IS NULL ORDER BY postdate DESC";

        try {
            psmt = conn.prepareStatement(query);
            psmt.setInt(1, Integer.parseInt(postNum));
            rs = psmt.executeQuery();

            while (rs.next()) {
                CommentDTO comment = new CommentDTO();
                comment.setId(rs.getString("id"));
                comment.setPostnum(rs.getInt("postnum"));
                comment.setUsername(rs.getString("username"));
                comment.setContent(rs.getString("content"));
                comment.setPostDate(rs.getDate("postdate"));
                comment.setParentId(rs.getString("parent_id"));

                // 대댓글 조회
                //comment.setReplies(getReplies(comment.getId()));

                comments.add(comment);
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("getComments 오류 발생");
        }
        return comments;
    }

    public List<CommentDTO> getReplies(String parentId) {
        List<CommentDTO> replies = new ArrayList<>();
        String query = "SELECT * FROM scott.\"COMMENT\" WHERE parent_id = ? ORDER BY postdate ASC";

        try {
            psmt = conn.prepareStatement(query);
            psmt.setString(1, parentId);
            rs = psmt.executeQuery();

            while (rs.next()) {
                CommentDTO reply = new CommentDTO();
                reply.setId(rs.getString("id"));
                reply.setPostnum(rs.getInt("postnum"));
                reply.setUsername(rs.getString("username"));
                reply.setContent(rs.getString("content"));
                reply.setPostDate(rs.getDate("postdate"));
                reply.setParentId(rs.getString("parent_id"));

                replies.add(reply);
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("getReplies 오류 발생");
        }
        return replies;
    }
    // 댓글 대댓글 한꺼번에 가져오기
    public List<CommentDTO> getCommentsWithReplies(String postNum) {
        List<CommentDTO> comments = new ArrayList<>();
        String query = "SELECT * FROM scott.\"COMMENT\" WHERE postnum = ? ORDER BY postdate DESC";

        try {
            psmt = conn.prepareStatement(query);
            psmt.setInt(1, Integer.parseInt(postNum));
            rs = psmt.executeQuery();

            Map<String, CommentDTO> commentMap = new HashMap<>();

            while (rs.next()) {
                CommentDTO comment = new CommentDTO();
                comment.setId(rs.getString("id"));
                comment.setPostnum(rs.getInt("postnum"));
                comment.setUsername(rs.getString("username"));
                comment.setContent(rs.getString("content"));
                comment.setPostDate(rs.getDate("postdate"));
                comment.setParentId(rs.getString("parent_id"));

                if (comment.getParentId() == null) {
                    // 댓글
                    comments.add(comment);
                    commentMap.put(comment.getId(), comment);
                } else {
                    // 대댓글
                    CommentDTO parentComment = commentMap.get(comment.getParentId());
                    if (parentComment != null) {
                        List<CommentDTO> replies = parentComment.getReplies();
                        if (replies == null) {
                            replies = new ArrayList<>();
                            parentComment.setReplies(replies);
                        }
                        replies.add(comment);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("getCommentsWithReplies 오류 발생");
        }
        return comments;
    }

    // 댓글 수정

    public int updateComment(String commentId, String content) {
        int result = 0;
        String query = "UPDATE scott.\"COMMENT\" SET content = ? WHERE id = ?";

        try (PreparedStatement psmt = conn.prepareStatement(query)) {
            psmt.setString(1, content);
            psmt.setString(2, commentId);
            result = psmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println("updateComment 오류 발생: " + e.getMessage());
        }
        return result;
    }



    // 댓글 삭제
    public int deleteComment(String commentId) {
        int result = 0;
        String query = "DELETE FROM scott.\"COMMENT\" WHERE id = ?";

        try {
            psmt = conn.prepareStatement(query);
            psmt.setString(1, commentId);
            result = psmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("deleteComment 오류 발생");
        }
        return result;
    }

    // 댓글 ID로 댓글 조회
    public CommentDTO getCommentById(String commentId) {
        CommentDTO comment = null;
        String query = "SELECT * FROM scott.\"COMMENT\" WHERE id = ?";

        try {
            psmt = conn.prepareStatement(query);
            psmt.setString(1, commentId);
            rs = psmt.executeQuery();

            if (rs.next()) {
                comment = new CommentDTO();
                comment.setId(rs.getString("id"));
                comment.setPostnum(rs.getInt("postnum"));
                comment.setUsername(rs.getString("username"));
                comment.setContent(rs.getString("content"));
                comment.setPostDate(rs.getDate("postdate"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("getCommentById 오류 발생");
        }
        return comment;
    }
}