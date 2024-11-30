<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Request Access</title>
</head>
<body>
    <h2>Request Access to Software</h2>

    <form action="RequestServlet" method="post">
        <label for="softwareName">Software:</label>
        <select name="softwareName" required>
            <c:forEach var="software" items="${softwareList}">
                <option value="${software}">${software}</option>
            </c:forEach>
        </select><br><br>

        <label for="accessType">Access Type:</label>
        <select name="accessType" required>
            <option value="Read">Read</option>
            <option value="Write">Write</option>
            <option value="Admin">Admin</option>
        </select><br><br>

        <label for="reason">Reason:</label><br>
        <textarea name="reason" rows="4" cols="50" required></textarea><br><br>

        <input type="submit" value="Submit Request">
    </form>
</body>
</html>
