package com.example.util;

import com.example.main.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();
        String userId = (String) session.getAttribute("userId");

        // 디버그용: 세션에서 가져온 userId 확인
        System.out.println("세션에서 가져온 userId: " + userId);

        if (userId == null || userId.isEmpty()) {
            resp.getWriter().write("사용자 ID를 확인할 수 없습니다.");
            return;
        }

        try (Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "scott", "tiger")) {
            UserDAO userDAO = new UserDAO(conn);
            boolean isDeleted = userDAO.deleteUserById(userId);

            if (isDeleted) {
                session.invalidate(); // 세션 무효화(로그아웃 처리)
                resp.sendRedirect(req.getContextPath() + "/Home/MemOut.jsp"); // 탈퇴 완료 페이지로 리다이렉트

            } else {
                resp.getWriter().write("회원 탈퇴에 실패했습니다.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            resp.getWriter().write("서버 오류로 인해 회원 탈퇴에 실패했습니다.");
        }
    }
}
