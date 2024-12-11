package com.example.main;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.nio.file.Paths;

public class FileUtil {

    /**
     * 파일을 지정된 경로에 업로드하는 메소드
     *
     * @param request       HttpServletRequest 객체
     * @param saveDirectory 파일을 저장할 경로
     * @return 업로드된 파일의 이름 또는 null (파일이 업로드되지 않았을 경우)
     * @throws IOException
     * @throws ServletException
     */
    public static String uploadFile(HttpServletRequest request, String saveDirectory) throws IOException, ServletException {
        Part filePart = request.getPart("USERPIC");

        // 파일이 선택되지 않았을 경우
        if (filePart == null || filePart.getSize() == 0) {
            
            return null;

        }

        String userId = (String) request.getSession().getAttribute("userId");
        String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String uniqueFileName = userId + "propic.jpg";

        File saveDir = new File(saveDirectory);
        if (!saveDir.exists()) {
            saveDir.mkdirs();
        }

        File file = new File(saveDir, uniqueFileName);
        try (InputStream fileContent = filePart.getInputStream()) {
            Files.copy(fileContent, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
        }

        return uniqueFileName;
    }
}
