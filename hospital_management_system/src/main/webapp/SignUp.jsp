<%@page import="java.sql.PreparedStatement"%>
<%@page import="data_management.DatabaseConnectivity"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Staff Sign Up Page</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: linear-gradient(to right, #e0f2f1, #ffffff);
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }

    .signup-box {
      background-color: #ffffff;
      padding: 40px 30px;
      border-radius: 12px;
      box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
      width: 400px;
    }

    .signup-box h2 {
      text-align: center;
      color: #00695c;
      margin-bottom: 25px;
    }

    input[type="text"],
    input[type="email"],
    input[type="tel"],
    input[type="password"] {
      width: 100%;
      padding: 12px;
      margin-bottom: 20px;
      border: 1px solid #b2dfdb;
      border-radius: 6px;
      font-size: 15px;
      transition: 0.3s ease;
    }

    input:focus {
      border-color: #26a69a;
      box-shadow: 0 0 5px rgba(38, 166, 154, 0.3);
      outline: none;
    }

    button {
      width: 100%;
      padding: 12px;
      background-color: #00796b;
      color: white;
      font-size: 16px;
      border: none;
      border-radius: 6px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    button:hover {
      background-color: #004d40;
    }

    .error-message {
      color: red;
      text-align: center;
      margin-bottom: 20px;
      font-weight: bold;
    }
  </style>
</head>
<body>

  <div class="signup-box">
    <h2>Staff Sign Up</h2>

    <% 
      String error = (String) session.getAttribute("error");
      if (error != null) {
    %>
      <div class="error-message">Error: <%= error %></div>
    <%
        session.removeAttribute("error"); // clear after showing
      } 
    %>

    <form action="SignUp.jsp" method="post">
      <input type="text" name="name" placeholder="Candidate Name" required> 
      <input type="email" name="email" placeholder="Candidate Email" required> 
      <input type="tel" name="phno" placeholder="Candidate Phone Number" required> 
      <input type="password" name="password" placeholder="Candidate Password" required> 	
      <button type="submit">Register</button>
    </form>
  </div>

<%
  if(request.getParameter("name") != null &&
     request.getParameter("email") != null &&
     request.getParameter("phno") != null &&
     request.getParameter("password") != null &&
     request.getMethod().equals("POST")) {

    String staff_name = request.getParameter("name");
    String staff_email = request.getParameter("email");
    long staff_phno = Long.parseLong(request.getParameter("phno"));
    String staff_password = request.getParameter("password");

    try {
      Connection conn = DatabaseConnectivity.getConnection();
      PreparedStatement ps = conn.prepareStatement("INSERT INTO staff VALUES (staff_id, ?, ?, ?, ?)");
      ps.setString(1, staff_name);
      ps.setString(2, staff_email);
      ps.setLong(3, staff_phno);
      ps.setString(4, staff_password);

      int i = ps.executeUpdate();
      if(i == 1) {
        RequestDispatcher rd = request.getRequestDispatcher("Login.html");
        rd.forward(request, response);
      } else {
        session.setAttribute("error", "Database problem! Contact Developer");
        response.sendRedirect("SignUp.jsp");
      }
    } catch (Exception e) {
      session.setAttribute("error", "Exception occurred: " + e.getMessage());
      response.sendRedirect("SignUp.jsp");
    }
  }
%>

</body>
</html>
