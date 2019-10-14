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
import javax.servlet.http.HttpSession;

public class UpdateResourceServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String uresource = request.getParameter("uissue_resource_select"),
                    fname = request.getParameter("ures_first_name"),
                    lname = request.getParameter("ures_last_name"),
                    function = request.getParameter("ures_function_select"),
                    status = request.getParameter("ures_status_select"),
                    fullname = request.getParameter("ures_full_name");
            
            String checkfname = "no", checklname = "no", checkfullname = "no", checkfunction = "no", checkstatus = "no", checkall = "no";
            
            
            //detect the first name and last name of resource.
                String frname, lsname, funame;
                String flname[] = uresource.split(" -> ");
                funame = flname[1];
                String name[] = flname[0].split("\\s");
                frname = name[0];
                lsname = name[1];
                //end section
            
                
                Connection connection = null;
                Statement statement = null;
                
//                int resourceid = 0;
//                connection = ServerConnection.ConnectionMethod();
//                statement = connection.createStatement();
//                String resourceidSQL = "SELECT resource.resources_ID FROM resource WHERE resource.full_name = '" + funame + "';";
//                ResultSet resultSet = statement.executeQuery(resourceidSQL);
//                if(resultSet.next()){
//                    resourceid = resultSet.getInt("resources_ID");
//                }
                
            if (fname == null || fname.equals("")) {

            } else {
                connection = ServerConnection.ConnectionMethod();
                statement = connection.createStatement();
                String updatefnameSQL = "UPDATE resource SET  resource.first_name = '" + fname + "' WHERE resource.full_name = '" + funame + "';";
                statement.executeUpdate(updatefnameSQL);
                
                checkfname = "add";
                checkall = "add";
                HttpSession session1 = request.getSession();
                session1.setAttribute("checkfname", checkfname);
                session1.setAttribute("checkall", checkall);
            }
            if (lname == null || lname.equals("")) {

            } else {
                connection = ServerConnection.ConnectionMethod();
                statement = connection.createStatement();
                String updatelnameSQL = "UPDATE resource SET  resource.last_name = '" + lname + "' WHERE resource.full_name = '" + funame + "';";
                statement.executeUpdate(updatelnameSQL);
                
                checklname = "add";
                checkall = "add";
                HttpSession session1 = request.getSession();
                session1.setAttribute("checklname", checklname);
                session1.setAttribute("checkall", checkall);
            }
            if (function == null || function.equals("")) {

            } else {
                connection = ServerConnection.ConnectionMethod();
                statement = connection.createStatement();
                String functionidSQL = "SELECT function.function_ID FROM function WHERE function.function_title = '" + function + "';";
                ResultSet resultSet = statement.executeQuery(functionidSQL);
                int funid = 0;
                if(resultSet.next()){
                    funid = resultSet.getInt("function_ID");
                }
                String updatefunctionSQL = "UPDATE resource SET  resource.function_ID = " + funid + " WHERE resource.full_name = '" + funame + "';";
                statement.executeUpdate(updatefunctionSQL);
                
                checkfunction = "add";
                checkall = "add";
                HttpSession session1 = request.getSession();
                session1.setAttribute("checkfunction", checkfunction);
                session1.setAttribute("checkall", checkall);
            }
            if (status == null || status.equals("")) {

            } else {
                connection = ServerConnection.ConnectionMethod();
                statement = connection.createStatement();
                String statusidSQL = "SELECT status.status_ID FROM status WHERE status.status_title = '" + status + "';";
                ResultSet resultSet = statement.executeQuery(statusidSQL);
                int staid = 0;
                if(resultSet.next()){
                    staid = resultSet.getInt("status_ID");
                }
                String updatefunctionSQL = "UPDATE resource SET  resource.status_ID = " + staid + " WHERE resource.full_name = '" + funame + "';";
                statement.executeUpdate(updatefunctionSQL);
                
                checkstatus = "add";
                checkall = "add";
                HttpSession session1 = request.getSession();
                session1.setAttribute("checkstatus", checkstatus);
                session1.setAttribute("checkall", checkall);
            }
            if (fullname == null || fullname.equals("")) {

            } else {
                connection = ServerConnection.ConnectionMethod();
                statement = connection.createStatement();
                String updatefunctionSQL = "UPDATE resource SET  resource.full_name = '" + fullname + "' WHERE resource.full_name = '" + funame + "';";
                statement.executeUpdate(updatefunctionSQL);
                
                checkfullname = "add";
                checkall = "add";
                HttpSession session1 = request.getSession();
                session1.setAttribute("checkfullname", checkfullname);
                session1.setAttribute("checkall", checkall);
            }
            
            response.sendRedirect("UpdateResource.jsp");

        } catch (SQLException ex) {
            Logger.getLogger(UpdateResourceServlet.class.getName()).log(Level.SEVERE, null, ex);
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
