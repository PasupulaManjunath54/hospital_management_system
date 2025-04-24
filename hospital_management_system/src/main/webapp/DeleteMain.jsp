<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="data_management.DatabaseConnectivity"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.PrintWriter"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Delete Staff Record</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      background-color: #f0f4f8;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }

    .delete-box {
      background: white;
      padding: 40px;
      border-radius: 12px;
      box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
      text-align: center;
      width: 400px;
    }

    .delete-box h1 {
      color: #d32f2f;
      margin-bottom: 20px;
    }

    .delete-box button {
      padding: 12px 24px;
      font-size: 16px;
      color: white;
      background-color: #d32f2f;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    .delete-box button:hover {
      background-color: #b71c1c;
    }
  </style>
</head>
<body>

  <form class="delete-box" action="DeleteMain.jsp" method="post">
    <input type="number" name="id" value="<%=session.getAttribute("id")%>" hidden>
    <h1>Are you sure you want to delete this account?</h1>
    <button type="submit">Yes, Delete</button>
  </form>

  <%
    if(request.getParameter("id") != null && request.getMethod().equals("POST")) {
      PrintWriter pw = response.getWriter();
      int id = Integer.parseInt(request.getParameter("id"));
      Connection conn = DatabaseConnectivity.getConnection();
      PreparedStatement ps = conn.prepareStatement("DELETE FROM staff WHERE staff_id=?");
      ps.setInt(1, id);
      int i = ps.executeUpdate();
      if(i == 1) {
        RequestDispatcher rd = request.getRequestDispatcher("index.html");
        rd.forward(request, response);
      } else {
        pw.println("<h4>Deletion Unsuccessful</h4>");
        RequestDispatcher rd = request.getRequestDispatcher("Profile.jsp");
        rd.include(request, response);
      }
    }
  %>

</body>
</html>
