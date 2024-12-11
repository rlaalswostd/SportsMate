package com.example.mvcboard;

import com.example.board.ReportDAO;
import com.example.board.ReportDTO;
import com.example.board.TestBoardDTO;
import com.example.util.JSFunction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/mvcboard/ReportDelete.do")
public class ReportDeleteController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String loggedInUserId = (String) session.getAttribute("userid");
        String userRole = (String) session.getAttribute("role"); // 관리자 역할 확인

        if (loggedInUserId == null) {
            JSFunction.alertLocation(resp, "로그인 후 접근 가능합니다", "../mvcboard/MainHome.do");
            return;
        }

        String num = req.getParameter("num");
//        TestBoardDTO dto = new TestBoardDTO();
        ReportDAO dao = new ReportDAO();
        ReportDTO dto = dao.ProjectSelectView(num);

        // 사용자가 게시물의 작성자이거나 관리자일 경우에만 삭제 허용
        if (!loggedInUserId.equals(dto.getUserid()) && !"admin".equals(userRole)) {
            JSFunction.alertBack(resp, "권한이 없습니다.");
            dao.close();
            return;
        }

        int result = dao.deletePost(dto); // 수정된 메서드 호출
        dao.close();

        if (result == 1) {
            JSFunction.alertLocation(resp, "삭제되었습니다.", "../mvcboard/ReportList.do");
        } else {
            JSFunction.alertBack(resp, "삭제 실패");
        }
    }

}