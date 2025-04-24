<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="data_management.DatabaseConnectivity"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Patient</title>
<style>
  body {
    background-color: #f2f7fa;
    font-family: 'Segoe UI', sans-serif;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
  }

  .form-box {
    background: #fff;
    padding: 40px;
    border-radius: 12px;
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
    width: 400px;
    text-align: center;
  }

  .form-box h2 {
    color: #e63946;
    margin-bottom: 20px;
  }

  .form-box input {
    width: 100%;
    padding: 12px;
    margin: 12px 0;
    border-radius: 8px;
    border: 1px solid #ccc;
    font-size: 14px;
  }

  .form-box button {
    width: 100%;
    padding: 12px;
    background-color: #e63946;
    color: white;
    font-size: 16px;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: background 0.3s ease;
  }

  .form-box button:hover {
    background-color: #c91832;
  }

  .form-box p {
    margin-top: 20px;
    font-weight: bold;
  }
</style>
</head>
<body>
  <div class="form-box">
    <h2>Delete Patient Record</h2>
    <form action="DeletePatient.jsp" method="get">
      <input type="text" name="patientId" placeholder="Enter Patient ID" required><br>
      <button type="submit">Delete Patient</button>
    </form>
    <%
      if(request.getParameter("patientId")!=null && request.getMethod().equals("GET")) {
        PrintWriter pw = response.getWriter();
        int id = Integer.parseInt(request.getParameter("patientId"));
        Connection conn = DatabaseConnectivity.getConnection();
        PreparedStatement ps  = conn.prepareStatement("delete from patient where idpatient=?");
        ps.setInt(1, id);
        int deletedCount = ps.executeUpdate();
        if(deletedCount == 1) {
          pw.println("<p style='color:green;'>Deletion of patient successful.</p>");
        } else {
          pw.println("<p style='color:red;'>Deletion of patient unsuccessful.</p>");
        }
      }
    %>
  </div>
</body>
</html>
