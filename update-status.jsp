<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%

if(session.getAttribute("admin") == null) {

response.sendRedirect("admin-login.jsp");
return;

}

int id = 0;
try {
    id = Integer.parseInt(request.getParameter("id"));
} catch(Exception e) {
    response.sendRedirect("admin-dashboard.jsp");
    return;
}

%>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">

<title>Update Complaint</title>

<link rel="stylesheet" href="css/style.css">

</head>

<body>

<nav>

<h2>&#127969; CivicConnect Admin</h2>

<div>
<a href="admin-dashboard.jsp">Dashboard</a>
<a href="reports.jsp">Reports</a>
<a href="logout.jsp" class="btn-danger" style="padding: 6px 12px; border-radius: 5px;">Logout</a>
</div>

</nav>

<div class="form-container">

<h2>Update Complaint</h2>

<form method="post">

<select name="status">

<option value="Pending">Pending</option>

<option value="In Progress">In Progress</option>

<option value="Resolved">Resolved</option>

</select>

<input type="text"
name="assigned_to"
placeholder="Assigned Worker / Officer">

<button type="submit">
Update Complaint
</button>

</form>

<%

if(request.getMethod().equalsIgnoreCase("POST")) {

String status = request.getParameter("status");
String assigned = request.getParameter("assigned_to");

try {

Class.forName("org.h2.Driver");

Connection con = DriverManager.getConnection(
"jdbc:h2:file:D:/CommunityComplaintSystem-main/h2data/community_complaints;AUTO_SERVER=TRUE;MODE=MySQL",
"sa",
""
);

PreparedStatement ps = con.prepareStatement(
"UPDATE complaints SET status=?, assigned_to=? WHERE id=?"
);

ps.setString(1,status);
ps.setString(2,assigned);
ps.setInt(3,id);

ps.executeUpdate();

out.println(
"<p style='color:green; text-align:center; margin-top:15px;'>" +
"Complaint updated successfully!" +
"</p>" +
"<p style='text-align:center; margin-top:15px;'><a href='admin-dashboard.jsp' class='btn'>Back to Dashboard</a></p>"
);

con.close();

}
catch(Exception e) {

out.println(
"<p style='color:red; text-align:center; margin-top:15px;'>"
+e.getMessage()+
"</p>"
);

}

}

%>

</div>

</body>

</html>