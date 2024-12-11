package com.example.mvcboard;

import com.example.board.ReportDAO;
import com.example.board.ReportDTO;
import com.example.board.TestBoardDAO;
import com.example.board.TestBoardDTO;
import com.example.fileupload.FileUtil;
import com.example.util.JSFunction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;


@WebServlet("/mvcboard/ReportWrite.do")
@MultipartConfig(
        maxFileSize = 1024 * 1024 * 20,    // 파일 크기 : 20MB
        maxRequestSize = 1024 * 1024 * 50  // 전체 업로드 데이터의 최대 크기  : 50MB
)
public class ReportWriteController extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/Report/ReportWrite.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String saveDir = req.getServletContext().getRealPath("/resources/img");

        // 파일 업로드
        String oFileName = null; // 초기화
        try {
            oFileName = FileUtil.uploadFile(req, saveDir);
        } catch (Exception e) {
            System.out.println("파일 업로드 실패");
            JSFunction.alertLocation(resp, "파일 업로드 오류", "../mvcboard.ReportWrite.do");
            return;
        }

        // 세션에서 id 가져오기
        HttpSession session = req.getSession(false); // 기존 세션이 없으면 새로 생성하지 않음
        if (session == null) {
            JSFunction.alertLocation(resp, "세션이 만료되었습니다. 다시 로그인 해주세요.", "../mvcboard/ProjectWrite.do");
            return;
        }
        String userid = (String) session.getAttribute("userid");
        System.out.println("세션에서 가져온 userid: " + userid);


//        HttpSession session = req.getSession();
//        String userid = (String) session.getAttribute("userid");
//
//        System.out.println("세션에서 가져온 userid: " + userid);

//        if (userid == null) {
////            JSFunction.alertLocation(resp, "로그인 후 접근 가능합니다.", "../mvcboard/ProjectWrite.do");
////            return;
////        }


        // 폼 값을 DTO에 저장
        ReportDTO dto = new ReportDTO();
        dto.setTitle(req.getParameter("title"));
        dto.setDates(req.getParameter("dates"));
        dto.setReport(req.getParameter("report"));
        dto.setDetail(req.getParameter("detail"));
        dto.setUserid(userid);

        if (oFileName != null && !oFileName.isEmpty()) {
            // 파일명 변경
            String sFileName = FileUtil.renameFile(saveDir, oFileName);
            dto.setOfile(oFileName);
            dto.setSfile(sFileName);
        }

        // DAO를 통해 DB 저장
        ReportDAO dao = new ReportDAO();
        int result = dao.insertUserInfo(dto);
        dao.close();

        if (result == 1) {
            resp.sendRedirect("../mvcboard/ReportList.do");
        } else {
            JSFunction.alertLocation(resp, "글쓰기 실패, 로그인 후 글쓰기가 가능합니다.", "../mvcboard/ReportWrite.do");
        }
    }
}
