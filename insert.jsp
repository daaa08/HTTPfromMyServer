<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page language = "java" import="java.sql.*" %>
<%
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String content = request.getParameter("content");

        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://127.0.0.1:3306/Bbs?useUnicode=true&characterEncoding=utf8";   // mac 한글 변환
        Connection con = DriverManager.getConnection(url,"root","root");

        String query = "insert into board(title,author,content,date) value(?,?,?,now())";
        PreparedStatement stmt = con.prepareStatement(query);
        stmt.setString(1,title);
        stmt.setString(2,author);
        stmt.setString(3,content);
        stmt.executeUpdate();

       con.close();
%>
<h1>
성공적으로 입력 되었습니다.
</h1>
<a href="/Bbs/index.jsp">목록으로</a>
