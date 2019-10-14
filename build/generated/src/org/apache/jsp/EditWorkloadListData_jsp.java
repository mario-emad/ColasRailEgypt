package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.ResultSet;
import java.sql.Statement;
import classes_package.ServerConnection;
import java.sql.Connection;

public final class EditWorkloadListData_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <link rel=\"stylesheet\" type=\"text/css\" href=\"CSS_folder/EditTimesheetListData.css\"/>\n");
      out.write("        <title>JSP Page</title>\n");
      out.write("        <script>\n");
      out.write("\n");
      out.write("            function setSelectedValue(valueToSet) {\n");
      out.write("                var selectObj = document.getElementById(\"fullnameid\");\n");
      out.write("                for (var i = 0; i < selectObj.options.length; i++) {\n");
      out.write("                    if (selectObj.options[i].text == valueToSet) {\n");
      out.write("                        selectObj.options[i].selected = true;\n");
      out.write("                        return;\n");
      out.write("                    }\n");
      out.write("                }\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            //open popup menu and select the id that we choose to add technical issue\n");
      out.write("            var progress;\n");
      out.write("            function popuptechissue(selectedvalue, docID, docINDEX, prog) {\n");
      out.write("                progress = prog;\n");
      out.write("//                closehelp = selectedvalue;\n");
      out.write("                if (selectedvalue != progress) {\n");
      out.write("                    document.getElementById(\"progimg\").src = \"images_folder/correct.png\";\n");
      out.write("                    document.getElementById(\"progimg\").style.height = \"25px\";\n");
      out.write("                } else {\n");
      out.write("                    document.getElementById(\"progimg\").src = \"images_folder/plus.png\";\n");
      out.write("                    document.getElementById(\"progimg\").style.height = \"20px\";\n");
      out.write("                }\n");
      out.write("                if (selectedvalue == 'Technical issue') {\n");
      out.write("                    document.getElementById(\"parent\").style.display = \"block\";\n");
      out.write("                    var id = docID + \"-\" + docINDEX;\n");
      out.write("                    document.getElementById(\"popupselect\").value = id;\n");
      out.write("                }\n");
      out.write("\n");
      out.write("                //end section\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            function Close() {\n");
      out.write("                document.getElementById(\"parent\").style.display = \"none\";\n");
      out.write("                document.getElementById(\"myselectid\").value = progress;\n");
      out.write("                document.getElementById(\"progimg\").src = \"images_folder/plus.png\";\n");
      out.write("                document.getElementById(\"progimg\").style.height = \"20px\";\n");
      out.write("            }\n");
      out.write("\n");
      out.write("            function changed(oldvar, newvar, id) {\n");
      out.write("                if (newvar != oldvar) {\n");
      out.write("                    document.getElementById(id).src = \"images_folder/correct.png\";\n");
      out.write("                    document.getElementById(id).style.height = \"25px\";\n");
      out.write("                } else {\n");
      out.write("                    document.getElementById(id).src = \"images_folder/plus.png\";\n");
      out.write("                    document.getElementById(id).style.height = \"20px\";\n");
      out.write("                }\n");
      out.write("            }\n");
      out.write("\n");
      out.write("        </script>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("\n");
      out.write("        <!--popup menu-->\n");
      out.write("        <div class=\"Parent\" id=\"parent\"  style=\"display: none;\">\n");
      out.write("            <div class=\"Child\" id=\"child\">\n");
      out.write("                <button class=\"Btn\" id=\"closebtn\" value=\"\" onClick=\"Close()\">&times;</button>\n");
      out.write("\n");
      out.write("                <!--form to add technical issue-->\n");
      out.write("                <form id=\"tech_form_id\" class=\"TechForm\" action=\"InsertTechnicalIssueServlet\">\n");
      out.write("                    <!--\t\t\t\t\t<label class=\"main_label_form\">Technical issue Addition Form</label>-->\n");
      out.write("                    <h1 class=\"main_label_form\">Add document technical issue</h1>\n");
      out.write("\n");
      out.write("                    <label class=\"label_form\">Technical issue date</label>\n");
      out.write("                    <input class=\"date_form\" type=\"date\" name=\"tech_date\" placeholder=\"Enter technical issue Date\"><!--share CSS--><br/>\n");
      out.write("\n");
      out.write("                    <label class=\"label_form\">Document ID</label>\n");
      out.write("                    <input type=\"text\" class=\"select_form\" name=\"tech_doc_ID\" id=\"popupselect\"/><br/>\n");
      out.write("\n");
      out.write("                    <!--                    <label class=\"label_form\">Issuance index</label>\n");
      out.write("                                        <input class=\"text_form\" type=\"text\" name=\"tech_issue_index\" placeholder=\"Enter Issuance Index\">-->\n");
      out.write("\n");
      out.write("                    <label class=\"label_form\">Problem type</label>\n");
      out.write("                    <select class=\"select_form\" name=\"tech_prob_type\" form=\"tech_form_id\">\n");
      out.write("                        <option></option>\n");
      out.write("                        <option>input muscaning</option>\n");
      out.write("                        <option>input</option>\n");
      out.write("                        <option>other</option>\n");
      out.write("                    </select><br/>\n");
      out.write("\n");
      out.write("                    <label class=\"label_form\">Resource assigned</label>\n");
      out.write("                    <select class=\"select_form\" name=\"tech_res_ass\" form=\"tech_form_id\">\n");
      out.write("                        <option value=\"\"></option>\n");
      out.write("                        ");

                            Connection connection2 = ServerConnection.ConnectionMethod();
                            Statement statement2 = connection2.createStatement();
                            statement2 = connection2.createStatement();
                            String resourceSQL = "SELECT resource.full_name FROM resource;";
                            ResultSet resultSet2 = statement2.executeQuery(resourceSQL);
                            while (resultSet2.next()) {
                        
      out.write("\n");
      out.write("                        <option>");
      out.print(resultSet2.getString("full_name"));
      out.write("</option>\n");
      out.write("                        ");

                            }
                        
      out.write("\n");
      out.write("                    </select><br/>\n");
      out.write("\n");
      out.write("                    <label class=\"label_form\">Comments</label>\n");
      out.write("                    <textarea class=\"area_form\" name=\"tech_com\" placeholder=\"Leave your comment...\"></textarea><br/>\n");
      out.write("\n");
      out.write("                    <div class=\"tooltip\">\n");
      out.write("                        <button type=\"submit\" class=\"form_but\" id=\"import_btn\">Stack technical issue</button>\n");
      out.write("                        <!--<span class=\"tooltiptext\">Before stacking your import_btncument be ensure about your data.</span>-->\n");
      out.write("                    </div>\n");
      out.write("                </form>\n");
      out.write("            </div>\n");
      out.write("        </div>\n");
      out.write("\n");
      out.write("        ");

            String project = null, phase = null, documentid = null, index = null, title = null, foreseendate = null, estimateworkload = null, fname = null, lname = null, resource = null, startpro = null, endpro = null, progress = null, fullname = null;

            int issid = Integer.parseInt(request.getParameter("newissid"));
        
      out.write("\n");
      out.write("        <input type=\"hidden\" name=\"indid\" value=\"");
      out.print(issid);
      out.write("\" form=\"tech_form_id\"/>\n");
      out.write("        ");

            Connection connection = ServerConnection.ConnectionMethod();
            Statement statement = connection.createStatement();
            String uSQL = "SELECT project.project_title, document.phase_ID, document.document_ID, issuance.iss_index, document.document_title, issuance.foreseen_send_date, issuance.estimated_workload, resource.first_name, resource.last_name, issuance.production_start_date, issuance.production_end_date, issuance.progress FROM ((document LEFT JOIN issuance ON document.doc_ID = issuance.doc_ID) LEFT JOIN project ON document.project_ID = project.project_ID) LEFT JOIN resource ON issuance.resource_ID = resource.resources_ID WHERE issuance.issuance_ID = " + issid + ";";
            ResultSet resultSet = statement.executeQuery(uSQL);
            if (resultSet.next()) {
                project = resultSet.getString("project_title");
                phase = resultSet.getString("phase_ID");
                documentid = resultSet.getString("document_ID");
                index = resultSet.getString("iss_index");
                title = resultSet.getString("document_title");
                foreseendate = resultSet.getString("foreseen_send_date");
                estimateworkload = resultSet.getString("estimated_workload");
                fname = resultSet.getString("first_name");
                lname = resultSet.getString("last_name");
//                resource = resultSet.getString("");
                startpro = resultSet.getString("production_start_date");
                endpro = resultSet.getString("production_end_date");
                progress = resultSet.getString("progress");

            }

            String fullnameSQL = "SELECT resource.full_name FROM resource WHERE resource.first_name = '" + fname + "' AND resource.last_name = '" + lname + "';";
            resultSet = statement.executeQuery(fullnameSQL);
            if (resultSet.next()) {
                fullname = resultSet.getString("full_name");
            }
            if (fullname == null) {
                fullname = "";
            }

        
      out.write("\n");
      out.write("        <!--header div-->\n");
      out.write("        <div class=\"HeaderDiv\">\n");
      out.write("            <img src=\"images_folder/colaslogo2.png\" alt=\"Colas logo\">\n");
      out.write("            <header>Documentation Management System</header>\n");
      out.write("        </div>\n");
      out.write("        <table>\n");
      out.write("            <form action=\"EditTimesheetListDataServlet\" id=\"editform\">\n");
      out.write("                <tr></tr>\n");
      out.write("                <tr>");
if (project == null) {
                        project = "";
                    }
      out.write("\n");
      out.write("                    <td><label class=\"label_form\"><span>Project : </span></label></td>\n");
      out.write("                    <td><input class=\"text_form\" type=\"text\" value=\"");
      out.print(project);
      out.write("\" name=\"projectid\" disabled=\"true\"/></td>\n");
      out.write("                    <td><img id=\"projimg\" src=\"images_folder/minus.png\" style=\"width: 20px; height: 20px; margin-left: 5px;\"/></td>\n");
      out.write("                </tr>\n");
      out.write("                <tr>");
if (phase == null) {
                        phase = "";
                    }
      out.write("\n");
      out.write("                    <td><label class=\"label_form\"><span>Phase : </span></label></td>\n");
      out.write("                    <td><input class=\"text_form\" type=\"text\" value=\"");
      out.print(phase);
      out.write("\" name=\"phaseid\" disabled=\"true\"/></td>\n");
      out.write("                    <td><img id=\"phaseimg\" src=\"images_folder/minus.png\" style=\"width: 20px; height: 20px; margin-left: 5px;\"/></td>\n");
      out.write("                </tr>\n");
      out.write("                <tr>");
if (documentid == null) {
                        documentid = "";
                    }
      out.write("\n");
      out.write("                    <td><label class=\"label_form\"><span>Document ID : </span></label></td>\n");
      out.write("                    <td><input class=\"text_form\" type=\"text\" value=\"");
      out.print(documentid);
      out.write("\" name=\"docidid\" disabled=\"true\"/></td>\n");
      out.write("                    <td><img id=\"docidimg\" src=\"images_folder/minus.png\" style=\"width: 20px; height: 20px; margin-left: 5px;\"/></td>\n");
      out.write("                <input type=\"hidden\" value=\"");
      out.print(documentid);
      out.write("\" name=\"docidid\"/>\n");
      out.write("                </tr>\n");
      out.write("                <tr>");
if (index == null) {
                        index = "";
                    }
      out.write("\n");
      out.write("                    <td><label class=\"label_form\"><span>Index : </span></label></td>\n");
      out.write("                    <td><input class=\"text_form\" type=\"text\" value=\"");
      out.print(index);
      out.write("\" name=\"indexid\" disabled=\"true\"/></td>\n");
      out.write("                    <td><img id=\"indimg\" src=\"images_folder/minus.png\" style=\"width: 20px; height: 20px; margin-left: 5px;\"/></td>\n");
      out.write("                <input type=\"hidden\" value=\"");
      out.print(index);
      out.write("\" name=\"indexid\"/>\n");
      out.write("                </tr>\n");
      out.write("                <tr>");
if (title == null) {
                        title = "";
                    }
      out.write("\n");
      out.write("                    <td><label class=\"label_form\"><span>Title : </span></label></td>\n");
      out.write("                    <td><input class=\"text_form\" type=\"text\" value=\"");
      out.print(title);
      out.write("\" name=\"titleid\" disabled=\"true\"/></td>\n");
      out.write("                    <td><img id=\"titleimg\" src=\"images_folder/minus.png\" style=\"width: 20px; height: 20px; margin-left: 5px;\"/></td>\n");
      out.write("                </tr>\n");
      out.write("                <!--                <tr>\n");
      out.write("                                    <td><span>First name : </span></td>\n");
      out.write("                                    <td><input type=\"text\" value=\"");
      out.print(fname);
      out.write("\" name=\"fnameid\"/></td>\n");
      out.write("                                </tr>\n");
      out.write("                                <tr>\n");
      out.write("                                    <td><span>Last name : </span></td>\n");
      out.write("                                    <td><input type=\"text\" value=\"");
      out.print(lname);
      out.write("\" name=\"lnameid\"/></td>\n");
      out.write("                                </tr>-->\n");
      out.write("                <tr>\n");
      out.write("                    <td><label class=\"label_form\"><span>Full name : </span></label></td>\n");
      out.write("                    <td>\n");
      out.write("                        <select class=\"text_form\" id=\"fullnameid\" name=\"res_select\" form=\"editform\" onchange=\"changed('");
      out.print(fullname);
      out.write("', this.value, 'resimg')\">\n");
      out.write("                            <option value=\"\" selected></option>\n");
      out.write("                            ");


                                String fullnameselectSQL = "SELECT resource.full_name FROM resource;";
                                resultSet = statement.executeQuery(fullnameselectSQL);
                                while (resultSet.next()) {
                                    if (fullname.equals(resultSet.getString("full_name"))) {
                            
      out.write("\n");
      out.write("                            <option value=\"");
      out.print(resultSet.getString("full_name"));
      out.write("\" selected>");
      out.print(resultSet.getString("full_name"));
      out.write("</option>\n");
      out.write("                            ");

                            } else {
                            
      out.write("\n");
      out.write("                            <option value=\"");
      out.print(resultSet.getString("full_name"));
      out.write('"');
      out.write('>');
      out.print(resultSet.getString("full_name"));
      out.write("</option>\n");
      out.write("                            ");

                                    }
                                }
                            
      out.write("\n");
      out.write("                        </select>\n");
      out.write("                    </td>\n");
      out.write("                    <td><img id=\"resimg\" src=\"images_folder/plus.png\" style=\"width: 20px; height: 20px; margin-left: 5px;\"/></td>\n");
      out.write("                </tr>\n");
      out.write("\n");
      out.write("                <tr>");
if (foreseendate == null) {
                        foreseendate = "";
                    }
      out.write("\n");
      out.write("                    <td><label class=\"label_form\"><span>Foreseen date : </span></label></td>\n");
      out.write("                    <td><input class=\"text_form\" type=\"text\" value=\"");
      out.print(foreseendate);
      out.write("\" name=\"foreseenid\" disabled=\"true\"/></td>\n");
      out.write("                    <td><img id=\"foreimg\" src=\"images_folder/minus.png\" style=\"width: 20px; height: 20px; margin-left: 5px;\"/></td>\n");
      out.write("                </tr>\n");
      out.write("                <tr>");
if (estimateworkload == null) {
                        estimateworkload = "";
                    }
      out.write("\n");
      out.write("                    <td><label class=\"label_form\"><span>Estimate workload : </span></label></td>\n");
      out.write("                    <td><input class=\"text_form\" type=\"text\" value=\"");
      out.print(estimateworkload);
      out.write("\" name=\"estimateid\" disabled=\"true\"/></td>\n");
      out.write("                    <td><img id=\"estimg\" src=\"images_folder/minus.png\" style=\"width: 20px; height: 20px; margin-left: 5px;\"/></td>\n");
      out.write("                </tr>\n");
      out.write("                <tr>");
if (startpro == null) {
                        startpro = "";
                    }
      out.write("\n");
      out.write("                    <td><label class=\"label_form\"><span>Production start date : </span></label></td>\n");
      out.write("                    <td><input class=\"text_form\" type=\"date\" value=\"");
      out.print(startpro);
      out.write("\" name=\"startid\" onchange=\"changed('");
      out.print(startpro);
      out.write("', this.value, 'startimg')\"/></td>\n");
      out.write("                    <td><img id=\"startimg\" src=\"images_folder/plus.png\" style=\"width: 20px; height: 20px; margin-left: 5px;\"/></td>\n");
      out.write("                </tr>\n");
      out.write("                <tr>");
if (endpro == null) {
                        endpro = "";
                    }
      out.write("\n");
      out.write("                    <td><label class=\"label_form\"><span>Production end date : </span></label></td>\n");
      out.write("                    <td><input class=\"text_form\" type=\"date\" value=\"");
      out.print(endpro);
      out.write("\" name=\"endid\" onchange=\"changed('");
      out.print(endpro);
      out.write("', this.value, 'endimg')\"/></td>\n");
      out.write("                    <td><img id=\"endimg\" src=\"images_folder/plus.png\" style=\"width: 20px; height: 20px; margin-left: 5px;\"/></td>\n");
      out.write("                </tr>\n");
      out.write("                <tr>");
if (documentid == null) {
                        documentid = "";
                    }
      out.write("\n");
      out.write("                    <td><label class=\"label_form\"><span>Progress : </span></label></td>\n");
      out.write("                    <td><select class=\"text_form\" onChange=\"popuptechissue(this.value, '");
      out.print(documentid);
      out.write("', '");
      out.print(index);
      out.write("', '");
      out.print(progress);
      out.write("')\" id=\"myselectid\" form=\"editform\" name=\"myselect\">\n");
      out.write("                            ");

                                if (progress == null || progress.equals("")) {
                                    progress = "";
                                }

                                if (progress.equals("In progress")) {
      out.write("\n");
      out.write("                            <option value=\"\"></option>\n");
      out.write("                            <option value=\"In progress\" selected>In progress</option>\n");
      out.write("                            <option value=\"Technical issue\" class=\"TimesheetProgressList\">Technical issue<!--<button onClick=\"Display()\" class=\"ButTech\">Technical issue</button>--></option>\n");
      out.write("                            <!--<option>Technical issue</option>-->\n");
      out.write("                            <option value=\"Finished\">Finished</option>\n");
      out.write("                            ");
} else if (progress.equals("Technical issue")) {
      out.write("\n");
      out.write("                            <option value=\"\"></option>\n");
      out.write("                            <option value=\"In progress\">In progress</option>\n");
      out.write("                            <option value=\"Technical issue\" class=\"TimesheetProgressList\" selected>Technical issue<!--<button onClick=\"Display()\" class=\"ButTech\">Technical issue</button>--></option>\n");
      out.write("                            <!--<option>Technical issue</option>-->\n");
      out.write("                            <option value=\"Finished\">Finished</option>\n");
      out.write("                            ");
} else if (progress.equals("Finished")) {
      out.write("\n");
      out.write("                            <option value=\"\"></option>\n");
      out.write("                            <option value=\"In progress\">In progress</option>\n");
      out.write("                            <option value=\"Technical issue\" class=\"TimesheetProgressList\">Technical issue<!--<button onClick=\"Display()\" class=\"ButTech\">Technical issue</button>--></option>\n");
      out.write("                            <!--<option>Technical issue</option>-->\n");
      out.write("                            <option value=\"Finished\" selected>Finished</option>\n");
      out.write("                            ");
} else {
      out.write("\n");
      out.write("                            <option value=\"\" selected></option>\n");
      out.write("                            <option value=\"In progress\">In progress</option>\n");
      out.write("                            <option value=\"Technical issue\" class=\"TimesheetProgressList\">Technical issue<!--<button onClick=\"Display()\" class=\"ButTech\">Technical issue</button>--></option>\n");
      out.write("                            <!--<option>Technical issue</option>-->\n");
      out.write("                            <option value=\"Finished\">Finished</option>\n");
      out.write("                            ");
}
      out.write("\n");
      out.write("                        </select></td>\n");
      out.write("                    <td><img id=\"progimg\" src=\"images_folder/plus.png\" style=\"width: 20px; height: 20px; margin-left: 5px;\"/></td>\n");
      out.write("                </tr>\n");
      out.write("                <tr><td colspan=\"3\" style=\"\"><button class=\"form_but\" type=\"submit\">Update data</button></td></tr>\n");
      out.write("            </form>\n");
      out.write("        </table>\n");
      out.write("    </body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
