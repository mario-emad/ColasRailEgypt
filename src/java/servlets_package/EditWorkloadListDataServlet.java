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
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class EditWorkloadListDataServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String RESOURCEID = null, ISSUEID = null, DOCUMENTID = null, fullname = null, project = null, phase = null, documentid = null, index = null, title = null, foreseendate = null, estimateworkload = null, fname = null, lname = null, resource = null, startpro = null, endpro = null, progress = null;

//            project = request.getParameter("projectid");
//            phase = request.getParameter("phaseid");
            documentid = request.getParameter("docidid");
            index = request.getParameter("indexid");
//            title = request.getParameter("titleid");
//            foreseendate = request.getParameter("foreseenid");
//            estimateworkload = request.getParameter("estimateid");
//            fname = request.getParameter("fnameid");
//            lname = request.getParameter("lnameid");
//                resource = resultSet.getString("");
            fullname = request.getParameter("res_select");
//            startpro = request.getParameter("startid");
//            endpro = request.getParameter("endid");
//            progress = request.getParameter("myselect");

            if (documentid == null) {
                documentid = "";
            }
            if (index == null) {
                index = "";
            }
            if (fullname == null) {
                fullname = "";
            }
            if (fname == null) {
                fname = "";
            }
            if (lname == null) {
                lname = "";
            }
//            if (startpro == null) {
//                startpro = "";
//            }
//            if (endpro == null) {
//                endpro = "";
//            }
//            if (progress == null) {
//                progress = "";
//            }

            Connection connection = ServerConnection.ConnectionMethod();
            Statement statement = connection.createStatement();
            String docidSQL = "SELECT document.doc_ID FROM document WHERE document.document_ID = '" + documentid + "';";
            ResultSet resultSet = statement.executeQuery(docidSQL);
            if (resultSet.next()) {
                DOCUMENTID = resultSet.getString("doc_ID");
            }
            String issueidSQL = "SELECT issuance.issuance_ID FROM issuance WHERE issuance.doc_ID = " + DOCUMENTID + " AND issuance.iss_index = '" + index + "';";
            resultSet = statement.executeQuery(issueidSQL);
            if (resultSet.next()) {
                ISSUEID = resultSet.getString("issuance_ID");//base of detect to edit
            }
            String resourceidSQL = "SELECT resource.resources_ID FROM resource WHERE resource.full_name = '" + fullname + "';";
            resultSet = statement.executeQuery(resourceidSQL);
            if (resultSet.next()) {
                RESOURCEID = resultSet.getString("resources_ID");//base of detect to edit
            }

            String update2SQL = "UPDATE issuance SET issuance.technical_ID = NULL, issuance.resource_ID = " + RESOURCEID + " WHERE issuance.issuance_ID = " + ISSUEID + ";";
            statement.executeUpdate(update2SQL);

            response.sendRedirect("WorkloadList.jsp");
//            RequestDispatcher requestDispatcher = request.getRequestDispatcher("TimesheetList.jsp");
//            requestDispatcher.forward(request, response);

        } catch (SQLException ex) {
            Logger.getLogger(EditWorkloadListDataServlet.class.getName()).log(Level.SEVERE, null, ex);
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
