package com.example.fileupload;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;

public class FileUtil {
    /*
     * 1. Part 객체 생성 및 파일 저장
     * 2. 새로운 파일명 생성(업로드 일시.확장자)
     * 3. 파일명 변경
     * 4. 다른 폼값 처리
     * 5. DTO 생성
     * 6. DAO를 통해 데이터 저장
     * 7. 파일 목록 JSP로 리다이렉션
     * */

    public static String uploadFile(HttpServletRequest req , String sDir)
            throws ServletException , IOException {

        //Part 객체를 통해 서버로 전송된 파일명 읽기
        Part part = req.getPart("ofile");
        //Part 객체의 헤더값 content-disposition 값 읽기
        String partHeader = part.getHeader("content-disposition");
        //form-data; name="attachedFile"; filename="파일명.확장자";
        System.out.println("partHeader 확인 : " + partHeader);

        //헤더에서 파일명 잘라내기
        String[] phArr = partHeader.split("filename=");
        String originalFileName = phArr[1].trim().replace("\"" ,"");

        //전송된 파일이 있으면 디렉토리에 저장
        if(!originalFileName.isEmpty()){
            // C://download/filename.확장자
            part.write(sDir + File.separator + originalFileName);
        }


        return originalFileName;
    }


    //파일명 변경
    public static String renameFile(String sDir, String fileName){
        //확장자 잘라내기
        //temp.png

        String ext = fileName.substring(fileName.lastIndexOf("."));

        //날짜_시간.확장자 새로운 파일명 생성
        String now = new SimpleDateFormat("yyyyMMdd_HmsS")
                .format(new Date());
        String newFileName = now + ext;
        //20240806_101220.png

        //기존 파일명을 새 파일명으로 변경
        File oldFile = new File(sDir + File.separator+fileName);
        File newFile = new File(sDir + File.separator+newFileName);

        oldFile.renameTo(newFile);

        return newFileName;

    }

    //multiple 속성 추가로 2개이상 파일 업로드
    public static ArrayList<String> multipleFile(HttpServletRequest req , String sDir)
            throws ServletException, IOException{

        //파일명 저장을 위한 컬렉션 생성
        ArrayList<String> listFileName = new ArrayList<>();

        //Part 객체를 통해 서버로 전성된 파일명 읽어오기
        Collection<Part> parts = req.getParts();
        for(Part part : parts){
            //파일이 아니라면 업로드 대상에서 무시
            if (!part.getName().equals("ofile")) {
                continue;
            }
            String partHeader = part.getHeader("content-disposition");
            //form-data; name="attachedFile"; filename="파일명.확장자";

            //헤더 값에서 파일명 잘라내기
            String[] phArr = partHeader.split("filename=");
            String originalFileName = phArr[1].trim().replace("\"", "");

            //전송된 파일이 있으면 디렉토리에 저장
            if(!originalFileName.isEmpty()){
                part.write(sDir + File.separator + originalFileName);
            }

            //컬렉션에 추가
            listFileName.add(originalFileName);
        }

        return listFileName;
    }

    //파일 다운로드
    public static void download(HttpServletRequest req, HttpServletResponse resp,
                                String dir, String sfileName , String ofileName){
        // dir = "/upload"
        String sDir = req.getServletContext().getRealPath(dir);

        try {
            File file = new File(sDir, sfileName);
            InputStream inputStream = new FileInputStream(file);

            String client = req.getHeader("user-agent");
            System.out.println("클라이언트 헤더 정보 : " + client);
            if(client.indexOf("WOW64") == -1) { //익스플로러가 아닌 경우
                ofileName = new String(ofileName.getBytes("UTF-8"), "ISO-8859-1");
            }else { //익스플로러인 경우
                ofileName = new String(ofileName.getBytes("KSC5601"), "ISO-8859-1");
            }

            //파일 다운로드용 헤더 설정
            resp.reset();
            resp.setContentType("application/octet-stream; charset=utf-8");
            resp.setHeader("Content-Disposition" , "attachment; filename=\"" + ofileName );
            resp.setHeader("Content-Length", "" +file.length());

            //출력 스트림 초기화

            //response 내장 객체로부터 새로운 출력 스트림 생성
            OutputStream outputStream = resp.getOutputStream();

            //출력 스트림에 파일내용 출력
            byte[] b = new byte[(int)file.length()];
            int readBuffer = 0;
            while ((readBuffer = inputStream.read(b))>0) {
                outputStream.write(b,0, readBuffer);
            }

            //입출력 스트림 닫음
            inputStream.close();
            outputStream.close();


        }catch (FileNotFoundException e) {
            e.printStackTrace();
            System.out.println("파일을 찾을 수 없음");
        }

        catch (Exception e){
            e.printStackTrace();
            System.out.println("파일 다운로드 중 예외 발생");
        }


    }

    //파일 삭제
    public static void deleteFile(HttpServletRequest req, String dir , String fileName){
        String sDir = req.getServletContext().getRealPath(dir);
        File file = new File(sDir + File.separator + fileName);
        if(file.exists()){
            file.delete();
        }
    }


}