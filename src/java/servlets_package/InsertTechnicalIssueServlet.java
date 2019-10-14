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

public class InsertTechnicalIssueServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String date = request.getParameter("tech_date"),
                    documentID = request.getParameter("tech_doc_ID"),
                    type = request.getParameter("tech_prob_type"),
                    assigned = request.getParameter("tech_res_ass"),
                    comment = request.getParameter("tech_com");

            //split issuance id into document id and issuance index
            String documentidarr[] = documentID.split("-");
            String documentindex = documentidarr[documentidarr.length - 1];
            String documentidarr2[] = new String[documentidarr.length - 1];
            String documentid = "";
            System.arraycopy(documentidarr, 0, documentidarr2, 0, documentidarr.length - 1);
            for (int i = 0; i < documentidarr2.length; i++) {
                documentid += documentidarr2[i] + "-";
            }
            documentid = documentid.substring(0, documentid.length() - 1);
            //end section

            //select issuance id
            Connection connection = ServerConnection.ConnectionMethod();
            Statement statement = connection.createStatement();
            String docidtableSQL = "SELECT document.doc_ID FROM document WHERE document.document_ID = '" + documentid + "';";
            ResultSet resultSet = statement.executeQuery(docidtableSQL);
            int docidtable = 0;
            if (resultSet.next()) {
                docidtable = resultSet.getInt("doc_ID");
            }
            String issueidtableSQL = "SELECT issuance.issuance_ID FROM issuance WHERE issuance.doc_ID = " + docidtable + " AND issuance.iss_index = '" + documentindex + "';";
            resultSet = statement.executeQuery(issueidtableSQL);
            int issueidtable = 0;
            if (resultSet.next()) {
                issueidtable = resultSet.getInt("issuance_ID");
            }
            //end section

            //select resource id
            String resourceidSQL = "SELECT resource.resources_ID FROM resource WHERE resource.full_name = '" + assigned + "';";
            resultSet = statement.executeQuery(resourceidSQL);
            int resourceid = 0;
            if (resultSet.next()) {
                resourceid = resultSet.getInt("resources_ID");
            }
            //end section

            String insertechnicalSQL = "INSERT INTO technicalissue( technical_date, problem_type, technical_assigned, issuance_ID, technical_notes) VALUES (?,?,?,?,?);";
            PreparedStatement preparedStatement = connection.prepareStatement(insertechnicalSQL);
            preparedStatement.setString(1, date);
            preparedStatement.setString(2, type);
            preparedStatement.setInt(3, resourceid);
            preparedStatement.setInt(4, issueidtable);
            preparedStatement.setString(5, comment);
            preparedStatement.executeUpdate();

            //select technical id
            String technicalissueidSQL = "SELECT MAX(technicalissue.technical_id) FROM technicalissue WHERE technicalissue.issuance_ID = " + issueidtable + " AND technicalissue.technical_assigned = " + resourceid + ";";
            resultSet = statement.executeQuery(technicalissueidSQL);
            int technicalissueid = 0;
            if (resultSet.next()) {
                technicalissueid = resultSet.getInt("MAX(technicalissue.technical_id)");
            }
            //end section

            String updateprogtechSQL = "UPDATE issuance SET issuance.progress = 'Technical issue', issuance.technical_ID = ? WHERE issuance.issuance_ID = ?;";
            preparedStatement = connection.prepareStatement(updateprogtechSQL);
            preparedStatement.setInt(1, technicalissueid);
            preparedStatement.setInt(2, issueidtable);
            preparedStatement.executeUpdate();

//            response.sendRedirect("TimesheetList.jsp");
//            response.sendRedirect("EditTimesheetListData.jsp");
            String ind = request.getParameter("indid");
            RequestDispatcher requestDispatcher = request.getRequestDispatcher("EditTimesheetListData.jsp?newissid=" + ind);
            requestDispatcher.forward(request, response);

        } catch (SQLException ex) {
            Logger.getLogger(InsertTechnicalIssueServlet.class.getName()).log(Level.SEVERE, null, ex);
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
