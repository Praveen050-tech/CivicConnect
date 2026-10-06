<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%

if(session.getAttribute("user_id") == null) {

response.sendRedirect("login.jsp");
return;

}

%>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">

<title>Citizen Dashboard</title>

<link rel="stylesheet" href="css/style.css">

</head>

<body>

<nav>

<h2>&#127969; CivicConnect</h2>

<div>

<a href="citizen-dashboard.jsp">Dashboard</a>

<a href="complaint.jsp">New Complaint</a>

<a href="mycomplaints.jsp">My Complaints</a>

<a href="feedback.jsp">Feedback</a>

<a href="logout.jsp" class="btn-danger" style="padding: 6px 12px; border-radius: 5px;">Logout</a>

</div>

</nav>

<div class="dashboard">

<h1>
Welcome, <%= session.getAttribute("user_name") != null ? session.getAttribute("user_name") : "Citizen" %> &#128075;
</h1>

<div class="stats">

<div class="stat">

<h2>&#128226;</h2>

<h3>Report Problem</h3>

<p>Submit a new complaint.</p>

<a href="complaint.jsp" class="btn">Submit</a>

</div>

<div class="stat">

<h2>&#128269;</h2>

<h3>Track Complaint</h3>

<p>Check your complaint status.</p>

<a href="mycomplaints.jsp" class="btn">Track</a>

</div>

<div class="stat">

<h2>&#11088;</h2>

<h3>Feedback</h3>

<p>Give feedback for resolved complaints.</p>

<a href="feedback.jsp" class="btn">Feedback</a>

</div>

</div>

</div>

</body>

</html>