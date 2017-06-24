<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page language="java" import="java.sql.*" %>

<html>
 <head>
   <meta charset="utf-8">
   <title>목록</title>
 </head>
 <body>
   <h1>목록</h1>

  <a href="write.html">글쓰기</a>
   <%

  Class.forName("com.mysql.jdbc.Driver"); //동적로딩 기술.
   String url = "jdbc:mysql://127.0.0.1:3306/bbs";
  
   //커넥션이 열림
                                               //db주소, userid, password
   Connection con = DriverManager.getConnection(url, "root", "root");

  Statement stmt = con.createStatement();
   String query = "select * from board";
   //마치 안드로이드의 컨텐츠리졸버 처럼 동작함.
   ResultSet cursor = stmt.executeQuery(query);
   while(cursor.next()){
     int id = cursor.getInt("id");
     String title = cursor.getString("title");
     String author = cursor.getString("author");
     String content = cursor.getString("content");
     String date = cursor.getString("date");

    out.print(id + "|" + title + "|"  + author + "|" + content + "|" + date + "<br/>");
   }
   con.close();

  %>
 </body>
</html>
