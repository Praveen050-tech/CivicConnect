<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%

if(session.getAttribute("admin") == null) {

response.sendRedirect("admin-login.jsp");
return;

}

int total = 0;
int pending = 0;
int progress = 0;
int resolved = 0;

try {

Class.forName("org.h2.Driver");

Connection con = DriverManager.getConnection(
"jdbc:h2:file:D:/CommunityComplaintSystem-main/h2data/community_complaints;AUTO_SERVER=TRUE;MODE=MySQL",
"sa",
""
);

Statement st = con.createStatement();

ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM complaints");
if(rs.next()) total = rs.getInt(1);

rs = st.executeQuery("SELECT COUNT(*) FROM complaints WHERE status='Pending'");
if(rs.next()) pending = rs.getInt(1);

rs = st.executeQuery("SELECT COUNT(*) FROM complaints WHERE status='In Progress'");
if(rs.next()) progress = rs.getInt(1);

rs = st.executeQuery("SELECT COUNT(*) FROM complaints WHERE status='Resolved'");
if(rs.next()) resolved = rs.getInt(1);

con.close();

}
catch(Exception e) {}

%>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">

<title>Admin Dashboard</title>

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

<div class="dashboard">

<h1>Admin Dashboard</h1>

<div class="stats">

<div class="stat">
<h2><%=total%></h2>
<p>Total Complaints</p>
</div>

<div class="stat">
<h2><%=pending%></h2>
<p>Pending</p>
</div>

<div class="stat">
<h2><%=progress%></h2>
<p>In Progress</p>
</div>

<div class="stat">
<h2><%=resolved%></h2>
<p>Resolved</p>
</div>

</div>

<h2>All Complaints</h2>

<table>

<tr>

<th>ID</th>
<th>Category</th>
<th>Location</th>
<th>Status</th>
<th>Assigned To</th>
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

Statement st = con.createStatement();

ResultSet rs = st.executeQuery("SELECT * FROM complaints ORDER BY id DESC");

while(rs.next()) {
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
<%=rs.getString("complaint_id")%>
</td>

<td>
<%=rs.getString("category")%>
</td>

<td>
<%=rs.getString("location")%>
</td>

<td>
<span class="status <%=stClass%>"><%=stVal%></span>
</td>

<td>
<%=rs.getString("assigned_to") == null || rs.getString("assigned_to").trim().isEmpty() ? "Not Assigned" : rs.getString("assigned_to")%>
</td>

<td>

<a class="btn" href="update-status.jsp?id=<%=rs.getInt("id")%>">
Update
</a>

</td>

</tr>

<%

}

con.close();

}
catch(Exception e) {

out.println("<tr><td colspan='6' style='color:red;'>" + e.getMessage() + "</td></tr>");

}

%>

</table>

</div>

</body>

</html>