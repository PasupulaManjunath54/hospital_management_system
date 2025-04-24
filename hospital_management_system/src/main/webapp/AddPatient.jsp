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
  <title>Add Patient</title>
  <style>
    body {
      background-color: #f2f9ff;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
    }

    .form-container {
      background-color: #ffffff;
      padding: 40px;
      border-radius: 12px;
      box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
      width: 400px;
    }

    .form-container h2 {
      text-align: center;
      color: #0077b6;
      margin-bottom: 20px;
    }

    .form-container input {
      width: 100%;
      padding: 12px;
      margin: 10px 0;
      border: 1px solid #cce0f5;
      border-radius: 8px;
      font-size: 14px;
    }

    .form-container button {
      width: 100%;
      padding: 12px;
      background-color: #00b4d8;
      border: none;
      border-radius: 8px;
      color: white;
      font-size: 16px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    .form-container button:hover {
      background-color: #0077b6;
    }
  </style>
</head>
<body>
  <div class="form-container">
    <h2>Add Patient</h2>
    <form action="AddPatient.jsp" method="post">
      <input type="number" name="id" placeholder="Patient ID" required>
      <input type="text" name="name" placeholder="Patient Name" required>
      <input type="number" name="age" placeholder="Patient Age" required>
      <input type="text" name="problem" placeholder="Patient Problem / Speciality" required>
      <button type="submit">Submit</button>
    </form>
  </div>

  <%
    if(request.getParameter("id")!=null && request.getParameter("name")!=null && request.getParameter("age")!=null && request.getParameter("problem")!=null && request.getMethod().equals("POST"))
    {
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
        PreparedStatement patient_ps = conn.prepareStatement("insert into patient values(?,?,?,?,?)");
        patient_ps.setInt(1, patientId);
        patient_ps.setString(2, patientName);
        patient_ps.setInt(3, patientAge);
        patient_ps.setString(4, patientProblem);
        patient_ps.setInt(5, doctorId);
        int insertedCount = patient_ps.executeUpdate();

        if(insertedCount == 1) {
          pw.println("<script>alert('Patient data inserted successfully');</script>");
        } else {
          pw.println("<script>alert('Patient data insertion unsuccessful');</script>");
        }
      } else {
        pw.println("<script>alert('Doctor not found for the given speciality');</script>");
      }
    }
  %>
</body>
</html>
