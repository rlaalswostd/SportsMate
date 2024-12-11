package com.example.mvcboard;

import com.example.board.CommentDAO;
import com.example.board.CommentDTO;
import com.example.board.TestBoardDAO;
import com.example.board.TestBoardDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@WebServlet("/mvcboard/ProjectView.do")
public class ProjectViewController extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        //게시물 불러오기
        TestBoardDAO dao = new TestBoardDAO();
        String num = req.getParameter("num");
        dao.updateViewCount(num);
        TestBoardDTO dto = dao.ProjectSelectView(num);
        dao.close();

        // 댓글 목록 조회
        CommentDAO commentDAO = new CommentDAO();
        List<CommentDTO> comments = commentDAO.getCommentsWithReplies(num);
        System.out.println("컨트롤러에서 조회된 댓글 수: " + comments.size());
        req.setAttribute("comments", comments);
        System.out.println("댓글 수: " + comments.size());
        for (CommentDTO comment : comments) {
            System.out.println("댓글 내용: " + comment.getContent());
        }

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
//        req.setAttribute("comments", comments); // 댓글 목록 설정
        req.getRequestDispatcher("/Board/ProjectView.jsp").forward(req,resp);

        System.out.println("세션 ID: " + req.getSession().getId());
        System.out.println("로그인 사용자: " + req.getSession().getAttribute("username"));

    }
}