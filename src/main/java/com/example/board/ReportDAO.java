package com.example.board;


import com.example.common.DBConnPool;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;


// 저번에 DB연동하면서 만들었던 DBConnPool을 가져오겠다
public class ReportDAO extends DBConnPool {

    public ReportDAO() {
        super();
        //super() --> DBConnPool 을 호출한다
    }

    /// 검색 조건에 맞는 게시물의 개수를 반환
    public int selectCount(Map<String, Object> map) {
        int totalCount = 0;

        String query = "SELECT count(*) FROM scott.REPORTBOARD";

        // 검색어에 뭔가 작성되었을 경우 실행
        if (map.get("searchWord") != null) {
            query += " WHERE " + map.get("searchField") + " ";
            query += " LIKE '%" + map.get("searchWord") + "%'";
        }
        try {
            stmt = conn.createStatement();
            rs = stmt.executeQuery(query);
            rs.next();
            totalCount = rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("selectCount에서 오류 발생");
        }
        return totalCount;
    }

    /// 게시물 목록 가져오기
    // 페이징 처리한 게시물 리스트
    public List<ReportDTO> selectListPage(Map<String , Object>map){
        List<ReportDTO> boardList = new ArrayList<>();

        // 쿼리문 작성
        String query = "SELECT * "
                + " FROM (SELECT tb.*, rownum rNum"
                + " FROM (SELECT *"
                + " FROM scott.REPORTBOARD";
        if(map.get("searchWord") != null){
            query += " WHERE " + map.get("searchField") + " ";
            query += " LIKE '%" + map.get("searchWord") + "%'";
        }
        query += " ORDER BY num desc"
                + " ) tb"
                + " ) "
                + " WHERE rNum BETWEEN ? AND ?";
        try {
            psmt = conn.prepareStatement(query);
            psmt.setString(1,map.get("start").toString());
            psmt.setString(2,map.get("end").toString());

            rs = psmt.executeQuery();

            while (rs.next()){
                ReportDTO dto = new ReportDTO();
                dto.setNum(rs.getString("num"));
                dto.setTitle(rs.getString("title"));
                dto.setDetail(rs.getString("detail"));
                dto.setUserid(rs.getString("userid"));
                dto.setPostdate(rs.getDate("postdate"));
                dto.setVisitcount(rs.getString("visitcount"));
                dto.setReport(rs.getString("report"));

                // 리스트에 한 줄 씩 담기위함
                boardList.add(dto);
            }

        }catch (Exception e){
            e.printStackTrace();
            System.out.println("페이징 처리 selectListPage 오류 발생");
        }
        return boardList;
    }


    // 게시글 작성
    public int insertUserInfo(ReportDTO dto) {
        int result = 0;

        try {
            String query = "INSERT INTO scott.REPORTBOARD( "
                    + " num, title, detail, userid, visitcount, report , ofile, sfile)"
                    + " VALUES ( "
                    + " scott.SEQ_REPORTBOARD_NUM.nextval, ?, ?, ?, 0, ?, ?, ?)";

            psmt = conn.prepareStatement(query);
            psmt.setString(1, dto.getTitle());
            psmt.setString(2, dto.getDetail());
            psmt.setString(3, dto.getUserid());
            psmt.setString(4, dto.getReport());
            psmt.setString(5, dto.getOfile()); // 썸네일 경로 추가
            psmt.setString(6, dto.getSfile());
//            psmt.setString(7, dto.getRole());
            result = psmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("insertWrite 오류 발생");
        }
        return result;
    }

    // Report 게시글 상세보기
    public ReportDTO ProjectSelectView(String num){
        ReportDTO dto = new ReportDTO();
        String query = "SELECT * FROM scott.REPORTBOARD WHERE num = ?";
        try {
            psmt = conn.prepareStatement(query);
            psmt.setString(1, num);
            rs = psmt.executeQuery();

            if (rs.next()) {
                dto.setNum(rs.getString("num"));
                dto.setTitle(rs.getString("title"));
                dto.setDetail(rs.getString("detail"));
                dto.setUserid(rs.getString("userid"));
                dto.setOfile(rs.getString("ofile"));
                dto.setSfile(rs.getString("sfile"));
                dto.setReport(rs.getString("report"));
                dto.setPostdate(rs.getDate("postdate"));
                dto.setVisitcount(rs.getString("visitcount"));

            }
        }catch (Exception e){
            e.printStackTrace();
            System.out.println("ReportSelectView 오류발생");
        }
        return dto;
    }

    /// 조회수 증가
    public void updateViewCount(String num){
        // 쿼리문
        String query = " UPDATE scott.REPORTBOARD"
                + " SET visitcount = visitcount+1"
                + " WHERE num = ?";
        try {
            psmt = conn.prepareStatement(query);
            psmt.setString(1, num);
            rs = psmt.executeQuery();

        }catch (Exception e){
            e.printStackTrace();
            System.out.println("updateViewCount 오류 발생");
        }
    }
    /// 게시글 수정(위에 게시글 작성과 거의 흡사하고 쿼리문만 살짝 다름)
    public int updateEdit(ReportDTO dto){
        int result = 0;

        String query = "UPDATE scott.REPORTBOARD"
                + " SET title =? , detail=?, report = ? , ofile=? , sfile=? "
                + " WHERE num = ?";
        try {
            psmt = conn.prepareStatement(query);
            psmt.setString(1, dto.getTitle());
            psmt.setString(2, dto.getDetail());
            psmt.setString(3, dto.getReport());
            psmt.setString(4, dto.getOfile());
            psmt.setString(5, dto.getSfile()); // 썸네일 파일 경로 설정
            psmt.setString(6, dto.getNum());
            result = psmt.executeUpdate();

        }catch (Exception e){
            e.printStackTrace();
            System.out.println("updateEdit 오류 발생");
        }
        return result;
    }

    /// 게시글 삭제
//    public int deletePost(ReportDTO dto) {
//        int result = 0;
//        try {
//            String query = "DELETE FROM scott.REPORTBOARD" +
//                    " WHERE num =?";
//            psmt = conn.prepareStatement(query);
//            psmt.setString(1, dto.getNum());
//
//            result = psmt.executeUpdate();
//
//        } catch (Exception e) {
//            e.printStackTrace();
//            System.out.println("deletePost 오류 발생");
//        }
//        return result;
//    }
    /// 게시글 삭제
    public int deletePost(ReportDTO dto) {
        int result = 0;
        try {
            String query = "DELETE FROM scott.REPORTBOARD" +
                    " WHERE num =?";
            psmt = conn.prepareStatement(query);
            psmt.setString(1, dto.getNum());

            result = psmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("deletePost 오류 발생");
        }
        return result;
    }


}
