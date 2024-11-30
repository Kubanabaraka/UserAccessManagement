<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <style>
        /* Basic styling for the login page */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .login-container {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 400px;
            width: 100%;
            text-align: center;
        }

        .login-container h2 {
            color: #333;
            margin-bottom: 20px;
            font-size: 24px;
        }

        .form-field {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
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

        .error-message {
            color: #dc3545;
            font-weight: bold;
            margin-top: 15px;
        }

        .signup-link {
            margin-top: 20px;
            font-size: 14px;
            color: #007bff;
        }

        .signup-link a {
            text-decoration: none;
            color: #007bff;
        }

        .signup-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Login</h2>
        <form action="LoginServlet" method="POST">
            <input type="text" name="username" placeholder="Username" class="form-field" required>
            <input type="password" name="password" placeholder="Passsword" class="form-field" required>
            <button type="submit" class="submit-button">Login</button>
        </form>

        <%-- Display an error message if it exists --%>
        <c:if test="${not empty errorMessage}">
            <p class="error-message">${errorMessage}</p>
        </c:if>

        <%-- Sign Up link for new users --%>
        <p class="signup-link">
            New user? <a href="signup.jsp">Signnnnn up here</a>
        </p>
    </div>
</body>
</html>
