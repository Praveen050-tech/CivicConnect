<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

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

<title>Submit Complaint</title>

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

<div class="form-container">

<h2>Submit Complaint</h2>

<form method="post" onsubmit="return confirmComplaint()">

<select name="category" required>

<option value="">Select Category</option>

<option>Water Leakage</option>

<option>Street Light</option>

<option>Garbage Collection</option>

<option>Damaged Road</option>

<option>Drainage Problem</option>

<option>Electrical Issue</option>

<option>Fallen Tree</option>

<option>Other</option>

</select>

<input type="text"
name="location"
placeholder="Problem Location"
required>

<textarea name="description"
rows="5"
placeholder="Describe the problem"
required></textarea>

<button type="submit">
Submit Complaint
</button>

</form>

<%

if(request.getMethod().equalsIgnoreCase("POST")) {

String category = request.getParameter("category");
String location = request.getParameter("location");
String description = request.getParameter("description");
int userId = (Integer)session.getAttribute("user_id");

String date = new SimpleDateFormat("yyyyMMdd").format(new Date());
String time = new SimpleDateFormat("HHmmss").format(new Date());
String complaintId = "CMP" + date + time;

try {

Class.forName("org.h2.Driver");

Connection con = DriverManager.getConnection(
"jdbc:h2:file:D:/CommunityComplaintSystem-main/h2data/community_complaints;AUTO_SERVER=TRUE;MODE=MySQL",
"sa",
""
);

PreparedStatement ps = con.prepareStatement(
"INSERT INTO complaints " +
"(complaint_id,user_id,category,location,description,status) " +
"VALUES(?,?,?,?,?,?)"
);

ps.setString(1,complaintId);
ps.setInt(2,userId);
ps.setString(3,category);
ps.setString(4,location);
ps.setString(5,description);
ps.setString(6,"Pending");

ps.executeUpdate();

out.println(
"<div style='margin-top:20px;color:green;text-align:center;'>" +
"<h3>Complaint Submitted Successfully!</h3>" +
"<p>Your Complaint ID:</p>" +
"<h2>" + complaintId + "</h2>" +
"<p>Status: Pending</p>" +
"<p style='margin-top:15px;'><a href='mycomplaints.jsp' class='btn'>View My Complaints</a></p>" +
"</div>"
);

con.close();

}
catch(Exception e) {

out.println(
"<p style='color:red;text-align:center;margin-top:15px;'>"
+"Error: "+e.getMessage()+
"</p>"
);

}

}

%>

</div>

<script src="js/script.js"></script>

</body>

</html>