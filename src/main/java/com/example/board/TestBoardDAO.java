package com.example.board;


import com.example.common.DBConnPool;
import com.example.main.UserDAO;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;


// 저번에 DB연동하면서 만들었던 DBConnPool을 가져오겠다
public class TestBoardDAO extends DBConnPool {

    public TestBoardDAO() {
        super();
        //super() --> DBConnPool 을 호출한다
    }

    /// 검색 조건에 맞는 게시물의 개수를 반환
    public int selectCount(Map<String, Object> map) {
        int totalCount = 0;

        String query = "SELECT count(*) FROM scott.MYBOARD";

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

    // 페이징 username을 적용시키기위함
    public List<TestBoardDTO> selectListPage(Map<String, Object> map) {
        List<TestBoardDTO> boardList = new ArrayList<>();

        String query = "SELECT * FROM ( "
                + "  SELECT tb.*, pm.username, ROW_NUMBER() OVER (ORDER BY tb.num DESC) AS rn "
                + "  FROM scott.MYBOARD tb "
                + "  JOIN scott.PJMEMBER pm ON tb.userid = pm.userid ";

        if (map.get("searchWord") != null) {
            query += " WHERE " + map.get("searchField") + " "
                    + " LIKE ? ";
        }

        query += " ) "
                + " WHERE rn BETWEEN ? AND ?";

        try {
            psmt = conn.prepareStatement(query);

            int paramIndex = 1;
            if (map.get("searchWord") != null) {
                psmt.setString(paramIndex++, "%" + map.get("searchWord") + "%");
            }
            psmt.setInt(paramIndex++, Integer.parseInt(map.get("start").toString()));
            psmt.setInt(paramIndex, Integer.parseInt(map.get("end").toString()));

            rs = psmt.executeQuery();

            while (rs.next()) {
                TestBoardDTO dto = new TestBoardDTO();
                dto.setNum(rs.getString("num"));
                dto.setTitle(rs.getString("title"));
                dto.setDetail(rs.getString("detail"));
                dto.setUserid(rs.getString("userid"));
                dto.setSport(rs.getString("sport"));
                dto.setDates(rs.getString("dates"));
                dto.setPostdate(rs.getDate("postdate"));
                dto.setVisitcount(rs.getString("visitcount"));
                dto.setPeople(rs.getString("people"));
                dto.setSfile(rs.getString("sfile"));
                dto.setOfile(rs.getString("ofile"));
                dto.setUsername(rs.getString("username"));

                boardList.add(dto);
            }

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("페이징 처리 selectListPage 오류 발생");
        }
        return boardList;
    }



//     페이징 처리한 게시물 리스트
//    public List<TestBoardDTO> selectListPage(Map<String , Object>map){
//        List<TestBoardDTO> boardList = new ArrayList<>();
//
//        // 쿼리문 작성
//        String query = "SELECT * "
//                + " FROM (SELECT tb.*, rownum rNum"
//                + " FROM (SELECT *"
//                + " FROM scott.MYBOARD";
//        if(map.get("searchWord") != null){
//            query += " WHERE " + map.get("searchField") + " ";
//            query += " LIKE '%" + map.get("searchWord") + "%'";
//        }
//        query += " ORDER BY num desc"
//                + " ) tb"
//                + " ) "
//                + " WHERE rNum BETWEEN ? AND ?";
//        try {
//            psmt = conn.prepareStatement(query);
//            psmt.setString(1,map.get("start").toString());
//            psmt.setString(2,map.get("end").toString());
//
//            rs = psmt.executeQuery();
//
//            while (rs.next()){
//                TestBoardDTO dto = new TestBoardDTO();
//                dto.setNum(rs.getString("num"));
//                dto.setTitle(rs.getString("title"));
//                dto.setDetail(rs.getString("detail"));
//                dto.setUserid(rs.getString("userid"));
//                dto.setSport(rs.getString("sport"));
//                dto.setDates(rs.getString("dates"));
//                dto.setPostdate(rs.getDate("postdate"));
//                dto.setVisitcount(rs.getString("visitcount"));
//                dto.setPeople(rs.getString("people"));
//                dto.setSfile(rs.getString("sfile"));
//                dto.setOfile(rs.getString("ofile"));
////                dto.setUsername(rs.getString("username"));
//
//                // 리스트에 한 줄 씩 담기위함
//                boardList.add(dto);
//            }
//
//        }catch (Exception e){
//            e.printStackTrace();
//            System.out.println("페이징 처리 selectListPage 오류 발생");
//        }
//        return boardList;
//    }


    // 게시글 작성
    public int insertUserInfo(TestBoardDTO dto) {
        int result = 0;

        try {
            String query = "INSERT INTO scott.MYBOARD( "
                    + " num, title, detail, userid, sport, dates, visitcount, people, ofile, sfile)"
                    + " VALUES ( "
                    + " scott.seq_proboard_num.nextval, ?, ?, ?, ?, ?, 0, ?, ?, ?)";

            psmt = conn.prepareStatement(query);
            psmt.setString(1, dto.getTitle());
            psmt.setString(2, dto.getDetail());
            psmt.setString(3, dto.getUserid());
            psmt.setString(4, dto.getSport());
            psmt.setString(5, dto.getDates());
            psmt.setString(6, dto.getPeople());
            psmt.setString(7, dto.getOfile()); // 썸네일 경로 추가
            psmt.setString(8, dto.getSfile());
            result = psmt.executeUpdate();

            if (result > 0) {
                // UserDAO 객체 생성
                UserDAO userDAO = new UserDAO(conn);
                // 글쓰기 점수 업데이트
                userDAO.updateUserPoints(dto.getUserid(), 10); // 예를 들어 10점을 추가
            }


        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("insertWrite 오류 발생");
        }
        return result;
    }

    // Project 게시글 상세보기
    // 게시글 상세보기
    public TestBoardDTO ProjectSelectView(String num) {
        TestBoardDTO dto = new TestBoardDTO();
        String query = "SELECT tb.num, tb.title, tb.detail, tb.userid, tb.sport, tb.dates, tb.postdate, tb.visitcount, tb.people, tb.sfile, tb.ofile, pm.username "
                + "FROM scott.MYBOARD tb "
                + "JOIN scott.PJMEMBER pm ON tb.userid = pm.userid "
                + "WHERE tb.num = ?";
        try {
            psmt = conn.prepareStatement(query);
            psmt.setString(1, num);
            rs = psmt.executeQuery();

            if (rs.next()) {
                dto.setNum(rs.getString("num"));
                dto.setTitle(rs.getString("title"));
                dto.setDetail(rs.getString("detail"));
                dto.setUserid(rs.getString("userid"));
                dto.setUsername(rs.getString("username")); // 추가된 부분
                dto.setOfile(rs.getString("ofile"));
                dto.setSfile(rs.getString("sfile"));
                dto.setSport(rs.getString("sport"));
                dto.setDates(rs.getString("dates"));
                dto.setPostdate(rs.getDate("postdate"));
                dto.setVisitcount(rs.getString("visitcount"));
                dto.setPeople(rs.getString("people"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("ProjectSelectView 오류발생");
        }
        return dto;
    }
//    public TestBoardDTO ProjectSelectView(String num){
//        TestBoardDTO dto = new TestBoardDTO();
//        String query = "SELECT * FROM scott.MYBOARD WHERE num = ?";
//        try {
//            psmt = conn.prepareStatement(query);
//            psmt.setString(1, num);
//            rs = psmt.executeQuery();
//
//            if (rs.next()) {
//                dto.setNum(rs.getString("num"));
//                dto.setTitle(rs.getString("title"));
//                dto.setDetail(rs.getString("detail"));
//                dto.setUserid(rs.getString("userid"));
//                dto.setOfile(rs.getString("ofile"));
//                dto.setSfile(rs.getString("sfile"));
//                dto.setSport(rs.getString("sport"));
//                dto.setDates(rs.getString("dates"));
//                dto.setPostdate(rs.getDate("postdate"));
//                dto.setVisitcount(rs.getString("visitcount"));
//                dto.setPeople(rs.getString("people"));
//
//            }
//        }catch (Exception e){
//            e.printStackTrace();
//            System.out.println("ProjectSelectView 오류발생");
//        }
//        return dto;
//    }

    /// 조회수 증가
    public void updateViewCount(String num){
        // 쿼리문
        String query = " UPDATE scott.MYBOARD"
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
    public int updateEdit(TestBoardDTO dto){
        int result = 0;

        String query = "UPDATE scott.MYBOARD"
                + " SET title =? , detail=?, sport = ?,dates = ? ,people = ?, ofile=? , sfile=? "
                + " WHERE num = ?";
        try {
            psmt = conn.prepareStatement(query);
            psmt.setString(1, dto.getTitle());
            psmt.setString(2, dto.getDetail());
            psmt.setString(3, dto.getSport());
            psmt.setString(4, dto.getDates());
            psmt.setString(5, dto.getPeople());
            psmt.setString(6, dto.getOfile());
            psmt.setString(7, dto.getSfile()); // 썸네일 파일 경로 설정
            psmt.setString(8, dto.getNum());
            result = psmt.executeUpdate();

        }catch (Exception e){
            e.printStackTrace();
            System.out.println("updateEdit 오류 발생");
        }
        return result;
    }

    /// 게시글 삭제
    public int deletePost(TestBoardDTO dto) {
        int result = 0;
        try {
            String query = "DELETE FROM scott.MYBOARD" +
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
