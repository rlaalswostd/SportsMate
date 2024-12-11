package com.example.mvcboard;

import com.example.board.CommentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/mvcboard/CommentDelete.do")
public class CommentDeleteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String commentId = request.getParameter("id");
        String postNum = request.getParameter("postnum");

        CommentDAO commentDAO = new CommentDAO();
        commentDAO.deleteComment(commentId);

        // 게시글 페이지로 리다이렉트
        response.sendRedirect(request.getContextPath() + "/mvcboard/ProjectView.do?num=" + postNum);
    }
}
