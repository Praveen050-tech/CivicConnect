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
<title>Citizen Registration</title>
<link rel="stylesheet" href="css/style.css">
</head>

<body>

<nav>
<h2>&#127969; CivicConnect</h2>
<div>
<a href="index.html">Home</a>
<a href="login.jsp">Login</a>
</div>
</nav>

<div class="form-container">

<h2>Citizen Registration</h2>

<form method="post" onsubmit="return validateForm()">

<input type="text"
       id="name"
       name="name"
       placeholder="Full Name"
       required>

<input type="email"
       id="email"
       name="email"
       placeholder="Email"
       required>

<input type="text"
       name="phone"
       placeholder="Phone Number"
       required>

<input type="password"
       name="password"
       placeholder="Password"
       required>

<button type="submit">
Register
</button>

</form>

<%
if(request.getMethod().equalsIgnoreCase("POST")) {

    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String password = request.getParameter("password");

    try {

        Class.forName("org.h2.Driver");

        Connection con = DriverManager.getConnection(
            "jdbc:h2:file:D:/CommunityComplaintSystem-main/h2data/community_complaints;AUTO_SERVER=TRUE;MODE=MySQL",
            "sa",
            ""
        );

        PreparedStatement ps = con.prepareStatement(
            "INSERT INTO users(name,email,phone,password,role) VALUES(?,?,?,?,?)"
        );

        ps.setString(1,name);
        ps.setString(2,email);
        ps.setString(3,phone);
        ps.setString(4,password);
        ps.setString(5,"citizen");

        ps.executeUpdate();

        out.println(
            "<p style='color:green; text-align:center; margin-top:15px;'>Registration successful! <a href='login.jsp'>Click here to login</a></p>"
        );

        con.close();

    } catch(Exception e) {

        out.println(
            "<p style='color:red; text-align:center; margin-top:15px;'>Error: "
            + e.getMessage()
            + "</p>"
        );
    }
}
%>

<p style="text-align:center; margin-top:15px;">
Already registered?
<a href="login.jsp">Login</a>
</p>

</div>

<script src="js/script.js"></script>

</body>
</html>