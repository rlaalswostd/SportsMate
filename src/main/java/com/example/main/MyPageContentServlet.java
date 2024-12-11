package com.example.main;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

@WebServlet("/MyPageContent.do")
@MultipartConfig(
        maxFileSize = 1024 * 1024 * 10,    // 최대 파일 크기 10MB
        maxRequestSize = 1024 * 1024 * 20  // 최대 요청 크기 20MB
)
public class MyPageContentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Connection conn = null;
        try {
            // 데이터베이스 연결 설정
            Class.forName("oracle.jdbc.driver.OracleDriver");
            String url = "jdbc:oracle:thin:@localhost:1521:xe";
            String id = "scott";
            String pass = "tiger";
            conn = DriverManager.getConnection(url, id, pass);

            System.out.println("DB 연결 오류없음");

            // 업로드할 파일의 저장 경로를 절대 경로로 지정
            String saveDirectory = getServletContext().getRealPath("/uploads");
           // System.out.println("Servlet Context : " + saveDirectory);

            // 파일 업로드
            String originalFileName = FileUtil.uploadFile(req, saveDirectory);

            if (originalFileName == null) {
                req.setAttribute("errMessage", "파일이 선택되지 않았습니다.");
                req.getRequestDispatcher("/Home/Mypage.jsp").forward(req, resp);
                return;
            }

            System.out.println("파일 업로드 성공: " + originalFileName);

            // 세션에서 USERID 가져오기
            HttpSession session = req.getSession();
            if (session == null) {
                throw new Exception("세션이 존재하지 않습니다.");
            }
            String userId = (String) session.getAttribute("userId");
            System.out.println("Session userId: " + userId);

            if (userId == null) {
                throw new Exception("로그인된 사용자 정보가 없습니다.");
            }

            // 프로필 사진 파일명 설정
            String newProfilePic = userId + "propic.jpg";
            session.setAttribute("userpic", newProfilePic);

            // DB에 파일 정보 저장
            UserDAO userDAO = new UserDAO(conn);
            boolean isUpdated = userDAO.UpdateUserPic(userId, originalFileName);
            System.out.println("isUpdated: " + isUpdated);

            if (isUpdated) {
                // 성공적으로 업데이트 된 경우 파일 목록 페이지로 리다이렉션
                //resp.sendRedirect("/mvcboard/MainHome.do");
                resp.sendRedirect("/mvcboard/MainHome.do");
            } else {
                throw new Exception("프로필 사진 업데이트 실패");
            }

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errMessage", "파일 업로드 오류: " + e.getMessage());
            req.getRequestDispatcher("Home/MainHome.jsp").forward(req, resp);
//            req.getRequestDispatcher("/mvcboard/MainHome.do").forward(req, resp);
        } finally {
            // Connection 자원 해제
            if (conn != null) {
                try {
                    conn.close(); // 연결을 닫음
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
