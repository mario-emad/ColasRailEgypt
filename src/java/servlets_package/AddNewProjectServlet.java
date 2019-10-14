package servlets_package;

import classes_package.ServerConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AddNewProjectServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String name = request.getParameter("namepro");
            String description = request.getParameter("textareapro");
            if (name == null) {
                name = "";
            }
            if (description == null) {
                description = "";
            }

            Connection connection = ServerConnection.ConnectionMethod();
            Statement statement = connection.createStatement();
            String addproSQL = "INSERT INTO project(project_title, project_description) VALUES ('" + name + "','" + description + "');";
            statement.executeUpdate(addproSQL);
            response.sendRedirect("MainProject.jsp");

        } catch (SQLException ex) {
            Logger.getLogger(AddNewProjectServlet.class.getName()).log(Level.SEVERE, null, ex);
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
