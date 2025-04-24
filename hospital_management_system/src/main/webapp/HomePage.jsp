<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Staff Dashboard</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: #f0f9f9;
    }

    nav {
      background-color: #00695c;
      color: white;
      padding: 15px 30px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      border-bottom: 4px solid #004d40;
    }

    nav h1 {
      margin: 0;
      font-size: 22px;
    }

    nav form button {
      background-color: #d32f2f;
      color: white;
      border: none;
      padding: 10px 15px;
      font-size: 14px;
      border-radius: 6px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    nav form button:hover {
      background-color: #b71c1c;
    }

    .container {
      max-width: 600px;
      margin: 40px auto;
      display: flex;
      flex-direction: column;
      gap: 15px;
    }

    .container a, .container form {
      display: block;
    }

    .container button {
      width: 100%;
      background-color: #00897b;
      color: white;
      border: none;
      padding: 12px;
      font-size: 16px;
      border-radius: 8px;
      cursor: pointer;
      transition: background-color 0.3s ease;
    }

    .container button:hover {
      background-color: #00695c;
    }

    .container button:focus {
      outline: none;
    }
  </style>
</head>
<body>

  <nav>
    <h1>Welcome, <%= session.getAttribute("name") %></h1>
    <form action="logout" method="get">
      <button type="submit">LOG OUT</button>
    </form>
  </nav>

  <div class="container">
    <a href="Profile.jsp"><button>View Profile</button></a>
    <a href="AddPatient.jsp"><button>Add Patient</button></a>
    <a href="UpdatePatient.jsp"><button>Update Patient</button></a>
    <a href="DeletePatient.jsp"><button>Remove Patient</button></a>
    <a href="DisplayPatient.jsp"><button>Display Patient</button></a>
    <form action="DisplayAllPatients" method="get">
      <button>Display All Patients</button>
    </form>
    <a href="AddDoctor.jsp"><button>Add Doctor</button></a>
    <a href="DisplayDoctor.jsp"><button>Display Doctor</button></a>
    <form action="DisplayAllDoctors" method="get">
      <button>Display All Doctors</button>
    </form>
  </div>

</body>
</html>
