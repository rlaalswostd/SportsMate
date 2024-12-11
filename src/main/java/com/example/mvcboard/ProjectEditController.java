package com.example.mvcboard;

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

import java.io.IOException;

@WebServlet("/mvcboard/ProjectEdit.do")
@MultipartConfig(
        maxFileSize = 1024 * 1024 * 20,    //20MB
        maxRequestSize = 1024 * 1024 * 50  //50MB
)
public class ProjectEditController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String num= req.getParameter("num");
        TestBoardDAO dao = new TestBoardDAO();
        TestBoardDTO dto = dao.ProjectSelectView(num);

        req.setAttribute("dto",dto);
        req.getRequestDispatcher("/Board/ProjectEdit.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //파일 업로드 처리
        String sDir = req.getServletContext().getRealPath("/resources/img");

        String oFileName = "";

    // JSP와 서블릿에서 part와 parameter는 파일 업로드와 폼 데이터 처리를 다루는 데 있어 중요한 개념
    // Part : part는 HTTP요청의 multipart/form-data 콘텐츠를 다룰 때 사용됨
    // (주로 파일 업로드와 같은 복잡한 폼 데이터를 처리할 때 사용)

    // parameter : 폼 필드에서 전송된 데이터를 처리하는데 사용됨
        // (주로 텍스트 , 선택 상자, 라디오 버튼 등)

        try {
            oFileName = FileUtil.uploadFile(req,sDir);
        }catch (Exception e){
            e.printStackTrace();
            JSFunction.alertBack(resp, "파일 업로드 오류");
        }
    String num = req.getParameter("num");
    String prevOfile = req.getParameter("prevOfile");
    String prevSfile = req.getParameter("prevSfile");
    String userid = req.getParameter("userid");
    String sport = req.getParameter("sport");
    String title = req.getParameter("title");
    String detail = req.getParameter("detail");
    String dates = req.getParameter("dates");
    String people = req.getParameter("people");

//    HttpSession session = req.getSession();

        TestBoardDTO dto = new TestBoardDTO();
        dto.setNum(num);
        dto.setUserid(userid);
        dto.setTitle(title);
        dto.setDetail(detail);
        dto.setSport(sport);
        dto.setDates(dates);
        dto.setPeople(people);

        //원본 파일명과 저장된 파일명 이름 설정
        if(oFileName != ""){ //신규로 파일 등록 한 경우
            String sFileName = FileUtil.renameFile(sDir, oFileName);
            dto.setOfile(oFileName);
            dto.setSfile(sFileName);

            FileUtil.deleteFile(req,"/resources/img", prevSfile);

        }else { //첨부파일이 없는 경우 - 기존 파일 유지
            dto.setSfile(prevSfile);
            dto.setOfile(prevOfile);
        }
        TestBoardDAO dao =new TestBoardDAO();
        int result = dao.updateEdit(dto);

        dao.close();

        if(result == 1){
            resp.sendRedirect("../mvcboard/MainHome.do?num="+num);
        }
    }
}
