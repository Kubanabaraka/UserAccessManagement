package com.useraccess.controller;

import com.useraccess.dao.RequestDAO;
import com.useraccess.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * ApprovalServlet - handles approval/rejection of access requests.
 * Only accessible by Manager users.
 */
@WebServlet(name = "ApprovalServlet", urlPatterns = {"/ApprovalServlet"})
public class ApprovalServlet extends HttpServlet {

    private final RequestDAO requestDAO = new RequestDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check Manager role
        if (!checkManager(request, response)) return;

        String requestIdStr = request.getParameter("request_id");
        String action = request.getParameter("action");

        // Validation
        if (requestIdStr == null || requestIdStr.trim().isEmpty()) {
            response.sendRedirect("PendingRequestsServlet?error=Invalid+request+ID");
            return;
        }

        int requestId;
        try {
            requestId = Integer.parseInt(requestIdStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("PendingRequestsServlet?error=Invalid+request+ID");
            return;
        }

        // Determine new status
        String newStatus;
        if ("Approve".equals(action)) {
            newStatus = "Approved";
        } else if ("Reject".equals(action)) {
            newStatus = "Rejected";
        } else {
            response.sendRedirect("PendingRequestsServlet?error=Invalid+action");
            return;
        }

        // Update the request status
        boolean updated = requestDAO.updateStatus(requestId, newStatus);

        if (updated) {
            response.sendRedirect("PendingRequestsServlet?message=Request+has+been+" + newStatus.toLowerCase());
        } else {
            response.sendRedirect("PendingRequestsServlet?error=Error+processing+request");
        }
    }

    private boolean checkManager(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp?error=Please+log+in");
            return false;
        }
        User user = (User) session.getAttribute("user");
        if (!"Manager".equals(user.getRole())) {
            response.sendRedirect("login.jsp?error=Unauthorized+access.+Manager+role+required");
            return false;
        }
        return true;
    }
}
