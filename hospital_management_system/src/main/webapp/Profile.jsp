<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Staff Profile</title>
  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: #e0f7fa;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }

    .profile-card {
      background-color: white;
      padding: 40px;
      border-radius: 12px;
      box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
      width: 400px;
      text-align: center;
    }

    .profile-card h1 {
      color: #00695c;
      font-size: 20px;
      margin-bottom: 15px;
    }

    .profile-card h1 span {
      color: #333;
      font-weight: normal;
    }

    .profile-card .actions {
      margin-top: 30px;
      display: flex;
      flex-direction: column;
      gap: 10px;
    }

    .profile-card a button {
      padding: 12px;
      background-color: #00897b;
      color: white;
      border: none;
      border-radius: 8px;
      font-size: 16px;
      cursor: pointer;
      transition: background-color 0.3s ease;
      width: 100%;
    }

    .profile-card a button:hover {
      background-color: #00695c;
    }
  </style>
</head>
<body>

  <div class="profile-card">
    <h1>Name: <span><%= session.getAttribute("name") %></span></h1>
    <h1>Email: <span><%= session.getAttribute("email") %></span></h1>
    <h1>Phone: <span><%= session.getAttribute("phno") %></span></h1>
    <h1>Password: <span><%= session.getAttribute("password") %></span></h1>

    <div class="actions">
      <a href="HomePage.jsp"><button>🏠 Home</button></a>
      <a href="EditMain.jsp"><button>✏️ Edit Profile</button></a>
      <a href="DeleteMain.jsp"><button>🗑️ Delete Profile</button></a>
    </div>
  </div>

</body>
</html>
