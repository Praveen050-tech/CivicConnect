<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
if(session.getAttribute("user_id") != null) {
    response.sendRedirect("citizen-dashboard.jsp");
    return;
}
%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<title>Citizen Login</title>

<link rel="stylesheet" href="css/style.css">

</head>

<body>

<nav>

<h2>&#127969; CivicConnect</h2>

<div>
    <a href="index.html">Home</a>
    <a href="admin-login.jsp">Admin Login</a>
</div>

</nav>

<div class="form-container">

<h2>Citizen Login</h2>

<form method="post">

<input type="email"
       name="email"
       placeholder="Email"
       required>

<input type="password"
       name="password"
       placeholder="Password"
       required>

<button type="submit">
Login
</button>

</form>

<%

if(request.getMethod().equalsIgnoreCase("POST")) {

String email = request.getParameter("email");
String password = request.getParameter("password");

try {

Class.forName("org.h2.Driver");

Connection con = DriverManager.getConnection(
"jdbc:h2:file:D:/CommunityComplaintSystem-main/h2data/community_complaints;AUTO_SERVER=TRUE;MODE=MySQL",
"sa",
""
);

PreparedStatement ps = con.prepareStatement(
"SELECT * FROM users WHERE email=? AND password=? AND role='citizen'"
);

ps.setString(1,email);
ps.setString(2,password);

ResultSet rs = ps.executeQuery();

if(rs.next()) {

session.setAttribute("user_id", rs.getInt("id"));
session.setAttribute("user_name", rs.getString("name"));

response.sendRedirect("citizen-dashboard.jsp");
return;

}
else {

out.println("<p style='color:red; text-align:center; margin-top:15px;'>Invalid login details</p>");

}

con.close();

}
catch(Exception e) {

out.println("<p style='color:red; text-align:center; margin-top:15px;'>Error: " + e.getMessage() + "</p>");

}

}

%>

<p style="text-align:center; margin-top:15px;">
New user?
<a href="register.jsp">Register</a>
</p>

</div>

</body>
</html>