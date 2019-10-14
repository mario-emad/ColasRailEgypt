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
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AddResourceServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String fname;
            String sname;
            int function = 0;
            int status = 0;
            String fullname;
            String check = "no";

            fname = request.getParameter("res_first_name");
            sname = request.getParameter("res_last_name");
            fullname = request.getParameter("res_full_name");

            //make sure that resource isn't exist
            Connection connection2 = ServerConnection.ConnectionMethod();
            Statement statement = connection2.createStatement();
            String confirmresourceSQL = "SELECT resource.full_name FROM resource WHERE resource.full_name = '" + fullname + "';";
            ResultSet resultSet = statement.executeQuery(confirmresourceSQL);
            if (resultSet.next()) {
                check = "yes";
                HttpSession session = request.getSession();
                session.setAttribute("check", check);
                RequestDispatcher requestDispatcher = request.getRequestDispatcher("AddResource.jsp");
                requestDispatcher.forward(request, response);
            } else {

                String fun = request.getParameter("res_function_select");
                Connection connection1 = ServerConnection.ConnectionMethod();
                Statement statement1 = connection1.createStatement();
                String funidSQL = "SELECT function.function_ID FROM function WHERE function.function_title = '" + fun + "';";
                ResultSet resultSet1 = statement1.executeQuery(funidSQL);
                if (resultSet1.next()) {
                    function = resultSet1.getInt("function_ID");
                }

                String sta = request.getParameter("res_status_selecet");
                statement1 = connection1.createStatement();
                String staidSQL = "SELECT status.status_ID FROM status WHERE status.status_title = '" + sta + "';";
                resultSet1 = statement1.executeQuery(staidSQL);
                if (resultSet1.next()) {
                    status = resultSet1.getInt("status_ID");
                }

                Connection connection = ServerConnection.ConnectionMethod();
                String insertresourceSQL = "INSERT INTO resource(resource.first_name, resource.last_name, resource.function_ID, resource.status_ID, resource.full_name) VALUES (?,?,?,?,?);";
                PreparedStatement preparedStatement = connection.prepareStatement(insertresourceSQL);
                preparedStatement.setString(1, fname);
                preparedStatement.setString(2, sname);
                preparedStatement.setInt(3, function);
                preparedStatement.setInt(4, status);
                preparedStatement.setString(5, fullname);
                preparedStatement.executeUpdate();
                check = "add";
                HttpSession session1 = request.getSession();
                session1.setAttribute("check", check);
                response.sendRedirect("AddResource.jsp");
            }

        } catch (SQLException ex) {
            Logger.getLogger(AddResourceServlet.class.getName()).log(Level.SEVERE, null, ex);
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
