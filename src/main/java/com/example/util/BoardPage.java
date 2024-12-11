package com.example.util;

public class BoardPage {

    public static String pagingStr(int totalCount, int pageSize, int blockPage, int pageNum, String reqUrl){
        String pagingStr = "";

        //전체 페이지 계산
        int totalPage = (int) Math.ceil((double) totalCount/pageSize);

        int pageTemp = (((pageNum - 1) / blockPage) * blockPage) + 1;

        //이전 페이지 블록 바로가기
        if(pageTemp != 1){
            pagingStr += " <a href='" + reqUrl + "?pageNum=1'>[첫 페이지]</a>";
            pagingStr += " &nbsp";
            pagingStr += " <a href='" + reqUrl + "?pageNum=" + (pageTemp -1) + "'>[이전 블록]</a>";
        }

        //각 페이지 번호 출력
        int blockCount = 1;
        while(blockCount <= blockPage && pageTemp <= totalPage){
            if(pageTemp == pageNum){
                //현재 페이지는 링크 걸지 않음
                pagingStr += "&nbsp;" + pageTemp + "&nbsp;";

            }else {
                pagingStr += "&nbsp; <a href='" + reqUrl+"?pageNum=" + pageTemp + "'>" + pageTemp + "</a>&nbsp;";
            }
            pageTemp++;
            blockCount++;

        }

        //다음 페이지 블록 바로가기
        if(pageTemp <= totalPage){
            pagingStr += " <a href='" + reqUrl + "?pageNum=" + pageTemp + "'>[다음 블록]</a>";
            pagingStr += " &nbsp";
            pagingStr += " <a href='" + reqUrl + "?pageNum="+totalPage+"'>[마지막 페이지]</a>";
        }

        return pagingStr;
    }
}