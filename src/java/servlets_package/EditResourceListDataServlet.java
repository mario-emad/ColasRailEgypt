
package servlets_package;

import classes_package.ServerConnection;
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


public class EditResourceListDataServlet extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            String status = request.getParameter("status_select");
            String fullname = request.getParameter("fullname_name");
            
            Connection con = ServerConnection.ConnectionMethod();
            Statement statement = con.createStatement();
            String statusidSQL = "SELECT status.status_ID FROM status WHERE status.status_title = '" + status + "';";
            ResultSet resultSet = statement.executeQuery(statusidSQL);
            int statid = 0;
            if(resultSet.next()){
                statid = resultSet.getInt("status_ID");
            }
            String updteresourceSQL = "UPDATE resource SET resource.status_ID = " + statid + " WHERE resource.full_name = '" + fullname + "';";
            statement.executeUpdate(updteresourceSQL);
            
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("ResourceList.jsp");
            requestDispatcher.forward(request, response);
            
        } catch (SQLException ex) {
            Logger.getLogger(EditResourceListDataServlet.class.getName()).log(Level.SEVERE, null, ex);
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
