<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<html>
<head><title>Pending Requests</title></head>
<body>
<table>
    <tr><th>Employee Name</th><th>Software Name</th><th>Access Type</th><th>Reason</th><th>Action</th></tr>
    <%-- Code to list pending requests --%>
    <tr>
        <td>John Doe</td>
        <td>Software ABC</td>
        <td>Read</td>
        <td>Need for Project</td>
        <td>
            <form action="ApprovalServlet" method="post">
                <input type="hidden" name="request_id" value="1" />
                <input type="submit" name="action" value="Approve" />
                <input type="submit" name="action" value="Reject" />
            </form>
        </td>
    </tr>
</table>
</body>
</html>
