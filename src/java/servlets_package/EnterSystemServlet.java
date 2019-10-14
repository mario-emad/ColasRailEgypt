package servlets_package;

import classes_package.ServerConnection;
import classes_package.SetGetData;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class EnterSystemServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String username = request.getParameter("user");
            String password = request.getParameter("pass");

            Connection connection = ServerConnection.ConnectionMethod();
            Statement statement = connection.createStatement();
            String userSQL = "SELECT user.username, user.password FROM user;";
            ResultSet resultSet = statement.executeQuery(userSQL);
            while (resultSet.next()) {
                if (username.equals(resultSet.getString("username")) & password.equals(resultSet.getString("password"))) {
                    SetGetData userobj = new SetGetData();
                    userobj.setUser(username);
                    HttpSession session = request.getSession();
                    session.setAttribute("usernameatt", userobj);
                    RequestDispatcher requestDispatcher = request.getRequestDispatcher("MainProject.jsp");
                    requestDispatcher.forward(request, response);
//                    response.sendRedirect("MainProject.jsp");
                    return;
                }
            }
//            RequestDispatcher requestDispatcher = request.getRequestDispatcher("index.jsp");
//            requestDispatcher.forward(request, response);
            response.sendRedirect("index.jsp");
        } catch (SQLException ex) {
            Logger.getLogger(EnterSystemServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
