//package com.example.mvcboard;
//
//import com.example.board.CommentDAO;
//import com.example.board.CommentDTO;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//
//import java.io.IOException;
//import java.util.List;
//
//@WebServlet("/mvcboard/CommentList.do")
//public class CommentListServlet extends HttpServlet {
//    private static final long serialVersionUID = 1L;
//
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String postnum = request.getParameter("postnum");
//
//        CommentDAO commentDAO = new CommentDAO();
//        List<CommentDTO> comments = commentDAO.getComments(postnum);
//
//        request.setAttribute("comments", comments);
//        request.getRequestDispatcher("CommentList.jsp").forward(request, response);
//    }
//}
