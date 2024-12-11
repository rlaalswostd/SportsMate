<%
    session.invalidate();
    response.sendRedirect("/mvcboard/MainHome.do");
//    response.sendRedirect("MainHome.jsp");
%>