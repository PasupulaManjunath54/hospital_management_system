<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="data_management.DatabaseConnectivity"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.PrintWriter"%>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Update Patient</title>
  <style>
    body {
      background-color: #e8f4fa;
      font-family: 'Segoe UI', sans-serif;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
    }

    .form-box {
      background-color: white;
      padding: 40px;
      border-radius: 12px;
      box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
      width: 400px;
    }

    .form-box h2 {
      text-align: center;
      color: #0077b6;
      margin-bottom: 20px;
    }

    .form-box input {
      width: 100%;
      padding: 12px;
      margin: 10px 0;
      border-radius: 8px;
      border: 1px solid #ccc;
      font-size: 14px;
    }

    .form-box button {
      width: 100%;
      padding: 12px;
      background-color: #00b4d8;
      color: white;
      font-size: 16px;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      transition: 0.3s ease;
    }

    .form-box button:hover {
      background-color: #0077b6;
    }
  </style>
</head>
<body>
  <div class="form-box">
    <h2>Update Patient</h2>
    <form action="UpdatePatient.jsp" method="post">
      <input type="number" name="id" placeholder="Patient ID" required>
      <input type="text" name="name" placeholder="Patient Name" required>
      <input type="number" name="age" placeholder="Patient Age" required>
      <input type="text" name="problem" placeholder="Patient Problem / Speciality" required>
      <button type="submit">Update</button>
    </form>
  </div>

  <%
    if(request.getParameter("id")!=null && request.getMethod().equals("POST")) {
      int patientId = Integer.parseInt(request.getParameter("id"));
      String patientName = request.getParameter("name");
      int patientAge = Integer.parseInt(request.getParameter("age"));
      String patientProblem = request.getParameter("problem");

      Connection conn = DatabaseConnectivity.getConnection();
      PrintWriter pw = response.getWriter();

      PreparedStatement ps = conn.prepareStatement("select iddoctor from doctor where doctorspeciality = ?");
      ps.setString(1, patientProblem);
      ResultSet rs = ps.executeQuery();

      if(rs.next()) {
        int doctorId = rs.getInt(1);
        PreparedStatement patient_ps = conn.prepareStatement("update patient set patientname=?, patientage=?, patientproblem=?, iddoctor=? where idpatient=?");
        patient_ps.setString(1, patientName);
        patient_ps.setInt(2, patientAge);
        patient_ps.setString(3, patientProblem);
        patient_ps.setInt(4, doctorId);
        patient_ps.setInt(5, patientId);

        int updationCount = patient_ps.executeUpdate();
        if(updationCount == 1) {
          pw.println("<script>alert('Patient data updated successfully');</script>");
        } else {
          pw.println("<script>alert('Patient data update unsuccessful');</script>");
        }
      } else {
        pw.println("<script>alert('No matching doctor found');</script>");
      }
    }
  %>
</body>
</html>
