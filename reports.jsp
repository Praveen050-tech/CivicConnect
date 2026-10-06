<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
if(session.getAttribute("admin") == null) {
    response.sendRedirect("admin-login.jsp");
    return;
}
%>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">

<title>Complaint Reports</title>

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

<h1>Complaint Reports &#128202;</h1>

<table>

<tr>

<th>Category</th>

<th>Total Complaints</th>

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

ResultSet rs = st.executeQuery(
"SELECT category, COUNT(*) AS total FROM complaints GROUP BY category"
);

while(rs.next()) {

%>

<tr>

<td>
<%=rs.getString("category")%>
</td>

<td>
<%=rs.getInt("total")%>
</td>

</tr>

<%

}

con.close();

}
catch(Exception e) {

out.println("<tr><td colspan='2' style='color:red;'>" + e.getMessage() + "</td></tr>");

}

%>

</table>

</div>

</body>

</html>