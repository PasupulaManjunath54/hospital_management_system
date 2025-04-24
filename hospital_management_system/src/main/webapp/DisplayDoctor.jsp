<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="data_management.DatabaseConnectivity"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Doctor Data</title>
<style>
    body {
        background-color: #f4f6f8;
        font-family: Arial, sans-serif;
        display: flex;
        flex-direction: column;
        align-items: center;
        padding-top: 60px;
    }

    form {
        background-color: #ffffff;
        padding: 30px;
        border-radius: 12px;
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
        width: 320px;
        margin-bottom: 30px;
    }

    input[type="number"] {
        width: 100%;
        padding: 12px;
        margin: 10px 0;
        border: 1px solid #ccc;
        border-radius: 8px;
        font-size: 14px;
    }

    button {
        width: 100%;
        background-color: #1976d2;
        color: white;
        padding: 12px;
        border: none;
        border-radius: 8px;
        font-size: 16px;
        cursor: pointer;
        margin-top: 10px;
    }

    button:hover {
        background-color: #145ea8;
    }

    .doctor-info {
        background-color: #ffffff;
        padding: 20px;
        border-radius: 12px;
        box-shadow: 0 6px 14px rgba(0, 0, 0, 0.1);
        width: 350px;
        text-align: left;
    }

    .doctor-info h1 {
        font-size: 20px;
        color: #333;
        margin: 10px 0;
    }

    .error-message {
        color: red;
        font-size: 18px;
        margin-top: 20px;
    }
</style>
</head>
<body>
    <form action="DisplayDoctor.jsp" method="get">
        <input type="number" placeholder="Enter Doctor ID" name="doctorId" value=""><br>
        <button>Display Doctor</button>
    </form>

    <%
        if(request.getParameter("doctorId") != null && request.getMethod().equals("GET")) {
            int id = Integer.parseInt(request.getParameter("doctorId"));
            PrintWriter pw = response.getWriter();
            Connection conn = DatabaseConnectivity.getConnection();
            PreparedStatement ps = conn.prepareStatement("select * from doctor where iddoctor=?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                pw.println("<div class='doctor-info'>");
                pw.println("<h1>Name: " + rs.getString(2) + "</h1>");
                pw.println("<h1>Specialist: " + rs.getString(3) + "</h1>");
                pw.println("<h1>Salary: ₹" + rs.getInt(4) + "</h1>");
                pw.println("<h1>Phone: " + rs.getLong(5) + "</h1>");
                pw.println("</div>");
            } else {
                pw.println("<div class='error-message'>Invalid Doctor ID!!!</div>");
            }
        }
    %>
</body>
</html>
