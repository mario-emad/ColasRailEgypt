
package servlets_package;

import classes_package.ServerConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class DeleteResourceServlet extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            int resourceid = 0;
            String checkres = "not";
            
            String name = request.getParameter("delete_resource_select");
            String namearr[] = name.split("\\s");
            String fname = namearr[0], sname = namearr[1];
            
            Connection connection = ServerConnection.ConnectionMethod();
            
            String resourceidSQL = "SELECT resource.resources_ID FROM resource WHERE resource.first_name = '" + fname + "' AND resource.last_name = '" + sname + "';";
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(resourceidSQL);
            if(resultSet.next()){
                resourceid = resultSet.getInt("resources_ID");
            }
            
            String updateissuanceofresource = "UPDATE issuance SET issuance.resource_ID = null WHERE issuance.resource_ID = ?;";
            PreparedStatement preparedStatement = connection.prepareStatement(updateissuanceofresource);
            preparedStatement.setInt(1, resourceid);
            preparedStatement.executeUpdate();
            
            String deleteresourceSQL = "DELETE FROM resource WHERE resource.resources_ID = ?;";
            preparedStatement = connection.prepareStatement(deleteresourceSQL);
            preparedStatement.setInt(1, resourceid);
            preparedStatement.executeUpdate();
            
            checkres = "done";
            HttpSession session = request.getSession();
            session.setAttribute("checkres", checkres);
            
            response.sendRedirect("DeleteItems.jsp");
            
        } catch (SQLException ex) {
            Logger.getLogger(DeleteResourceServlet.class.getName()).log(Level.SEVERE, null, ex);
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
