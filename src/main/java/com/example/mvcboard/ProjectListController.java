package com.example.mvcboard;

import com.example.board.TestBoardDAO;
import com.example.board.TestBoardDTO;
import com.example.main.UserDAO;
import com.example.main.UserDTO;
import com.example.util.BoardPage;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/mvcboard/MainHome.do")
public class ProjectListController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        TestBoardDAO boardDAO = new TestBoardDAO();
        UserDAO userDAO = null;
        Connection conn = null;

        try {
            // 데이터베이스 연결
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "scott", "tiger");
            userDAO = new UserDAO(conn);

            // 게시물 목록 처리
            Map<String, Object> map = new HashMap<>();
            String searchField = req.getParameter("searchField");
            String searchWord = req.getParameter("searchWord");

            if (searchWord != null) {
                map.put("searchWord", searchWord);
                map.put("searchField", searchField);
            }

            int totalCount = boardDAO.selectCount(map);

            // 페이징 처리 start
            ServletContext application = getServletContext();
            int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
            int blockPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));
            int totalPage = (int) Math.ceil((double) totalCount / pageSize);

            int pageNum = 1;
            String pageTemp = req.getParameter("pageNum");
            if (pageTemp != null && !pageTemp.equals("")) {
                pageNum = Integer.parseInt(pageTemp);
            }

            int start = (pageNum - 1) * pageSize + 1;
            int end = pageNum * pageSize;

            map.put("start", start);
            map.put("end", end);

            // 게시물 목록 가져오기
            List<TestBoardDTO> boardList = boardDAO.selectListPage(map);
            boardDAO.close();

            // 랭킹 정보 가져오기
            List<UserDTO> rankingList = userDAO.getTop10RankingList();

            // 페이징 처리
            String pagingImg = BoardPage.pagingStr(totalCount, pageSize, blockPage, pageNum, "../mvcboard/MainHome.do");

            map.put("pagingImg", pagingImg);
            map.put("totalCount", totalCount);
            map.put("pageSize", pageSize);
            map.put("pageNum", pageNum);

            // 전달할 데이터 설정
            req.setAttribute("boardList", boardList);
            req.setAttribute("rankingList", rankingList);
            req.setAttribute("map", map);

            // JSP 페이지로 포워드
            req.getRequestDispatcher("/Home/MainHome.jsp").forward(req, resp);

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
