package com.useraccess.controller;

import com.useraccess.dao.UserDAO;
import com.useraccess.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * AdminUserServlet - handles CRUD operations for user management.
 * Only accessible by Admin users.
 */
@WebServlet(name = "AdminUserServlet", urlPatterns = {"/AdminUserServlet"})
public class AdminUserServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!checkAdmin(request, response)) return;

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "list":
                listUsers(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteUser(request, response);
                break;
            default:
                listUsers(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!checkAdmin(request, response)) return;

        String action = request.getParameter("action");
        if (action == null) action = "create";

        switch (action) {
            case "create":
                createUser(request, response);
                break;
            case "update":
                updateUser(request, response);
                break;
            default:
                createUser(request, response);
        }
    }

    private void listUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<User> userList = userDAO.findAll();
        request.setAttribute("userList", userList);
        request.getRequestDispatcher("manageUsers.jsp").forward(request, response);
    }

    private void createUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        // Validation
        if (username == null || username.trim().isEmpty()) {
            response.sendRedirect("AdminUserServlet?action=list&error=Username+is+required");
            return;
        }
        if (password == null || password.trim().isEmpty()) {
            response.sendRedirect("AdminUserServlet?action=list&error=Password+is+required");
            return;
        }
        if (role == null || role.trim().isEmpty()) {
            response.sendRedirect("AdminUserServlet?action=list&error=Role+is+required");
            return;
        }
        if (username.trim().length() < 3) {
            response.sendRedirect("AdminUserServlet?action=list&error=Username+must+be+at+least+3+characters");
            return;
        }
        if (password.trim().length() < 6) {
            response.sendRedirect("AdminUserServlet?action=list&error=Password+must+be+at+least+6+characters");
            return;
        }
        if (userDAO.usernameExists(username.trim())) {
            response.sendRedirect("AdminUserServlet?action=list&error=Username+already+exists");
            return;
        }

        User user = new User(username.trim(), password.trim(), role);
        boolean created = userDAO.create(user);

        if (created) {
            response.sendRedirect("AdminUserServlet?action=list&message=User+created+successfully");
        } else {
            response.sendRedirect("AdminUserServlet?action=list&error=Failed+to+create+user");
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        User user = userDAO.findById(id);
        if (user != null) {
            request.setAttribute("editUser", user);
        }
        listUsers(request, response);
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        if (username == null || username.trim().isEmpty()) {
            response.sendRedirect("AdminUserServlet?action=list&error=Username+is+required");
            return;
        }

        User user = new User(id, username.trim(), password.trim(), role);
        boolean updated = userDAO.update(user);

        if (updated) {
            response.sendRedirect("AdminUserServlet?action=list&message=User+updated+successfully");
        } else {
            response.sendRedirect("AdminUserServlet?action=list&error=Update+failed");
        }
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        // Prevent admin from deleting themselves
        HttpSession session = request.getSession(false);
        User currentUser = (User) session.getAttribute("user");
        if (currentUser.getId() == id) {
            response.sendRedirect("AdminUserServlet?action=list&error=Cannot+delete+your+own+account");
            return;
        }

        boolean deleted = userDAO.delete(id);
        if (deleted) {
            response.sendRedirect("AdminUserServlet?action=list&message=User+deleted+successfully");
        } else {
            response.sendRedirect("AdminUserServlet?action=list&error=Delete+failed");
        }
    }

    private boolean checkAdmin(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp?error=Please+log+in");
            return false;
        }
        User user = (User) session.getAttribute("user");
        if (!"Admin".equals(user.getRole())) {
            response.sendRedirect("login.jsp?error=Unauthorized+access.+Admin+role+required");
            return false;
        }
        return true;
    }
}
