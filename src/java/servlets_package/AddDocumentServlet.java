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

public class AddDocumentServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            //variables to catch data
            String document_ID;
            int phase_number;
            String document_title;
            String projectname;
            int project_id = 0;
            String sectionname;
            int section_id = 0;
            String list_index;
            String check = "no";

            /*connection for servlet*/
            Connection connection = ServerConnection.ConnectionMethod();

            /**catch data**/
            document_ID = request.getParameter("doc_id");//document ID.
            
            phase_number = Integer.parseInt(request.getParameter("doc_phase"));//document phase id.
            
            document_title = request.getParameter("doc_title");//document title
            
            /*document project name and catch its id 
            from project table to insert in document table*/
            projectname = request.getParameter("project_name");
            Statement statement1 = connection.createStatement();
            String projectSQL = "SELECT project.project_ID FROM project WHERE project.project_title = '" + projectname + "';";
            ResultSet resultSet1 = statement1.executeQuery(projectSQL);
            if (resultSet1.next()) {
                project_id = resultSet1.getInt("project_ID");//project id would be inserted in document table.
            }

            /*document section name and catch its id 
            from section table to insert in document table*/
            sectionname = request.getParameter("section_name");
            statement1 = connection.createStatement();
            String sectionSQL = "SELECT section.section_ID FROM section WHERE section.section_name = '" + sectionname + "';";
            resultSet1 = statement1.executeQuery(sectionSQL);
            if (resultSet1.next()) {
                section_id = resultSet1.getInt("section_ID");//section id would be inserted in document table.
            }

            list_index = request.getParameter("list_index");//list index of document.

            /*make sure that document would be inserted for the first time*/
            connection = ServerConnection.ConnectionMethod();
            Statement statement = connection.createStatement();
            String confirmdocumentSQL = "SELECT document.document_ID FROM document;";
            ResultSet resultSet = statement.executeQuery(confirmdocumentSQL);
            while (resultSet.next()) {
                if (document_ID.equals(resultSet.getString("document_ID"))) {
                    check = "yes";//yes mean that document is exist.
                    HttpSession session = request.getSession();
                    session.setAttribute("check", check);//set attribute (check) in session.
                    RequestDispatcher requestDispatcher = request.getRequestDispatcher("AddDocument.jsp");
                    requestDispatcher.forward(request, response);
                }
            }
            
            /*if document not exist then will insert it*/
            String insertdocumentSQL = "INSERT INTO document(document_ID, phase_ID, document_title, list_index, project_ID, section_ID) VALUES (?,?,?,?,?,?);";
            PreparedStatement preparedStatement = connection.prepareStatement(insertdocumentSQL);
            preparedStatement.setString(1, document_ID);
            preparedStatement.setInt(2, phase_number);
            preparedStatement.setString(3, document_title);
            preparedStatement.setString(4, list_index);
            preparedStatement.setInt(5, project_id);
            preparedStatement.setInt(6, section_id);
            preparedStatement.executeUpdate();
            check = "add";//add mean that dcument inserted successfully.
            HttpSession session1 = request.getSession();
            session1.setAttribute("check", check);//set attribute (check) in session.
            response.sendRedirect("AddDocument.jsp");

        } catch (SQLException ex) {
            Logger.getLogger(AddDocumentServlet.class.getName()).log(Level.SEVERE, null, ex);
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
