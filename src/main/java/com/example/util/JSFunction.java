package com.example.util;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.jsp.JspWriter;

import java.io.PrintWriter;

public class JSFunction {
    // 메시지 알림창을 띄운 후 해당 URL로 이동
    public static void alertLocation(String msg, String url, JspWriter out) {
        // 자바 스크립트 코드
        try {
            String script = ""
                    + "<script>"
                    + " alert('" + msg + "');"
                    + " location='" + url + "';"
                    + "</script>";

            out.println(script);
        } catch (Exception e) { }
    }

    public static void alertLocation(HttpServletResponse resp, String msg , String url){
        try {
            resp.setContentType("text/html; charset=UTF-8");
            PrintWriter writer = resp.getWriter();
            String script = ""
                    + "<script>"
                    + " alert('" + msg + "');"
                    + " location='" + url + "';"
                    + "</script>";

            writer.println(script);
        }catch (Exception e){

        }
    }


    // 메시지 알림창을 띄운 후 이전 페이지로 이동
    public static void alertBack(String msg, JspWriter out) {
        // 자바 스크립트 코드
        try {
            String script = ""
                    + "<script>"
                    + " alert('" + msg + "');"
                    + " history.back();"
                    + "</script>";

            out.println(script);
        } catch (Exception e) { }
    }

    public static void alertBack(HttpServletResponse resp, String msg){
        try {
            resp.setContentType("text/html; charset=UTF-8");
            PrintWriter writer = resp.getWriter();

            String script = ""
                    + "<script>"
                    + " alert('" + msg + "');"
                    + " history.back();"
                    + "</script>";

            writer.println(script);
        }catch (Exception e){

        }
    }

}