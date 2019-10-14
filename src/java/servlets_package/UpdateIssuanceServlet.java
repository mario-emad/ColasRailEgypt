package servlets_package;

import classes_package.ServerConnection;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
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

public class UpdateIssuanceServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            String ISSUANCEID = request.getParameter("uissue_main_doc_select"),
                    issuanceindex = request.getParameter("uissue_index"),
                    foreseendate = request.getParameter("uissue_foreseen_send"),
                    realdate = request.getParameter("uissue_real_send"),
                    status = request.getParameter("uissue_status_select"),
                    productionstart = request.getParameter("uissue_production_start"),
                    productionend = request.getParameter("uissue_production_end"),
                    progress = request.getParameter("uissue_progress_select"),
                    resource = request.getParameter("uissue_resource_select"),
                    estimate = request.getParameter("uisuue_est_workload"),
                    file = request.getParameter("issue_file");

            int resourceid = 0;

            String checkissueindex = "no",
                    checkforeseen = "no",
                    checkreal = "no",
                    checkstatus = "no",
                    checkprodstart = "no",
                    checkprodend = "no",
                    checkprogress = "no",
                    checkresource = "no",
                    checkestimate = "no",
                    checkfile = "no",
                    checkall = "no";

            //split issuance id into document id and issuance index
            String documentidarr[] = ISSUANCEID.split("-");
            String documentindex = documentidarr[documentidarr.length - 1];
            String documentidarr2[] = new String[documentidarr.length - 1];
            String documentid = "";
            System.arraycopy(documentidarr, 0, documentidarr2, 0, documentidarr.length - 1);
            for (int i = 0; i < documentidarr2.length; i++) {
                documentid += documentidarr2[i] + "-";
            }
            documentid = documentid.substring(0, documentid.length() - 1);
            //end section

            //detect the doc_id(table primary key) of document ID
            int doc_id = 0;
            Connection connection = ServerConnection.ConnectionMethod();
            Statement statement = connection.createStatement();
            String docidSQL = "SELECT document.doc_ID FROM document WHERE document.document_ID = '" + documentid + "';";
            ResultSet resultSet = statement.executeQuery(docidSQL);
            if (resultSet.next()) {
                doc_id = resultSet.getInt("doc_ID");
            }
            //end section

            //after the past tow steps we have [document id (table primary key)] and [document index].
            PreparedStatement preparedStatement = null;
            if (foreseendate == null || foreseendate.equals("")) {

            } else {
                String uresourceforeseenSQL = "UPDATE issuance SET issuance.foreseen_send_date = ? WHERE issuance.doc_ID = ? AND issuance.iss_index = ?;";
                preparedStatement = connection.prepareStatement(uresourceforeseenSQL);
                preparedStatement.setString(1, foreseendate);
                preparedStatement.setInt(2, doc_id);
                preparedStatement.setString(3, documentindex);
                preparedStatement.executeUpdate();

                checkforeseen = "add";
                checkall = "add";
                HttpSession session1 = request.getSession();
                session1.setAttribute("checkforeseen", checkforeseen);
                session1.setAttribute("checkall", checkall);
            }
            if (realdate == null || realdate.equals("")) {

            } else {
                String uresourcerealSQL = "UPDATE issuance SET issuance.real_date = ? WHERE issuance.doc_ID = ? AND issuance.iss_index = ?;";
                preparedStatement = connection.prepareStatement(uresourcerealSQL);
                preparedStatement.setString(1, realdate);
                preparedStatement.setInt(2, doc_id);
                preparedStatement.setString(3, documentindex);
                preparedStatement.executeUpdate();

                checkreal = "add";
                checkall = "add";
                HttpSession session1 = request.getSession();
                session1.setAttribute("checkreal", checkreal);
                session1.setAttribute("checkall", checkall);
            }
            if (status == null || status.equals("")) {

            } else {
                String uresourcestateSQL = "UPDATE issuance SET issuance.status = ? WHERE issuance.doc_ID = ? AND issuance.iss_index = ?;";
                preparedStatement = connection.prepareStatement(uresourcestateSQL);
                preparedStatement.setString(1, realdate);
                preparedStatement.setInt(2, doc_id);
                preparedStatement.setString(3, documentindex);
                preparedStatement.executeUpdate();

                checkstatus = "add";
                checkall = "add";
                HttpSession session1 = request.getSession();
                session1.setAttribute("checkstatus", checkstatus);
                session1.setAttribute("checkall", checkall);
            }
            if (productionstart == null || productionstart.equals("")) {

            } else {
                String uresourcestartSQL = "UPDATE issuance SET issuance.production_start_date = ? WHERE issuance.doc_ID = ? AND issuance.iss_index = ?;";
                preparedStatement = connection.prepareStatement(uresourcestartSQL);
                preparedStatement.setString(1, productionstart);
                preparedStatement.setInt(2, doc_id);
                preparedStatement.setString(3, documentindex);
                preparedStatement.executeUpdate();

                checkprodstart = "add";
                checkall = "add";
                HttpSession session1 = request.getSession();
                session1.setAttribute("checkprodstart", checkprodstart);
                session1.setAttribute("checkall", checkall);
            }
            if (productionend == null || productionend.equals("")) {

            } else {
                String uresourceendSQL = "UPDATE issuance SET issuance.production_end_date = ? WHERE issuance.doc_ID = ? AND issuance.iss_index = ?;";
                preparedStatement = connection.prepareStatement(uresourceendSQL);
                preparedStatement.setString(1, productionend);
                preparedStatement.setInt(2, doc_id);
                preparedStatement.setString(3, documentindex);
                preparedStatement.executeUpdate();

                checkprodend = "add";
                checkall = "add";
                HttpSession session1 = request.getSession();
                session1.setAttribute("checkprodend", checkprodend);
                session1.setAttribute("checkall", checkall);
            }
            if (progress == null || progress.equals("")) {

            } else {
                String uresourceprogressSQL = "UPDATE issuance SET issuance.progress = ? WHERE issuance.doc_ID = ? AND issuance.iss_index = ?;";
                preparedStatement = connection.prepareStatement(uresourceprogressSQL);
                preparedStatement.setString(1, progress);
                preparedStatement.setInt(2, doc_id);
                preparedStatement.setString(3, documentindex);
                preparedStatement.executeUpdate();

                checkprogress = "add";
                checkall = "add";
                HttpSession session1 = request.getSession();
                session1.setAttribute("checkprogress", checkprogress);
                session1.setAttribute("checkall", checkall);
            }
            if (resource == null || resource.equals("")) {

            } else {
                //detect the first name and last name of resource.
                String fname, lname, fullname;
                String flname[] = resource.split(" -> ");
                fullname = flname[1];
                String name[] = flname[0].split("\\s");
                fname = name[0];
                lname = name[1];
                //end section

                statement = connection.createStatement();
                String resourceidSQL = "SELECT resource.resources_ID FROM resource WHERE resource.full_name = '" + fullname + "';";
                resultSet = statement.executeQuery(resourceidSQL);
                if (resultSet.next()) {
                    resourceid = resultSet.getInt("resources_ID");
                }

                String uresourceresourceSQL = "UPDATE issuance SET issuance.resource_ID = ? WHERE issuance.doc_ID = ? AND issuance.iss_index = ?;";
                preparedStatement = connection.prepareStatement(uresourceresourceSQL);
                preparedStatement.setInt(1, resourceid);
                preparedStatement.setInt(2, doc_id);
                preparedStatement.setString(3, documentindex);
                preparedStatement.executeUpdate();

                checkresource = "add";
                checkall = "add";
                HttpSession session1 = request.getSession();
                session1.setAttribute("checkresource", checkresource);
                session1.setAttribute("checkall", checkall);
            }
            if (estimate == null || estimate.equals("")) {

            } else {
                int estimateworkload = Integer.parseInt(estimate);
                String uresourceestimateSQL = "UPDATE issuance SET issuance.estimated_workload = ? WHERE issuance.doc_ID = ? AND issuance.iss_index = ?;";
                preparedStatement = connection.prepareStatement(uresourceestimateSQL);
                preparedStatement.setInt(1, estimateworkload);
                preparedStatement.setInt(2, doc_id);
                preparedStatement.setString(3, documentindex);
                preparedStatement.executeUpdate();

                checkestimate = "add";
                checkall = "add";
                HttpSession session1 = request.getSession();
                session1.setAttribute("checkestimate", checkestimate);
                session1.setAttribute("checkall", checkall);
            }
            if (file == null || file.equals("")) {

            } else {
                statement = connection.createStatement();
                String issuanceidSQL = "SELECT issuance.issuance_ID FROM issuance WHERE issuance.doc_ID = " + doc_id + " AND issuance.iss_index = '" + documentindex + "';";
                resultSet = statement.executeQuery(issuanceidSQL);
                int issuanceid = 0;
                if (resultSet.next()) {
                    issuanceid = resultSet.getInt("issuance_ID");
                }

                //delete depart
                String oldfilenameSQL = "SELECT file.file_name, file.file_ID FROM file WHERE file.issuance_ID = " + issuanceid + ";";
                resultSet = statement.executeQuery(oldfilenameSQL);
                String oldfilename = null;
                int fileid = 0;
                if (resultSet.next()) {
                    oldfilename = resultSet.getString("file_name");
                    fileid = resultSet.getInt("file_ID");
                }
                File olddir = new File("C:\\Users\\mario\\OneDrive\\Documents\\NetBeansProjects\\ColasRailEgypt_(CRE)\\web\\files\\" + oldfilename);
                olddir.delete();

//                String deletefileSQL = "DELETE FROM file WHERE file.issuance_ID = " + issuanceid + ";";
//                statement.executeUpdate(deletefileSQL);
                //file department
                String newsourceFile = file.replace("\\", "/");
                String[] splittedFileName = newsourceFile.split("/");
                String simpleFileName = splittedFileName[splittedFileName.length - 1];
                File source = new File(file);
//                FileUtils.deleteDirectory(new File("C:\\Users\\mario\\OneDrive\\Documents\\NetBeansProjects\\ColasRailEgypt_(CRE)\\web\\files\\" + oldfilename));
                File destination = new File("C:\\Users\\mario\\OneDrive\\Documents\\NetBeansProjects\\ColasRailEgypt_(CRE)\\web\\files\\" + simpleFileName);
                try (FileInputStream fis = new FileInputStream(source);
                        FileOutputStream fos = new FileOutputStream(destination)) {
                    byte[] buffer = new byte[4096];
                    int read;
                    while ((read = fis.read(buffer)) != -1) {
                        fos.write(buffer, 0, read);
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }

//                String insertissueSQL = "INSERT INTO file(file_name, issuance_ID) VALUES (?,?);";
                String insertissueSQL = "UPDATE file SET file.file_name = ?, file.issuance_ID = ? WHERE file.file_ID = ?";
                preparedStatement = connection.prepareStatement(insertissueSQL);
                preparedStatement.setString(1, simpleFileName);
                preparedStatement.setInt(2, issuanceid);
                preparedStatement.setInt(3, fileid);
                preparedStatement.executeUpdate();
                //===file department
                //end section

                checkfile = "add";
                checkall = "add";
                HttpSession session1 = request.getSession();
                session1.setAttribute("checkfile", checkfile);
                session1.setAttribute("checkall", checkall);
            }
            if (issuanceindex == null || issuanceindex.equals("")) {

            } else {
                String uresourceindexSQL = "UPDATE issuance SET issuance.iss_index = ? WHERE issuance.doc_ID = ? AND issuance.iss_index = ?;";
                preparedStatement = connection.prepareStatement(uresourceindexSQL);
                preparedStatement.setString(1, issuanceindex);
                preparedStatement.setInt(2, doc_id);
                preparedStatement.setString(3, documentindex);
                preparedStatement.executeUpdate();

                checkissueindex = "add";
                checkall = "add";
                HttpSession session1 = request.getSession();
                session1.setAttribute("checkissueindex", checkissueindex);
                session1.setAttribute("checkall", checkall);
            }

            response.sendRedirect("UpdateIssuance.jsp");
//            RequestDispatcher requestDispatcher = request.getRequestDispatcher("UpdateIssuance.jsp");
//            requestDispatcher.forward(request, response);

        } catch (SQLException ex) {
            Logger.getLogger(UpdateIssuanceServlet.class.getName()).log(Level.SEVERE, null, ex);
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
