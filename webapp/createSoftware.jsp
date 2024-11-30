<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="jakarta.servlet.http.HttpSession" %>
<%
    // Role-based access control
    String role = (session != null) ? (String) session.getAttribute("role") : null;
    if (!"Admin".equals(role)) {
        request.setAttribute("errorMessage", "Unauthorized access. Please log in as an Admin.");
        request.getRequestDispatcher("login.jsp").forward(request, response);
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create Software</title>
    <style>
        /* Styling for the software creation page */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            max-width: 500px;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .logout-button {
            margin-top: 20px;
            padding: 10px 15px;
            font-size: 14px;
            background-color: #dc3545;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        h2 {
            color: #333;
            margin-bottom: 20px;
        }

        .form-field {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }

        .submit-button {
            width: 100%;
            padding: 10px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
        }

        .submit-button:hover {
            background-color: #0056b3;
        }

        /* Popup message styling */
        .popup {
            position: fixed;
            top: 20px;
            right: 20px;
            background-color: #28a745;
            color: white;
            padding: 15px 20px;
            border-radius: 5px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            opacity: 0;
            transition: opacity 0.5s ease;
        }

        .error-popup {
            background-color: #dc3545; /* Red for error */
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Create New Software</h2>
        <form action="SoftwareServlet" method="POST">
            <input type="text" name="softwareName" placeholder="Software Name" class="form-field" required>
            <textarea name="description" placeholder="Description" class="form-field" required></textarea>

            <label>Access Levels:</label><br>
            <label><input type="checkbox" name="accessLevels" value="Read"> Read</label>
            <label><input type="checkbox" name="accessLevels" value="Write"> Write</label>
            <label><input type="checkbox" name="accessLevels" value="Admin"> Admin</label><br><br>

            <button type="submit" class="submit-button">Create Software</button>
        </form>
        
        <%-- Logout button at the bottom --%>
        <form action="login.jsp" method="post" onsubmit="logout(event)">
            <button type="submit" class="logout-button">Logout</button>
        </form>
    </div>
    
    <%-- Display popup if software was created successfully --%>
    <c:if test="${param.success == 'true'}">
        <div class="popup" id="successPopup">Software created successfully!</div>
    </c:if>

    <%-- Display error popup if there is an error message --%>
    <c:if test="${not empty param.error}">
        <div class="popup error-popup" id="errorPopup">${param.error}</div>
    </c:if>

    <script>
        // JavaScript to display and hide popups
        window.addEventListener("load", function () {
            const successPopup = document.getElementById("successPopup");
            const errorPopup = document.getElementById("errorPopup");

            if (successPopup) {
                successPopup.style.opacity = "1";
                setTimeout(function () {
                    successPopup.style.opacity = "0";
                }, 3000); // Hide after 3 seconds
            }

            if (errorPopup) {
                errorPopup.style.opacity = "1";
                setTimeout(function () {
                    errorPopup.style.opacity = "0";
                }, 5000); // Hide error popup after 5 seconds
            }
        });

        // JavaScript to handle logout and session invalidation
        function logout(event) {
            event.preventDefault();
            fetch('LogoutServlet', { method: 'GET' })
                .then(() => {
                    window.location.href = 'login.jsp';
                })
                .catch(error => console.error('Logout error:', error));
        }
    </script>
</body>
</html>
