package com.example.common;

import java.sql.*;

public class JDBCConnect {

    //DATA BASE와 연결을 담당
    public Connection conn;
    //파라미터가 없는 정적쿼리를 실행 할때 사용
    public Statement stmt;
    //파라미터가 없는 동적쿼리를 실행 할때 사용
    public PreparedStatement psmt;
    //쿼리문 결과를 저장할 때 사용 할
    public ResultSet rs;


    public JDBCConnect(String driver, String url, String id, String pass) {
        try{
            Class.forName(driver);
            //DB연결
            conn = DriverManager.getConnection(url, id, pass);
            System.out.println("DB연결 성공 (파라미터 생성자) ");
        }catch (Exception e){
            e.printStackTrace();
        }
    }



    //연결해제 (자원반납)
    public void close(){
        try{
            if(rs != null) rs.close();
            if(stmt != null) stmt.close();
            if(psmt != null) psmt.close();
            if(conn != null) conn.close();
        }
        catch(Exception e){
            e.printStackTrace();
        }
    }



}
