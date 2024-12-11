<%@ page import="com.example.board.TestBoardDTO" %>
<%@ page import="com.example.board.TestBoardDAO" %>
<%@ page import="com.example.util.JSFunction" %>

<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8"
%>

<%


  String num = request.getParameter("num");
  String title = request.getParameter("title");
  String detail = request.getParameter("detail");
  String sport = request.getParameter("sport");
  String dates = request.getParameter("dates");
  String people = request.getParameter("people");
//  String ofile = request.getParameter("ofile");
//  String sfile = request.getParameter("Sfile");



  TestBoardDTO dto = new TestBoardDTO();
  dto.setTitle(title);
  dto.setSport(sport);
  dto.setDetail(detail);
  dto.setNum(num);
  dto.setDates(dates);
  dto.setPeople(people);
//  dto.setSfile(fileName); // 저장된 파일명

//  dto.setOfile(ofile); // 기존 파일 또는 업데이트된 파일 경로
//  dto.setSfile(sfile); // 새 썸네일 파일 경로

  // DB 업데이트
  TestBoardDAO dao = new TestBoardDAO();
  int affected = dao.updateEdit(dto);

  dao.close();

  if(affected == 1){ //성공
    response.sendRedirect("../mvcboard/MainHome.do?num="+dto.getNum());
  }else { //실패
    JSFunction.alertBack("수정 실패", out);
  }
%>

