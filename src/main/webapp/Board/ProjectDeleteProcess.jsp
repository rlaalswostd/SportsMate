<%@ page import="com.example.board.TestBoardDTO" %>
<%@ page import="com.example.board.TestBoardDAO" %>
<%@ page import="com.example.util.JSFunction" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8"
%>
<%
  String num = request.getParameter("num");
  TestBoardDTO dto = new TestBoardDTO();
  TestBoardDAO dao = new TestBoardDAO();

  dto = dao.ProjectSelectView(num);

  // 세션 로그인 ID
  String sessionId = session.getAttribute("userid").toString();
  String userRole = (String) session.getAttribute("role");
  int delResult = 0;

// 작성자 본인 또는 관리자만 삭제 가능
  if (sessionId.equals(dto.getUserid()) || "admin".equals(userRole)) {
    // 같을 때에만 삭제 해준다
    dto.setNum(num);
    // DAO 호출해서 삭제
    delResult = dao.deletePost(dto);
    dao.close();

    if (delResult == 1) {
      JSFunction.alertLocation("삭제 되었습니다.", "../mvcboard/MainHome.do", out);
    } else {
      JSFunction.alertBack("삭제 실패", out);
    }

  } else {
    // 작성자 본인 및 관리자가 아니면 삭제 안됨
    JSFunction.alertBack("작성자 본인 또는 관리자만 삭제 가능합니다", out);
  }
%>

