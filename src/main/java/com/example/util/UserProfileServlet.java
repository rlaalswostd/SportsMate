package com.example.util;


import com.example.main.UserDAO;
import com.example.main.UserDTO;
import com.example.board.TestBoardDTO;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;
@WebServlet("/mvcboard/UserProfileServlet")
public class UserProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userId = req.getParameter("userId");  // 파라미터 이름을 "userId"로 수정
        UserDTO user = null;
        List<TestBoardDTO> userPosts = null;

        try (Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "scott", "tiger")) {
            UserDAO userDAO = new UserDAO(conn);
            user = userDAO.getUserById(userId);
            userPosts = userDAO.getUserPosts(userId);
           // System.out.println(userId);
        } catch (SQLException e) {
            e.printStackTrace();
        }


        if (user != null) {
            req.setAttribute("user", user);
            req.setAttribute("userPosts",userPosts);
            RequestDispatcher dispatcher = req.getRequestDispatcher("/Home/PopupProf.jsp");
            dispatcher.forward(req, resp);

        } else {
            resp.getWriter().write("User not found.");
        }
    }
}
