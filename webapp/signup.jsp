<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<html>
<head><title>Sign Up</title></head>
<body>
<form action="SignUpServlet" method="post">
    Username: <input type="text" name="username" required /><br>
    Password: <input type="password" name="password" required /><br>
    <input type="hidden" name="role" value="Employee" />
    <input type="submit" value="Sign Up" />
</form>
</body>
</html>
