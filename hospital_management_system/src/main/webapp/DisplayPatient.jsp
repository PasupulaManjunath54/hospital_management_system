<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="data_management.DatabaseConnectivity"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Display Patient</title>
<style>
  body {
    font-family: 'Segoe UI', sans-serif;
    background-color: #f0f4f8;
    margin: 0;
    padding: 0;
    display: flex;
    justify-content: center;
    align-items: flex-start;
    min-height: 100vh;
  }

  .container {
    margin-top: 50px;
    background-color: #ffffff;
    padding: 40px;
    border-radius: 12px;
    box-shadow: 0px 10px 30px rgba(0, 0, 0, 0.1);
    width: 500px;
    text-align: center;
  }

  input {
    width: 80%;
    padding: 12px;
    margin: 12px 0;
    border: 1px solid #ccc;
    border-radius: 8px;
    font-size: 14px;
  }

  button {
    padding: 12px 20px;
    background-color: #1976d2;
    color: white;
    border: none;
    border-radius: 8px;
    font-size: 16px;
    cursor: pointer;
    margin-top: 10px;
  }

  button:hover {
    background-color: #155aa8;
  }

  .patient-info {
    margin-top: 30px;
    text-align: left;
  }

  .patient-info h2 {
    color: #333;
    margin-bottom: 10px;
  }

  .not-found {
    color: red;
    font-weight: bold;
    margin-top: 20px;
  }
</style>
</head>
<body>
  <div class="container">
    <h1>Search Patient Record</h1>
    <form action="DisplayPatient.jsp" method="get">
      <input type="number" name="id" placeholder="Patient ID" value="" required><br>
      <button type="submit">Submit</button>
    </form>

    <%
      if(request.getParameter("id")!=null && request.getMethod().equals("GET")) {
        int patient_Id = Integer.parseInt(request.getParameter("id"));
        Connection conn = DatabaseConnectivity.getConnection();
        PreparedStatement ps = conn.prepareStatement("select * from patient where idpatient=?");
        ps.setInt(1, patient_Id);
        ResultSet rs = ps.executeQuery();

        if(rs.next()) {
    %>
          <div class="patient-info">
            <h2>Patient Name: <%= rs.getString(2) %></h2>
            <h2>Patient Age: <%= rs.getInt(3) %></h2>
            <h2>Patient Disease: <%= rs.getString(4) %></h2>
            <h2>Doctor ID: <%= rs.getInt(5) %></h2>
          </div>
    <%
        } else {
    %>
          <p class="not-found">Data not found!</p>
    <%
        }
      }
    %>
  </div>
</body>
</html>
