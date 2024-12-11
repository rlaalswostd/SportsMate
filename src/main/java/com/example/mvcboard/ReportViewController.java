package com.example.mvcboard;

import com.example.board.ReportDAO;
import com.example.board.ReportDTO;
import com.example.board.TestBoardDAO;
import com.example.board.TestBoardDTO;
import com.example.util.JSFunction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@WebServlet("/mvcboard/ReportView.do")
public class ReportViewController extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        // 세션에서 로그인한 사용자 ID를 가져옴
        HttpSession session = req.getSession();
        String loggedInUserId = (String) session.getAttribute("userid");
        // 추가된 코드
        String userRole = (String) session.getAttribute("role"); // 관리자 역할 확인
        // 추가된 코드
        // 사용자가 로그인되어 있는지 확인
        if (loggedInUserId == null) {
            JSFunction.alertLocation(resp, "로그인 후 접근 가능합니다", "../mvcboard/MainHome.do");
//            resp.sendRedirect("../mvcboard/MainHome.do");
            return;
        }


        //게시물 불러오기
        ReportDAO dao = new ReportDAO();
        String num = req.getParameter("num");

        dao.updateViewCount(num);

        ReportDTO dto = dao.ProjectSelectView(num);
        dao.close();

        // 로그인한 사용자가 게시물의 작성자와 동일한지 또는 관리자 권한이 있는지 확인(추가된 코드)
        if (!loggedInUserId.equals(dto.getUserid()) && !"admin".equals(userRole)) {
            resp.sendRedirect("../Board/AccessDenied.jsp");
            return;
        }

        // 로그인한 사용자가 게시물의 작성자와 동일한지 확인
//        if (!loggedInUserId.equals(dto.getUserid())) {
//            resp.sendRedirect("../Board/AccessDenied.jsp");
//            return;
//        }

        //첨부파일 확장자 확인하고 이미지 타입 확인
        String ext = null;
        String fileName = dto.getSfile();
        //이미지이름.png
        if(fileName != null){
            ext = fileName.substring(fileName.lastIndexOf(".") +1);
        }

        String[] mimeStr = {"png" , "jpg", "gif"};
        List<String> mimeList = Arrays.asList(mimeStr);
        boolean isImage = false;

        if(mimeList.contains(ext)){
            isImage = true;
        }

        req.setAttribute("dto", dto);
        req.setAttribute("isImage", isImage);
        req.getRequestDispatcher("/Report/ReportView.jsp").forward(req,resp);

    }
}