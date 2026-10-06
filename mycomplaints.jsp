<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%

if(session.getAttribute("user_id") == null) {

response.sendRedirect("login.jsp");
return;

}

int userId = (Integer)session.getAttribute("user_id");

%>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">

<title>My Complaints</title>

<link rel="stylesheet" href="css/style.css">

</head>

<body>

<nav>

<h2>&#127969; CivicConnect</h2>

<div>
<a href="citizen-dashboard.jsp">Dashboard</a>
<a href="complaint.jsp">New Complaint</a>
<a href="feedback.jsp">Feedback</a>
<a href="logout.jsp" class="btn-danger" style="padding: 6px 12px; border-radius: 5px;">Logout</a>
</div>

</nav>

<div class="dashboard">

<h1>My Complaints</h1>

<table>

<tr>

<th>Complaint ID</th>
<th>Category</th>
<th>Location</th>
<th>Description</th>
<th>Status</th>
<th>Action</th>

</tr>

<%

try {

Class.forName("org.h2.Driver");

Connection con = DriverManager.getConnection(
"jdbc:h2:file:D:/CommunityComplaintSystem-main/h2data/community_complaints;AUTO_SERVER=TRUE;MODE=MySQL",
"sa",
""
);

PreparedStatement ps = con.prepareStatement(
"SELECT * FROM complaints WHERE user_id=? ORDER BY id DESC"
);

ps.setInt(1,userId);

ResultSet rs = ps.executeQuery();

while(rs.next()) {
    String cmpId = rs.getString("complaint_id");
    String stVal = rs.getString("status");
    String stClass = "status-pending";
    if ("In Progress".equalsIgnoreCase(stVal)) {
        stClass = "status-in-progress";
    } else if ("Resolved".equalsIgnoreCase(stVal)) {
        stClass = "status-resolved";
    }

%>

<tr>

<td>
<%=cmpId%>
</td>

<td>
<%=rs.getString("category")%>
</td>

<td>
<%=rs.getString("location")%>
</td>

<td>
<%=rs.getString("description")%>
</td>

<td>

<span class="status <%=stClass%>">

<%=stVal%>

</span>

</td>

<td>
<a class="btn" href="feedback.jsp?complaint_id=<%=cmpId%>" style="padding: 6px 12px; font-size: 12px;">Feedback</a>
</td>

</tr>

<%

}

con.close();

}
catch(Exception e) {

out.println(
"<tr><td colspan='6' style='color:red;'>"
+e.getMessage()+
"</td></tr>"
);

}

%>

</table>

</div>

</body>

</html>