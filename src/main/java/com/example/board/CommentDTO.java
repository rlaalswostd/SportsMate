package com.example.board;

import java.sql.Date;
import java.util.List;

public class CommentDTO {
    private String id;
    private int postnum;
    private String content;
    private String username;
    private Date postdate;
    private String parentId;
    private List<CommentDTO> replies;

    public List<CommentDTO> getReplies() {
        return replies;
    }

    public void setReplies(List<CommentDTO> replies) {
        this.replies = replies;
    }

    public CommentDTO() {
    }

    // 파라미터가 있는 생성자
    public CommentDTO(String id, int postNum, String username, String content, Date postdate) {
        this.id = id;
        this.postnum = postNum;
        this.username = username;
        this.content = content;
        this.postdate = postdate;
    }

    public void setPostdate(Date postdate) {
        this.postdate = postdate;
    }

    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public int getPostnum() {
        return postnum;
    }

    public void setPostnum(int postnum) {
        this.postnum = postnum;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Date getPostdate() {
        return postdate;
    }

    public void setPostDate(Date Postdate) {
        this.postdate = postdate;
    }

    @Override
    public String toString() {
        return "CommentDTO [id=" + id + ", postnum=" + postnum + ", username=" + username + ", content=" + content
                + ", postdate=" + postdate + "]";
    }
}
