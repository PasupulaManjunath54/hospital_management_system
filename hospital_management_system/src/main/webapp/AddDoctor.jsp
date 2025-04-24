<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="data_management.DatabaseConnectivity"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Adding Doctor</title>
<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f4f6f8;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }

    form {
        background-color: #ffffff;
        padding: 30px;
        border-radius: 12px;
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        width: 350px;
        text-align: center;
    }

    input[type="number"],
    input[type="text"] {
        width: 100%;
        padding: 12px;
        margin: 10px 0;
        border: 1px solid #ccc;
        border-radius: 8px;
        box-sizing: border-box;
        font-size: 14px;
    }

    button {
        width: 100%;
        background-color: #1976d2;
        color: white;
        padding: 12px;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        font-size: 16px;
        margin-top: 10px;
    }

    button:hover {
        background-color: #145ea8;
    }
</style>
</head>
<body>
	<form action="AddDoctor.jsp" method="post">
	 	<input type="number" placeholder="Doctor ID" name="id" value=""><br>
        <input type="text" placeholder="Doctor Name" name="name" value=""><br>
        <input type="text" placeholder="Specialist" name="specialist" value=""><br>
        <input type="number" placeholder="Salary" name="salary" value=""><br>
        <input type="number" placeholder="Phone Number" name="phno" value=""><br>
        <button>Submit</button>
	</form>

	<%
		if(request.getParameter("id")!=null && request.getParameter("name")!=null && 
		   request.getParameter("specialist")!=null && request.getParameter("salary")!=null && 
		   request.getParameter("phno")!=null && request.getMethod().equals("POST"))
		{
			int doctor_id = Integer.parseInt(request.getParameter("id"));
			String doctor_name = request.getParameter("name");
			String doctor_specialist = request.getParameter("specialist");
			int doctor_salary = Integer.parseInt(request.getParameter("salary"));
			long doctor_phno = Long.parseLong(request.getParameter("phno"));

			Connection conn = DatabaseConnectivity.getConnection();
			PrintWriter pw = response.getWriter();
			PreparedStatement ps = conn.prepareStatement("insert into doctor values(?,?,?,?,?)");
			ps.setInt(1, doctor_id);
			ps.setString(2, doctor_name);
			ps.setString(3, doctor_specialist);
			ps.setInt(4, doctor_salary);
			ps.setLong(5, doctor_phno);

			int i = ps.executeUpdate();
			if(i==1) {
				pw.println("<h3 style='color: green; text-align: center;'>Doctor data insertion successful</h3>");
			} else {
				pw.println("<h3 style='color: red; text-align: center;'>Doctor data insertion unsuccessful</h3>");
			}
		}
	%>
</body>
</html>
