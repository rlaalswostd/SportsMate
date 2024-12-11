<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpServletRequest" %>
<%@ page import="jakarta.servlet.http.HttpServletResponse" %>
<%@ page import="jakarta.servlet.ServletException" %>
<%@ page import="java.io.IOException" %>
<%@ page import="com.example.main.FileUtil" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.List" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@ page import="org.apache.commons.fileupload.FileItem" %>

<%
    boolean isMultipart = ServletFileUpload.isMultipartContent(request);

    if (isMultipart) {
        try {
            String uploadPath = application.getRealPath("/") + "uploads/";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            ServletFileUpload upload = new ServletFileUpload(new DiskFileItemFactory());
            List<FileItem> items = upload.parseRequest(request);
            boolean fileUploaded = false; // 파일 업로드 여부 확인용 변수

            for (FileItem item : items) {
                if (!item.isFormField()) {
                    if (item.getSize() > 0) { // 파일이 선택되었는지 확인
                        String fileName = item.getName();
                        String newFileName = "upload_" + System.currentTimeMillis() + "_" + fileName;
                        File uploadedFile = new File(uploadDir, newFileName);
                        item.write(uploadedFile);
                        fileUploaded = true;
                        out.println("파일이 성공적으로 업로드되었습니다: " + newFileName);
                    } else {
                        // 파일이 선택되지 않은 경우
                        out.println("<script>alert('이미지가 선택되지 않았습니다. 이미지를 선택해주세요.'); history.back();</script>");
                        return;
                    }
                }
            }

            if (!fileUploaded) {
                out.println("<script>alert('이미지가 선택되지 않았습니다. 이미지를 선택해주세요.'); history.back();</script>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('파일 업로드 중 오류가 발생했습니다.'); history.back();</script>");
        }
    } else {
        out.println("<script>alert('파일 업로드 형식이 아닙니다.'); history.back();</script>");
    }
%>
