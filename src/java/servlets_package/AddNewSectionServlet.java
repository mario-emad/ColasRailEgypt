
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


public class AddNewSectionServlet extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            
            String name = request.getParameter("namesec");
            String description = request.getParameter("textareasec");
            
            Connection connection = ServerConnection.ConnectionMethod();
            Statement statement = connection.createStatement();
            String insertsectionSQL = "INSERT INTO section(section_name, section_description) VALUES ('" + name + "','" + description + "');";
            statement.executeLargeUpdate(insertsectionSQL);
            response.sendRedirect("MainProject.jsp");
        } catch (SQLException ex) {
            Logger.getLogger(AddNewSectionServlet.class.getName()).log(Level.SEVERE, null, ex);
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
