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

public class AddIssuanceServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            int documentid = 0;
            String issueindex;
            String forseendate;
            String realdate = null;
            String status = null;
            String prodstart = null;
            String prodend = null;
            String prgress = null;
            int resource = 0;
            int estimat = 0;
            int company = 0;
            String check = "no";
//            String lastrev = null;
//            String lastnat = null;
            String lastver = null;

            //catch ids of some inserted data.
            //document ID
            Connection connection = ServerConnection.ConnectionMethod();
            String docid = request.getParameter("issue_doc_ID_select");
            Statement statement = connection.createStatement();
            String documentidSQL = "SELECT document.doc_ID FROM document WHERE document.document_ID = '" + docid + "';";
            ResultSet resultSet = statement.executeQuery(documentidSQL);
            if (resultSet.next()) {
                documentid = resultSet.getInt("doc_ID");
            }

            //resource ID
//            String res = request.getParameter("issue_resource_select");
            String res = "";
            if (request.getParameter("issue_resource_select").equals(null) || request.getParameter("issue_resource_select").equals("")) {
                resource = 0;
            } else {
                res = request.getParameter("issue_resource_select");
                String resarr[] = res.split("\\s");
                statement = connection.createStatement();
                String resourceidSQL = "SELECT resource.resources_ID FROM resource WHERE resource.first_name = '" + resarr[0] + "' AND resource.last_name = '" + resarr[1] + "';";
                resultSet = statement.executeQuery(resourceidSQL);
                if (resultSet.next()) {
                    resource = resultSet.getInt("resources_ID");
                }
            }

            //company ID
            String com = "";
            if (request.getParameter("company_select").equals(null) || request.getParameter("company_select").equals("")) {
                company = 0;
            } else {
                com = request.getParameter("company_select");
                statement = connection.createStatement();
                String companyidSQL = "SELECT company.company_ID FROM company WHERE company.company_name = '" + com + "';";
                resultSet = statement.executeQuery(companyidSQL);
                if (resultSet.next()) {
                    company = resultSet.getInt("company_ID");
                }
            }

            //get values from AddIssuance page
            issueindex = request.getParameter("issue_index");
            forseendate = request.getParameter("issue_foreseen_send");

            //real date
            if (request.getParameter("issue_real_send").equals(null) || request.getParameter("issue_real_send").equals("")) {
                realdate = null;
            } else {
                realdate = request.getParameter("issue_real_send");
            }

            //status
            if (request.getParameter("issue_status_select").equals(null) || request.getParameter("issue_status_select").equals("")) {
                status = null;
            } else {
                status = request.getParameter("issue_status_select");
            }

            //production start date
            if (request.getParameter("issue_production_start").equals(null) || request.getParameter("issue_production_start").equals("")) {
                prodstart = null;
            } else {
                prodstart = request.getParameter("issue_production_start");
            }

            //production end date
            if (request.getParameter("issue_production_end").equals(null) || request.getParameter("issue_production_end").equals("")) {
                prodend = null;
            } else {
                prodend = request.getParameter("issue_production_end");
            }

            //progress
            if (request.getParameter("issue_progress_select").equals(null) || request.getParameter("issue_progress_select").equals("")) {
                prgress = null;
            } else {
                prgress = request.getParameter("issue_progress_select");
            }
            
            //estimate
            if (request.getParameter("issue_est_workload").equals(null) || request.getParameter("issue_est_workload").equals("")) {
                estimat = 0;
            } else {
                estimat = Integer.parseInt(request.getParameter("issue_est_workload"));
            }

            //last revision for colas =====
            if (request.getParameterMap().containsKey("lastver")) {
                lastver = request.getParameter("lastver");
            }

//            //last revision for colas
//            if (request.getParameter("lastrev").equals(null) || request.getParameter("lastrev").equals("")) {
//                lastrev = null;
//            } else {
//                lastrev = request.getParameter("lastrev");
//            }
//            
//            //last revision for nat
//            if (request.getParameter("lastnat").equals(null) || request.getParameter("lastnat").equals("")) {
//                lastnat = null;
//            } else {
//                lastnat = request.getParameter("lastnat");
//            }
            Statement statement1 = connection.createStatement();
            String confirmissueSQL = "SELECT issuance.issuance_ID FROM issuance WHERE issuance.doc_ID = " + documentid + " AND issuance.iss_index = '" + issueindex + "';";
            ResultSet resultSet1 = statement1.executeQuery(confirmissueSQL);
            if (resultSet1.next()) {
                check = "yes";
                HttpSession session = request.getSession();
                session.setAttribute("check", check);
                RequestDispatcher requestDispatcher = request.getRequestDispatcher("AddIssuance.jsp");
                requestDispatcher.forward(request, response);
            } else {
                //check for the last revision for Colas, NAT, ACO, ... and replace it with a (null) value to create a new last revision if check box is checked.
                int maxid = 0;
//                String maxindex = null;
                if (request.getParameterMap().containsKey("lastver")) {
                    Connection connection2 = ServerConnection.ConnectionMethod();
                    Statement statement2 = connection2.createStatement();
                    String checklastrevisionvalue = "SELECT MAX(issuance.issuance_ID), MAX(issuance.iss_index) FROM issuance WHERE issuance.doc_ID = " + documentid + ";";
                    ResultSet resultSet2 = statement2.executeQuery(checklastrevisionvalue);
                    if (resultSet2.next()) {
                        maxid = resultSet2.getInt("MAX(issuance.issuance_ID)");
//                        maxindex = resultSet2.getString("MAX(issuance.iss_index)");
                    }
                    String updatelastrevisionvalueR = "UPDATE issuance SET issuance.o_n_index = NULL WHERE issuance.issuance_ID = ?;";
                    PreparedStatement preparedStatement1 = connection2.prepareStatement(updatelastrevisionvalueR);
                    preparedStatement1.setInt(1, maxid);
                    preparedStatement1.executeUpdate();
                }
                Connection connection1 = ServerConnection.ConnectionMethod();
                Statement statement2 = connection1.createStatement();
                String checklastrevisionvalue = "SELECT MAX(issuance.issuance_ID), MAX(issuance.iss_index) FROM issuance WHERE issuance.doc_ID = " + documentid + ";";
                ResultSet resultSet2 = statement2.executeQuery(checklastrevisionvalue);
                if (resultSet2.next()) {
                    maxid = resultSet2.getInt("MAX(issuance.issuance_ID)");
//                    maxindex = resultSet2.getString("MAX(issuance.iss_index)");
                }
                String updatelastrevisionvalueL = "UPDATE issuance SET issuance.last_rev = NULL WHERE issuance.issuance_ID = ?;";
                connection1 = ServerConnection.ConnectionMethod();
                PreparedStatement preparedStatement1 = connection1.prepareStatement(updatelastrevisionvalueL);
                preparedStatement1.setInt(1, maxid);
                preparedStatement1.executeUpdate();
                //End section

                String insertissuanceSQL = "INSERT INTO issuance(issuance.doc_ID, issuance.iss_index, issuance.foreseen_send_date, issuance.real_date, issuance.status, issuance.production_start_date, issuance.production_end_date, issuance.progress, issuance.resource_ID, issuance.company_ID, issuance.estimated_workload, issuance.last_rev, issuance.o_n_index) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?);";
                PreparedStatement preparedStatement = connection.prepareStatement(insertissuanceSQL);
                preparedStatement.setInt(1, documentid);
                preparedStatement.setString(2, issueindex);
                preparedStatement.setString(3, forseendate);
                preparedStatement.setString(4, realdate);
                preparedStatement.setString(5, status);
                preparedStatement.setString(6, prodstart);
                preparedStatement.setString(7, prodend);
                preparedStatement.setString(8, prgress);
                if (resource != 0) {
                    preparedStatement.setInt(9, resource);
                } else {
                    preparedStatement.setString(9, null);
                }
                if (company != 0) {
                    preparedStatement.setInt(10, company);
                } else {
                    preparedStatement.setString(10, null);
                }
                if (estimat != 0) {
                    preparedStatement.setInt(11, estimat);
                } else {
                    preparedStatement.setString(11, null);
                }
                preparedStatement.setString(12, "L");
                preparedStatement.setString(13, lastver);
//                preparedStatement.setString(12, lastrev);
//                preparedStatement.setString(13, lastnat);
                preparedStatement.executeUpdate();

                //file department
                String sourceFile = request.getParameter("issue_file");System.out.println(sourceFile);
//                String newName = request.getParameter("newname");
//                String extention = request.getParameter("fileExtention");
                String newsourceFile = sourceFile.replace("\\", "/");System.out.println(newsourceFile);
                String[] splittedFileName = newsourceFile.split("/");
                String simpleFileName = splittedFileName[splittedFileName.length - 1];
//                String name, extent;
//                String[] splittedName = simpleFileName.split("\\.");
//                name = splittedName[0];
//                extent = splittedName[1];

                File source = new File(sourceFile);System.out.println("11111111");
//            File destination = new File("C://Users//mario//OneDrive//Desktop//share//" + newName + extention);
//            File destination = new File("C://Users//mario//OneDrive//Desktop//share//" + name + "." + extent
                File destination = new File("C:\\Users\\mario\\OneDrive\\Documents\\NetBeansProjects\\ColasRailEgypt_(CRE)\\web\\files\\" + simpleFileName);
                try (FileInputStream fis = new FileInputStream(source);
                        FileOutputStream fos = new FileOutputStream(destination)) {
                    // Define the size of our buffer for buffering file data
                    byte[] buffer = new byte[4096];
                    int read;
                    while ((read = fis.read(buffer)) != -1) {
                        fos.write(buffer, 0, read);
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }

                statement = connection.createStatement();
                String issueidSQL = "SELECT issuance.issuance_ID FROM issuance WHERE issuance.doc_ID = '" + documentid + "' AND issuance.iss_index = '" + issueindex + "';";
                resultSet = statement.executeQuery(issueidSQL);
                int issueid = 0;
                if (resultSet.next()) {
                    issueid = resultSet.getInt("issuance_ID");
                }

                String insertissueSQL = "INSERT INTO file(file_name, issuance_ID) VALUES (?,?);";
                preparedStatement = connection.prepareStatement(insertissueSQL);
                preparedStatement.setString(1, simpleFileName);
                preparedStatement.setInt(2, issueid);
                preparedStatement.executeUpdate();
                //===file department

                
                
                
                
                
                
                
                
                
                
                
                
                
                //letter department
                String sourceLetter = request.getParameter("issue_letter");System.out.println(sourceLetter + "   kokoko");
                String letterkind = request.getParameter("letterradio");System.out.println(letterkind + "   jljljljljl");
//                String newName = request.getParameter("newname");
//                String extention = request.getParameter("fileExtention");
                
                //if there is file and letter kind
                if(!(sourceLetter.equals("")) || sourceLetter != null && !(letterkind.equals("")) || letterkind != null){
                    String newsourceLetter = sourceLetter.replace("\\", "/");
                String[] splittedLetterName = newsourceLetter.split("/");
                String simpleletterName = splittedLetterName[splittedLetterName.length - 1];System.out.println("222222222");
//                String name, extent;
//                String[] splittedName = simpleFileName.split("\\.");
//                name = splittedName[0];
//                extent = splittedName[1];

                File sourceL = new File(sourceLetter);
//            File destination = new File("C://Users//mario//OneDrive//Desktop//share//" + newName + extention);
//            File destination = new File("C://Users//mario//OneDrive//Desktop//share//" + name + "." + extent
                File destinationL = new File("C:\\Users\\mario\\OneDrive\\Documents\\NetBeansProjects\\ColasRailEgypt_(CRE)\\web\\mainletters\\" + simpleletterName);
                try (FileInputStream fisL = new FileInputStream(sourceL);
                        FileOutputStream fosL = new FileOutputStream(destinationL)) {
                    // Define the size of our buffer for buffering file data
                    byte[] buffer = new byte[4096];
                    int read;
                    while ((read = fisL.read(buffer)) != -1) {
                        fosL.write(buffer, 0, read);
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
                
//                String purenamearr[] = simpleletterName.split(".");
//                String purename = purenamearr[0];
                String purenamearr[] = simpleletterName.split(".");
                String purename = purenamearr[0];
                String insertissueLSQL = "INSERT INTO mainletter(letter_title, letter_kind, issuance_ID) VALUES (?,?,?);";
                preparedStatement = connection.prepareStatement(insertissueLSQL);
//                preparedStatement.setString(1, simpleletterName);
                preparedStatement.setString(1, purename);
                preparedStatement.setString(2, letterkind);
                preparedStatement.setInt(3, issueid);
                preparedStatement.executeUpdate();
                //===letter department
                }
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                check = "add";
                HttpSession session1 = request.getSession();
                session1.setAttribute("check", check);
                response.sendRedirect("AddIssuance.jsp");
            }

        } catch (SQLException ex) {
            Logger.getLogger(AddIssuanceServlet.class.getName()).log(Level.SEVERE, null, ex);
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
