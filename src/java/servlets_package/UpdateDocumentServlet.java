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

public class UpdateDocumentServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String docid = request.getParameter("udoc_id"),
                    doctitle = request.getParameter("udoc_title"),
                    project = request.getParameter("udoc_project_select"),
                    list = request.getParameter("ulist_index"),
                    section = request.getParameter("udoc_section_select"),
                    phase = request.getParameter("udoc_phase_select"),
                    checkall = "no", checkudocid = "no", checkdoctitle = "no", checkdocproject = "no", checkdoclist = "no", checkdocsection = "no", checkdocphase = "no";

            String MAINDOCID = request.getParameter("udoc_main_doc_select"), DOCID = null, DOCTITLE = null, LIST = null;
            int PROJECT = 0, SECTION = 0, PHASE = 0;

            Connection connection = ServerConnection.ConnectionMethod();
            PreparedStatement preparedStatement;
            Statement statement = connection.createStatement();
            ResultSet resultSet = null;

            if (phase == null || phase.equals("")) {

            } else {
                PHASE = Integer.parseInt(request.getParameter("udoc_phase_select"));
                String udocphaseSQL = "UPDATE document SET document.phase_ID = ? WHERE document.document_ID = ?;";
                preparedStatement = connection.prepareStatement(udocphaseSQL);
                preparedStatement.setInt(1, PHASE);
                preparedStatement.setString(2, MAINDOCID);
                preparedStatement.executeUpdate();
                checkdocphase = "add";
                checkall = "add";
                HttpSession session1 = request.getSession();
                session1.setAttribute("checkdocphase", checkdocphase);
                session1.setAttribute("checkall", checkall);
            }

            if (doctitle == null || doctitle.equals("")) {
                
            } else {
                DOCTITLE = request.getParameter("udoc_title");
                String udoctitleSQL = "UPDATE document SET document.document_title = ? WHERE document.document_ID = ?;";
                preparedStatement = connection.prepareStatement(udoctitleSQL);
                preparedStatement.setString(1, DOCTITLE);
                preparedStatement.setString(2, MAINDOCID);
                preparedStatement.executeUpdate();
                checkdoctitle = "add";
                checkall = "add";
                HttpSession session1 = request.getSession();
                session1.setAttribute("checkdoctitle", checkdoctitle);
                session1.setAttribute("checkall", checkall);
            }

            if (project == null || project.equals("")) {

            } else {
                String detprojectSQL = "SELECT project.project_ID FROM project WHERE project.project_title = '" + project + "'";
                resultSet = statement.executeQuery(detprojectSQL);
                if (resultSet.next()) {
                    PROJECT = resultSet.getInt("project_ID");
                    String udocprojectSQL = "UPDATE document SET document.project_ID = ? WHERE document.document_ID = ?;";
                    preparedStatement = connection.prepareStatement(udocprojectSQL);
                    preparedStatement.setInt(1, PROJECT);
                    preparedStatement.setString(2, MAINDOCID);
                    preparedStatement.executeUpdate();
                    checkdocproject = "add";
                    checkall = "add";
                    HttpSession session1 = request.getSession();
                    session1.setAttribute("checkdocproject", checkdocproject);
                    session1.setAttribute("checkall", checkall);
                }
            }

            if (list == null || list.equals("")) {

            } else {
                LIST = request.getParameter("ulist_index");
                String udoclistSQL = "UPDATE document SET document.list_index = ? WHERE document.document_ID = ?;";
                preparedStatement = connection.prepareStatement(udoclistSQL);
                preparedStatement.setString(1, LIST);
                preparedStatement.setString(2, MAINDOCID);
                preparedStatement.executeUpdate();
                checkdoclist = "add";
                checkall = "add";
                HttpSession session1 = request.getSession();
                session1.setAttribute("checkdoclist", checkdoclist);
                session1.setAttribute("checkall", checkall);
            }

            if (section == null || section.equals("")) {

            } else {

            }
            String detsectionSQL = "SELECT section.section_ID FROM section WHERE section.section_name = '" + section + "';";
            resultSet = statement.executeQuery(detsectionSQL);
            if (resultSet.next()) {
                SECTION = resultSet.getInt("section_ID");
                String udocsectionSQL = "UPDATE document SET document.section_ID = ? WHERE document.document_ID = ?;";
                preparedStatement = connection.prepareStatement(udocsectionSQL);
                preparedStatement.setInt(1, SECTION);
                preparedStatement.setString(2, MAINDOCID);
                preparedStatement.executeUpdate();
                checkdocsection = "add";
                checkall = "add";
                HttpSession session1 = request.getSession();
                session1.setAttribute("checkdocsection", checkdocsection);
                session1.setAttribute("checkall", checkall);
            }

            if (docid == null || docid.equals("")) {

            } else {
                DOCID = request.getParameter("udoc_id");
                String udocidSQL = "UPDATE document SET document.document_ID = ? WHERE document.document_ID = ?;";
                preparedStatement = connection.prepareStatement(udocidSQL);
                preparedStatement.setString(1, DOCID);
                preparedStatement.setString(2, MAINDOCID);
                preparedStatement.executeUpdate();
                checkudocid = "add";
                checkall = "add";
                HttpSession session1 = request.getSession();
                session1.setAttribute("checkudocid", checkudocid);
                session1.setAttribute("checkall", checkall);

            }

            response.sendRedirect("UpdateDocument.jsp");

        } catch (SQLException ex) {
            Logger.getLogger(UpdateDocumentServlet.class.getName()).log(Level.SEVERE, null, ex);
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
