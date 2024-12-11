package com.example.main;


import com.example.board.TestBoardDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    private Connection conn;

    public UserDAO(Connection conn) {
        this.conn = conn;
    }

    // 중복 ID 검사
    public boolean isUsernameUN(String username) {
        String sql = "SELECT 1 FROM PJMEMBER WHERE USERNAME = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 사용자 유효성 검사
    public boolean validateUser(UserDTO user) {
        String sql = "SELECT USERID , USERPIC FROM PJMEMBER WHERE USERID = ? AND USERPWD = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, user.getUserid());
            pstmt.setString(2, user.getUserpwd());
            ResultSet rs = pstmt.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 사용자 추가
    public boolean addUser(UserDTO user) {
        String sql = "INSERT INTO scott.PJMEMBER (USERNUMBER, USERID, USERPWD, USERNAME,ROLE,USERPT) " +
                "VALUES (PJMemNum.nextval, ?, ?, ?, ?,0)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, user.getUserid());
            pstmt.setString(2, user.getUserpwd());
            pstmt.setString(3, user.getUsername());
            pstmt.setString(4, user.getRole());
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 사용자 정보 가져오기
    public UserDTO getUserById(String userId) {
        String sql = "SELECT USERID, USERPWD, USERNAME, USERPT, USERPIC, ROLE FROM PJMEMBER WHERE USERID = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return new UserDTO(
                        rs.getString("USERID"),
                        rs.getString("USERPWD"),
                        rs.getString("USERNAME"),
                        rs.getDouble("USERPT"),
                        rs.getString("USERPIC"), // 프로필 사진 경로 추가
                        rs.getString("ROLE")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // 비밀번호 변경 및 닉네임 수정
    public boolean updateUser(UserDTO user) {
        String sql = " UPDATE scott.PJMEMBER SET USERNAME = ? WHERE USERID = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getUserid());
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updatePassword(String userId, String newPassword) {
        String sql = "UPDATE scott.PJMEMBER SET USERPWD = ? WHERE USERID = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, newPassword);
            pstmt.setString(2, userId);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    // 닉네임 가져오기
    public String getUserName(String userId) {
        String userName = null;
        String sql = "SELECT USERNAME FROM PJMEMBER WHERE USERID = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                userName = rs.getString("USERNAME");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userName;
    }



    //프로필사진 업데이트
    public boolean UpdateUserPic(String userId, String userPic) {
        String sql = "UPDATE PJMEMBER SET USERPIC = ? WHERE USERID = ?";
        boolean isUpdated = false;

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userPic);
            pstmt.setString(2, userId);


            int rowsAffected = pstmt.executeUpdate();

            isUpdated = (rowsAffected > 0);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("SQL 예외 발생: " + e.getMessage());
        }

        return isUpdated;
    }

    public List<UserDTO> getTop10RankingList() {
        List<UserDTO> rankingList = new ArrayList<>();
        String sql = "SELECT USERID, USERNAME, USERPT, RANK " +
                "FROM (" +
                "  SELECT USERID, USERNAME, USERPT, " +
                "         RANK() OVER (ORDER BY USERPT DESC NULLS LAST) AS RANK " +
                "  FROM PJMEMBER" +
                ") " +
                "WHERE RANK <= 10";
        try (PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            int rank = 1;
            while (rs.next()) {
                UserDTO user = new UserDTO(
                        rs.getString("USERID"),
                        null,
                        rs.getString("USERNAME"),
                        rs.getDouble("USERPT"),
                        null,
                        null
                );
                user.setRank(rs.getInt("RANK"));
                rankingList.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rankingList;
    }

    public String getUserIdByUsername(String username) throws SQLException {
        String userId = null;
        String sql = "SELECT USERID FROM scott.\"PJMEMBER\" WHERE USERNAME = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, username);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    userId = rs.getString("USERID");
                    // 로그: userId 확인
                    System.out.println("Retrieved userId: " + userId);
                } else {
                    // 로그: username이 데이터베이스에 없음
                    System.out.println("No userId found for username: " + username);
                }
            }
        }
        return userId;
    }


    public void updateUserPoints(String userId, int points) throws SQLException {
        String sql = "UPDATE scott.PJMEMBER SET USERPT = USERPT + ? WHERE USERID = ?";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, points);
            pstmt.setString(2, userId);
            pstmt.executeUpdate();
        }
    }

    public List<TestBoardDTO> getUserPosts(String userId) {
        List<TestBoardDTO> posts = new ArrayList<>();
        String sql = "SELECT b.NUM, b.TITLE, b.USERID, b.POSTDATE, b.DETAIL, b.VISITCOUNT, b.PEOPLE, b.OFILE, b.SFILE, m.USERNAME "
                + "FROM ("
                + "    SELECT NUM, TITLE, USERID, POSTDATE, DETAIL, VISITCOUNT, PEOPLE, OFILE, SFILE "
                + "    FROM MYBOARD "
                + "    WHERE USERID = ? "
                + "    ORDER BY POSTDATE DESC"
                + ") b "
                + "JOIN PJMEMBER m ON b.USERID = m.USERID "
                + "WHERE ROWNUM <= 5";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                TestBoardDTO post = new TestBoardDTO();
                post.setNum(rs.getString("NUM"));
                post.setTitle(rs.getString("TITLE"));
                post.setUserid(rs.getString("USERID")); // USERID
                post.setPostdate(rs.getDate("POSTDATE"));
                post.setDetail(rs.getString("DETAIL"));
                post.setVisitcount(rs.getString("VISITCOUNT"));
                post.setPeople(rs.getString("PEOPLE"));
                post.setOfile(rs.getString("OFILE"));
                post.setSfile(rs.getString("SFILE"));
                post.setUsername(rs.getString("USERNAME")); // USERNAME

                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return posts;
    }
    public boolean deleteUserById(String userId) {
        String sql = "DELETE FROM PJMEMBER WHERE USERID = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            int affectedRows = pstmt.executeUpdate();
            System.out.println("삭제된 행의 수: " + affectedRows); // 로그 추가
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}

