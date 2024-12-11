package com.example.main;

public class UserDTO {

    private String userid;
    private String userpwd;
    private String username;
    private Number userpt;
    private String userpic;
    private int rank;
    private String role;

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public int getRank() {
        return rank;
    }

    public void setRank(int rank) {
        this.rank = rank;
    }

    public UserDTO(String userId, String userPwd , String userName, Number userPt, String userPic,String role) {
        this.userid = userId;
        this.userpwd = userPwd;
        this.username = userName;
        this.userpt = userPt;
        this.userpic = userPic;
        this.role = role;

    }

    public String getUserid() {

        return userid;
    }

    public void setUserid(String userid) {

        this.userid = userid;
    }

    public String getUserpwd() {
        return userpwd;
    }

    public void setUserpwd(String userpwd) {
        this.userpwd = userpwd;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Number getUserpt() {
        return userpt;
    }

    public String getUserpic() {
        return userpic;
    }

    public void setUserpic(String userpic) {
        this.userpic = userpic;
    }

    public void setUserpt(Number userpt) {
        this.userpt = userpt;
    }
}