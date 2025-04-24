<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="data_management.DatabaseConnectivity"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Edit Staff Profile</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: #e3f2fd;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }

    .edit-form {
      background-color: white;
      padding: 40px;
      border-radius: 12px;
      box-shadow: 0 8px 16px rgba(0,0,0,0.1);
      width: 400px;
    }

    .edit-form h2 {
      margin-bottom: 20px;
      color: #1565c0;
      text-align: center;
    }

    .edit-form input {
      width: 100%;
      padding: 12px;
      margin: 10px 0;
      border: 1px solid #ccc;
      border-radius: 6px;
      font-size: 14px;
    }

    .edit-form button {
      width: 100%;
      padding: 12px;
      background-color: #1976d2;
      color: white;
      border: none;
      border-radius: 8px;
      font-size: 16px;
      cursor: pointer;
      transition: background-color 0.3s ease;
      margin-top: 10px;
    }

    .edit-form button:hover {
      background-color: #0d47a1;
    }

    .edit-form button:focus {
      outline: none;
    }
  </style>
</head>
<body>

  <form class="edit-form" action="EditMain.jsp" method="post">
    <h2>Edit Staff Details</h2>
    <input type="number" name="id" value="<%=session.getAttribute("id")%>" hidden>
    <input type="text" name="name" placeholder="Candidate Name" value="<%=session.getAttribute("name")%>">
    <input type="email" name="email" placeholder="Candidate Email" value="<%=session.getAttribute("email")%>">
    <input type="tel" name="phno" placeholder="Candidate Phone" value="<%=session.getAttribute("phno")%>">
    <input type="password" name="password" placeholder="Candidate Password" value="<%=session.getAttribute("password")%>">
    <button type="submit">Update</button>
  </form>

  <%
    if(request.getParameter("name")!=null && request.getParameter("email")!=null && 
       request.getParameter("phno")!=null && request.getParameter("password")!=null && 
       request.getMethod().equals("POST")) {

        PrintWriter pw = response.getWriter();
        int staff_id = Integer.parseInt(request.getParameter("id"));
        String staff_name = request.getParameter("name");
        String staff_email = request.getParameter("email");
        long staff_phno = Long.parseLong(request.getParameter("phno"));
        String staff_password = request.getParameter("password");

        Connection conn = DatabaseConnectivity.getConnection();
        PreparedStatement ps = conn.prepareStatement("UPDATE staff SET staff_name=?, staff_email=?, staff_phno=?, staff_password=? WHERE staff_id=?");
        ps.setString(1, staff_name);
        ps.setString(2, staff_email);
        ps.setLong(3, staff_phno);
        ps.setString(4, staff_password);
        ps.setInt(5, staff_id);

        int i = ps.executeUpdate();
        if(i == 1) {
            session.setAttribute("name", staff_name);
            session.setAttribute("email", staff_email);
            session.setAttribute("phno", staff_phno);
            session.setAttribute("password", staff_password);
            RequestDispatcher rd = request.getRequestDispatcher("Profile.jsp");
            rd.forward(request, response);
        } else {
            pw.println("<h4>Edit Unsuccessful</h4>");
            RequestDispatcher rd = request.getRequestDispatcher("Profile.jsp");
            rd.include(request, response);
        }
    }
  %>

</body>
</html>
