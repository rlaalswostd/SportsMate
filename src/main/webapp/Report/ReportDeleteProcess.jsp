<%@ page import="com.example.board.ReportDTO" %>
<%@ page import="com.example.board.ReportDAO" %>
<%@ page import="com.example.util.JSFunction" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8"
%>
<%
  String num = request.getParameter("num");
  ReportDTO dto = new ReportDTO();
  ReportDAO dao = new ReportDAO();

  dto = dao.ProjectSelectView(num);

  // 세션 로그인 ID
  String sessionId = session.getAttribute("userid") != null ? session.getAttribute("userid").toString() : "";
  String userRole = session.getAttribute("role") != null ? session.getAttribute("role").toString() : "";
  int delResult = 0;

  if (sessionId.equals(dto.getUserid()) || "admin".equals(userRole)) {
    // 작성자이거나 관리자인 경우 삭제 처리
    dto.setNum(num);
    // DAO 호출해서 삭제
    delResult = dao.deletePost(dto);
    dao.close();

    if (delResult == 1) {
      JSFunction.alertLocation("삭제 되었습니다.", "../mvcboard/ReportList.do", out);
    } else {
      JSFunction.alertBack("삭제 실패", out);
    }
  } else {
    // 작성자 본인이 아니고 관리자가 아닌 경우 삭제 불가
    JSFunction.alertBack("작성자 본인 또는 관리자만 삭제 가능합니다", out);
  }
%>

