package com.example.mvcboard;

import com.example.board.CommentDAO;
import com.example.board.CommentDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/mvcboard/CommentEdit.do")
public class CommentEditServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String commentId = request.getParameter("id");
        String postnum = request.getParameter("postnum");

        CommentDAO commentDAO = new CommentDAO();
        CommentDTO comment = commentDAO.getCommentById(commentId);

        if (comment != null) {
            request.setAttribute("comment", comment);
            request.setAttribute("postnum", postnum);
            request.getRequestDispatcher("/Board/CommentEdit.jsp").forward(request, response);
        } else {
            // Handle the case where the comment was not found
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Comment not found");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String content = request.getParameter("content");
        String postNum = request.getParameter("postnum");
        String returnUrl = request.getParameter("returnUrl");

        CommentDAO commentDAO = new CommentDAO();
        int result = commentDAO.updateComment(id, content);

        boolean success = result > 0; // 0보다 큰 경우 성공으로 간주

        // 수정 결과에 따라 리다이렉트
        if (success) {
            response.sendRedirect(returnUrl + "&editSuccess=true");
        } else {
            response.sendRedirect(returnUrl + "&editSuccess=false");
        }
    }
}
