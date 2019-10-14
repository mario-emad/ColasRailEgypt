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

public class CreateUserServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String cname = request.getParameter("cname");
            String cuser = request.getParameter("cuser");
            String cpass = request.getParameter("cpass");
            String byuser = request.getParameter("byuser");
            String bypass = request.getParameter("bypass");

            Connection connection = ServerConnection.ConnectionMethod();
            Statement statement = connection.createStatement();
            String userSQL = "SELECT user.name, user.username, user.password FROM user;";
            ResultSet resultSet = statement.executeQuery(userSQL);
            while (resultSet.next()) {
                if (byuser.equals(resultSet.getString("username")) & bypass.equals(resultSet.getString("password"))) {
                    String byname = resultSet.getString("name");
                    Connection connection1 = ServerConnection.ConnectionMethod();
                    Statement statement1 = connection.createStatement();
                    String insuserSQL = "SELECT user.username FROM user;";
                    ResultSet resultSet1 = statement.executeQuery(insuserSQL);
                    while (resultSet1.next()) {
                        if (cuser.equals(resultSet1.getString("username"))) {
//                            RequestDispatcher requestDispatcher = request.getRequestDispatcher("index.jsp");
//                            requestDispatcher.forward(request, response);
                            response.sendRedirect("index.jsp");
                            return;
                        }
                    }
                    Connection connection2 = ServerConnection.ConnectionMethod();
                    String insertuserSQL = "INSERT INTO user (user.name, user.username, user.password, user.addby) VALUES (?,?,?,?);";
                    PreparedStatement preparedStatement = connection2.prepareStatement(insertuserSQL);
                    preparedStatement.setString(1, cname);
                    preparedStatement.setString(2, cuser);
                    preparedStatement.setString(3, cpass);
                    preparedStatement.setString(4, byname);
                    preparedStatement.executeUpdate();

//                    RequestDispatcher requestDispatcher = request.getRequestDispatcher("index.jsp");
//                    requestDispatcher.forward(request, response);
                    response.sendRedirect("index.jsp");
                    return;
                }
//                RequestDispatcher requestDispatcher = request.getRequestDispatcher("index.jsp");
//                requestDispatcher.forward(request, response);
                response.sendRedirect("index.jsp");
                return;
            }
//            RequestDispatcher requestDispatcher = request.getRequestDispatcher("index.jsp");
//            requestDispatcher.forward(request, response);
            response.sendRedirect("index.jsp");
            //**************************************************************************************************************************
//            Connection connection = ServerConnection.ConnectionMethod();
//            Statement statement = connection.createStatement();
//            String userSQL = "SELECT user.name, user.username, user.password FROM user;";
//            ResultSet resultSet = statement.executeQuery(userSQL);
//            while (resultSet.next()) {
//                if (byuser.equals(resultSet.getString("username")) & bypass.equals(resultSet.getString("password"))) {
//                    String byname = resultSet.getString("name");
//                    Statement statement1 = connection.createStatement();
//                    String insuserSQL = "SELECT user.username FROM user;";
//                    ResultSet resultSet1 = statement.executeQuery(insuserSQL);
//                    while (resultSet1.next()) {
//                        if (cuser.equals(resultSet1.getString("username"))) {
//                            RequestDispatcher requestDispatcher = request.getRequestDispatcher("index.jsp");
//                            requestDispatcher.forward(request, response);
//                        }
//                    }
//                    String insertuserSQL = "INSERT INTO user(user.name, user.username, user.password, user.addby) VALUES (?,?,?,?);";
//                    PreparedStatement preparedStatement = connection.prepareStatement(insertuserSQL);
//                    preparedStatement.setString(1, cname);
//                    preparedStatement.setString(2, cuser);
//                    preparedStatement.setString(3, cpass);
//                    preparedStatement.setString(4, byname);
//                    preparedStatement.executeUpdate();
//
//                    RequestDispatcher requestDispatcher = request.getRequestDispatcher("index.jsp");
//                    requestDispatcher.forward(request, response);
//                } else {
//                    RequestDispatcher requestDispatcher = request.getRequestDispatcher("index.jsp");
//                    requestDispatcher.forward(request, response);
//                }
//            }
            //***************************************************************************************************************************
        } catch (SQLException ex) {
            Logger.getLogger(CreateUserServlet.class.getName()).log(Level.SEVERE, null, ex);
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
