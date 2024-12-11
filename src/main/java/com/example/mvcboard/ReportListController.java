package com.example.mvcboard;

import com.example.board.ReportDAO;
import com.example.board.ReportDTO;
import com.example.board.TestBoardDAO;
import com.example.board.TestBoardDTO;
import com.example.util.BoardPage;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/mvcboard/ReportList.do")
public class ReportListController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //DAO 생성
        ReportDAO dao = new ReportDAO();

        //뷰에 전달할 매개변수 저장용 맵 생성
        Map<String, Object> map = new HashMap<String, Object>();
        String searchField = req.getParameter("searchField");
        String searchWord = req.getParameter("searchWord");

        if(searchWord != null){
            map.put("searchWord", searchWord);
            map.put("searchField", searchField);
        }

        //게시물 수 확인
        int totalCount = dao.selectCount(map);

        //페이징 처리 start
        ServletContext application = getServletContext();
        //전체 페이지 수 계산
        int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
        int blockPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));
        int totalPage = (int) Math.ceil((double)totalCount/pageSize);

        //현재 페이지 확인
        int pageNum = 1;
        String pageTemp = req.getParameter("pageNum");
        if(pageTemp != null && !pageTemp.equals("")) {
            pageNum = Integer.parseInt(pageTemp); //페이지 요청받은 값
        }

        //목록에 출력할 게시물 범위 계산
        int start = (pageNum -1) * pageSize +1;
        int end = pageNum * pageSize;

        map.put("start", start);
        map.put("end", end);
        //페이징 처리 end

        //게시물 목록 가져오기
        List<ReportDTO> boardList = dao.selectListPage(map);
        dao.close();
        //뷰에 전달할 매개변수 추가
        String pagingImg =
                BoardPage.pagingStr(totalCount, pageSize, blockPage, pageNum,
                        "../mvcboard/ReportList.do");

        map.put("pagingImg", pagingImg);
        map.put("totalCount", totalCount);
        map.put("pageSize", pageSize);
        map.put("pageNum", pageNum);

        //전달 할 데이터를 req 영역에 저장하고 List.jsp 포워드
        req.setAttribute("boardList", boardList);
        req.setAttribute("map", map);


        req.getRequestDispatcher("../Report/ReportList.jsp").forward(req,resp);
    }
}