/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.LearnerDAO;
import DAO.TutorDAO;
import DAO.UserDAO;
import Model.Learner;
import Model.Tutor;
import Model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author Acer
 */
@WebServlet(name = "LoginControllers", urlPatterns = {"/Login"})
public class LoginControllers extends HttpServlet {

    UserDAO userDao = new UserDAO();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginControllers</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginControllers at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = request.getParameter("email");
        String password1 = request.getParameter("password");
        LearnerDAO ldao = new LearnerDAO();
        TutorDAO tDao = new TutorDAO();
        if (password1 != null && email != null) {

            User userLogin = userDao.Login(email, password1);

            if (userLogin != null) {
                if (userLogin.getRole().equalsIgnoreCase("Learner")) {
                    Learner learner = ldao.getLearnerById(userLogin.getId());
                    session.setAttribute("learner", learner);
                    session.setAttribute("user", userLogin);
                    request.getRequestDispatcher("TutorController").forward(request, response);
                } else if (userLogin.getRole().equalsIgnoreCase("tutor")) {
                    Tutor tutor = tDao.getTutorById(userLogin.getId());
                    session.setAttribute("tutor", tutor);
                    session.setAttribute("user", userLogin);
                    request.getRequestDispatcher("TutorDetailController").forward(request, response);//TUng DUONg
                } //Adjust path as necessary
                else if (userLogin.getRole().equalsIgnoreCase("admin")) {
                    Tutor tutor = tDao.getTutorById(userLogin.getId());
                    session.setAttribute("tutor", tutor);
                    session.setAttribute("user", userLogin);
                    request.getRequestDispatcher("AdminController").forward(request, response);//TUng DUONg
                } //A
            } else {
                request.setAttribute("messageError", "Incorrect email or password!");
                request.getRequestDispatcher("View/Login.jsp").forward(request, response);
            }

        } else {
            request.setAttribute("messageError", "Passwords do not match!");
            request.getRequestDispatcher("View/Login.jsp").forward(request, response);
        }
    }
    
    public boolean checkEmail(String email) {
        String EMAIL_PATTERN = "^[\\w.-]+@(gmail\\.com|lookup\\.com)$";
        Pattern pattern = Pattern.compile(EMAIL_PATTERN);
        Matcher matcher = pattern.matcher(email);
        return matcher.matches();
    }
    
    public String computeMD5Hash(String input) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] messageDigest = md.digest(input.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : messageDigest) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
