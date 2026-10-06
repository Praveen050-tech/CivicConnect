<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
if(session.getAttribute("user_id") == null) {
    response.sendRedirect("login.jsp");
    return;
}
String prefilledCid = request.getParameter("complaint_id");
if (prefilledCid == null) prefilledCid = "";
%>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">

<title>Feedback</title>

<link rel="stylesheet" href="css/style.css">

</head>

<body>

<nav>

<h2>&#127969; CivicConnect</h2>

<div>
<a href="citizen-dashboard.jsp">Dashboard</a>
<a href="complaint.jsp">New Complaint</a>
<a href="mycomplaints.jsp">My Complaints</a>
<a href="logout.jsp" class="btn-danger" style="padding: 6px 12px; border-radius: 5px;">Logout</a>
</div>

</nav>

<div class="form-container">

<h2>Complaint Feedback</h2>

<form method="post">

<input type="text"
name="complaint_id"
placeholder="Complaint ID (e.g. CMP20261006...)"
value="<%= prefilledCid %>"
required>

<select name="rating">

<option value="5">&#11088;&#11088;&#11088;&#11088;&#11088; Excellent</option>

<option value="4">&#11088;&#11088;&#11088;&#11088; Good</option>

<option value="3">&#11088;&#11088;&#11088; Average</option>

<option value="2">&#11088;&#11088; Poor</option>

<option value="1">&#11088; Very Poor</option>

</select>

<textarea name="comments"
placeholder="Your comments"
rows="5"></textarea>

<button type="submit">
Submit Feedback
</button>

</form>

<%

if(request.getMethod().equalsIgnoreCase("POST")) {

String cid = request.getParameter("complaint_id");
int rating = Integer.parseInt(request.getParameter("rating"));
String comments = request.getParameter("comments");

try {

Class.forName("org.h2.Driver");

Connection con = DriverManager.getConnection(
"jdbc:h2:file:D:/CommunityComplaintSystem-main/h2data/community_complaints;AUTO_SERVER=TRUE;MODE=MySQL",
"sa",
""
);

PreparedStatement ps = con.prepareStatement(
"INSERT INTO feedback (complaint_id,rating,comments) VALUES(?,?,?)"
);

ps.setString(1,cid);
ps.setInt(2,rating);
ps.setString(3,comments);

ps.executeUpdate();

out.println(
"<p style='color:green; text-align:center; margin-top:15px;'>" +
"Thank you for your feedback! &#11088;" +
"</p>"
);

con.close();

}
catch(Exception e) {

out.println(
"<p style='color:red; text-align:center; margin-top:15px;'>"
+"Error: "+e.getMessage()+
"</p>"
);

}

}

%>

</div>

</body>

</html>