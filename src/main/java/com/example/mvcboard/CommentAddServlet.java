package com.example.mvcboard;

import com.example.board.CommentDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import java.io.IOException;

@WebServlet("/mvcboard/CommentAdd.do")
public class CommentAddServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String content = request.getParameter("content");
        String postnum = request.getParameter("postnum");
        String parentId = request.getParameter("parent_id");
//        String username = (String) request.getSession().getAttribute("userid");
        String username = (String) request.getSession().getAttribute("username");

        CommentDAO commentDAO = new CommentDAO();
        commentDAO.addComment(postnum, username, content, parentId);

//        int result = commentDAO.addComment(postnum, username, content, parentId);
//        System.out.println("댓글 추가 결과: " + result);
//        System.out.println("리다이렉션 URL: " + request.getContextPath() + "/mvcboard/ProjectView.do?num=" + postnum);

        // 게시글 페이지로 리다이렉트
        response.sendRedirect(request.getContextPath() + "/mvcboard/ProjectView.do?num=" + postnum);
//        response.sendRedirect(request.getContextPath() + "/mvcboard/CommentList.do?num=" + postnum);
    }
}
