package Controller;

import Model.User;
import DAO.UserDAO;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Acer
 */
@WebServlet(name = "RegisterController", urlPatterns = {"/Register"})
public class RegisterController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String email = request.getParameter("email");
        String password1 = request.getParameter("password");
        String passwordConfirm = request.getParameter("passwordConfirm");
        String type = request.getParameter("type");
        HttpSession session = request.getSession();
        String password_hash = computeMD5Hash(password1);
        UserDAO userDao = new UserDAO();

        if (checkEmail(email)) {
            if (password1.equals(passwordConfirm)) {
                if (userDao.GetUserWithEmail(email) == null) {
                    User user = new User(email, password_hash, type);
                    session.setAttribute("LearnerRegister", user);
                    response.sendRedirect(request.getContextPath() + "/authorize?action=register");
                } else {
                    request.setAttribute("messageError", "Email already exists");
                    request.getRequestDispatcher("/View/register.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("messageError", "Passwords do not match");
                request.getRequestDispatcher("/View/register.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("messageError", "Invalid email format");
            request.getRequestDispatcher("/View/register.jsp").forward(request, response);
        }
    }

    private String computeMD5Hash(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(password.getBytes());
            byte[] bytes = md.digest();
            StringBuilder sb = new StringBuilder();
            for (byte b : bytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

    private boolean checkEmail(String email) {
        // Basic email format validation, you can improve this with a regex
        return email != null && email.contains("@");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}