<%-- 
    Document   : edit
    Created on : Sep 29, 2019, 11:57:49 AM
    Author     : mario
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="classes_package.ServerConnection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="CSS_folder/EditTimesheetListData.css"/>
        <title>JSP Page</title>
        <script>

            function setSelectedValue(valueToSet) {
                var selectObj = document.getElementById("fullnameid");
                for (var i = 0; i < selectObj.options.length; i++) {
                    if (selectObj.options[i].text == valueToSet) {
                        selectObj.options[i].selected = true;
                        return;
                    }
                }
            }

            //open popup menu and select the id that we choose to add technical issue
            var progress;
            function popuptechissue(selectedvalue, docID, docINDEX, prog) {
                progress = prog;
//                closehelp = selectedvalue;
                if (selectedvalue != progress) {
                    document.getElementById("progimg").src = "images_folder/correct.png";
                    document.getElementById("progimg").style.height = "25px";
                } else {
                    document.getElementById("progimg").src = "images_folder/plus.png";
                    document.getElementById("progimg").style.height = "20px";
                }
                if (selectedvalue == 'Technical issue') {
                    document.getElementById("parent").style.display = "block";
                    var id = docID + "-" + docINDEX;
                    document.getElementById("popupselect").value = id;
                }

                //end section
            }

            function Close() {
                document.getElementById("parent").style.display = "none";
                document.getElementById("myselectid").value = progress;
                document.getElementById("progimg").src = "images_folder/plus.png";
                document.getElementById("progimg").style.height = "20px";
            }

            function changed(oldvar, newvar, id) {
                if (newvar != oldvar) {
                    document.getElementById(id).src = "images_folder/correct.png";
                    document.getElementById(id).style.height = "25px";
                } else {
                    document.getElementById(id).src = "images_folder/plus.png";
                    document.getElementById(id).style.height = "20px";
                }
            }

        </script>
    </head>
    <body>

        <!--popup menu-->
        <div class="Parent" id="parent"  style="display: none;">
            <div class="Child" id="child">
                <button class="Btn" id="closebtn" value="" onClick="Close()">&times;</button>

                <!--form to add technical issue-->
                <form id="tech_form_id" class="TechForm" action="InsertTechnicalIssueServlet">
                    <!--					<label class="main_label_form">Technical issue Addition Form</label>-->
                    <h1 class="main_label_form">Add document technical issue</h1>

                    <label class="label_form">Technical issue date</label>
                    <input class="date_form" type="date" name="tech_date" placeholder="Enter technical issue Date"><!--share CSS--><br/>

                    <label class="label_form">Document ID</label>
                    <input type="text" class="select_form" name="tech_doc_ID" id="popupselect"/><br/>

                    <!--                    <label class="label_form">Issuance index</label>
                                        <input class="text_form" type="text" name="tech_issue_index" placeholder="Enter Issuance Index">-->

                    <label class="label_form">Problem type</label>
                    <select class="select_form" name="tech_prob_type" form="tech_form_id">
                        <option></option>
                        <option>input muscaning</option>
                        <option>input</option>
                        <option>other</option>
                    </select><br/>

                    <label class="label_form">Resource assigned</label>
                    <select class="select_form" name="tech_res_ass" form="tech_form_id">
                        <option value=""></option>
                        <%
                            Connection connection2 = ServerConnection.ConnectionMethod();
                            Statement statement2 = connection2.createStatement();
                            statement2 = connection2.createStatement();
                            String resourceSQL = "SELECT resource.full_name FROM resource;";
                            ResultSet resultSet2 = statement2.executeQuery(resourceSQL);
                            while (resultSet2.next()) {
                        %>
                        <option><%=resultSet2.getString("full_name")%></option>
                        <%
                            }
                        %>
                    </select><br/>

                    <label class="label_form">Comments</label>
                    <textarea class="area_form" name="tech_com" placeholder="Leave your comment..."></textarea><br/>

                    <div class="tooltip">
                        <button type="submit" class="form_but" id="import_btn">Stack technical issue</button>
                        <!--<span class="tooltiptext">Before stacking your import_btncument be ensure about your data.</span>-->
                    </div>
                </form>
            </div>
        </div>

        <%
            String project = null, phase = null, documentid = null, index = null, title = null, foreseendate = null, estimateworkload = null, fname = null, lname = null, resource = null, startpro = null, endpro = null, progress = null, fullname = null;

            int issid = Integer.parseInt(request.getParameter("newissid"));
        %>
        <input type="hidden" name="indid" value="<%=issid%>" form="tech_form_id"/>
        <%
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

        %>
        <!--header div-->
        <div class="HeaderDiv">
            <img src="images_folder/colaslogo2.png" alt="Colas logo">
            <header>Documentation Management System</header>
        </div>
        <table>
            <form action="EditTimesheetListDataServlet" id="editform">
                <tr><%if (project == null) {
                        project = "";
                    }%>
                    <td><label class="label_form"><span>Project : </span></label></td>
                    <td><input class="text_form" type="text" value="<%=project%>" name="projectid" disabled="true"/></td>
                    <td><img id="projimg" src="images_folder/minus.png" style="width: 20px; height: 20px; margin-left: 5px;"/></td>
                </tr>
                <tr><%if (phase == null) {
                        phase = "";
                    }%>
                    <td><label class="label_form"><span>Phase : </span></label></td>
                    <td><input class="text_form" type="text" value="<%=phase%>" name="phaseid" disabled="true"/></td>
                    <td><img id="phaseimg" src="images_folder/minus.png" style="width: 20px; height: 20px; margin-left: 5px;"/></td>
                </tr>
                <tr><%if (documentid == null) {
                        documentid = "";
                    }%>
                    <td><label class="label_form"><span>Document ID : </span></label></td>
                    <td><input class="text_form" type="text" value="<%=documentid%>" name="docidid" disabled="true"/></td>
                    <td><img id="docidimg" src="images_folder/minus.png" style="width: 20px; height: 20px; margin-left: 5px;"/></td>
                <input type="hidden" value="<%=documentid%>" name="docidid"/>
                </tr>
                <tr><%if (index == null) {
                        index = "";
                    }%>
                    <td><label class="label_form"><span>Index : </span></label></td>
                    <td><input class="text_form" type="text" value="<%=index%>" name="indexid" disabled="true"/></td>
                    <td><img id="indimg" src="images_folder/minus.png" style="width: 20px; height: 20px; margin-left: 5px;"/></td>
                <input type="hidden" value="<%=index%>" name="indexid"/>
                </tr>
                <tr><%if (title == null) {
                        title = "";
                    }%>
                    <td><label class="label_form"><span>Title : </span></label></td>
                    <td><input class="text_form" type="text" value="<%=title%>" name="titleid" disabled="true"/></td>
                    <td><img id="titleimg" src="images_folder/minus.png" style="width: 20px; height: 20px; margin-left: 5px;"/></td>
                </tr>
                <!--                <tr>
                                    <td><span>First name : </span></td>
                                    <td><input type="text" value="<%=fname%>" name="fnameid"/></td>
                                </tr>
                                <tr>
                                    <td><span>Last name : </span></td>
                                    <td><input type="text" value="<%=lname%>" name="lnameid"/></td>
                                </tr>-->
                <tr>
                    <td><label class="label_form"><span>Full name : </span></label></td>
                    <td>
                        <select class="text_form" id="fullnameid" name="res_select" form="editform" onchange="changed('<%=fullname%>', this.value, 'resimg')">
                            <option value="" selected></option>
                            <%

                                String fullnameselectSQL = "SELECT resource.full_name FROM resource;";
                                resultSet = statement.executeQuery(fullnameselectSQL);
                                while (resultSet.next()) {
                                    if (fullname.equals(resultSet.getString("full_name"))) {
                            %>
                            <option value="<%=resultSet.getString("full_name")%>" selected><%=resultSet.getString("full_name")%></option>
                            <%
                            } else {
                            %>
                            <option value="<%=resultSet.getString("full_name")%>"><%=resultSet.getString("full_name")%></option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </td>
                    <td><img id="resimg" src="images_folder/plus.png" style="width: 20px; height: 20px; margin-left: 5px;"/></td>
                </tr>

                <tr><%if (foreseendate == null) {
                        foreseendate = "";
                    }%>
                    <td><label class="label_form"><span>Foreseen date : </span></label></td>
                    <td><input class="text_form" type="text" value="<%=foreseendate%>" name="foreseenid" disabled="true"/></td>
                    <td><img id="foreimg" src="images_folder/minus.png" style="width: 20px; height: 20px; margin-left: 5px;"/></td>
                </tr>
                <tr><%if (estimateworkload == null) {
                        estimateworkload = "";
                    }%>
                    <td><label class="label_form"><span>Estimate workload : </span></label></td>
                    <td><input class="text_form" type="text" value="<%=estimateworkload%>" name="estimateid" disabled="true"/></td>
                    <td><img id="estimg" src="images_folder/minus.png" style="width: 20px; height: 20px; margin-left: 5px;"/></td>
                </tr>
                <tr><%if (startpro == null) {
                        startpro = "";
                    }%>
                    <td><label class="label_form"><span>Production start date : </span></label></td>
                    <td><input class="text_form" type="date" value="<%=startpro%>" name="startid" onchange="changed('<%=startpro%>', this.value, 'startimg')"/></td>
                    <td><img id="startimg" src="images_folder/plus.png" style="width: 20px; height: 20px; margin-left: 5px;"/></td>
                </tr>
                <tr><%if (endpro == null) {
                        endpro = "";
                    }%>
                    <td><label class="label_form"><span>Production end date : </span></label></td>
                    <td><input class="text_form" type="date" value="<%=endpro%>" name="endid" onchange="changed('<%=endpro%>', this.value, 'endimg')"/></td>
                    <td><img id="endimg" src="images_folder/plus.png" style="width: 20px; height: 20px; margin-left: 5px;"/></td>
                </tr>
                <tr><%if (documentid == null) {
                        documentid = "";
                    }%>
                    <td><label class="label_form"><span>Progress : </span></label></td>
                    <td><select class="text_form" onChange="popuptechissue(this.value, '<%=documentid%>', '<%=index%>', '<%=progress%>')" id="myselectid" form="editform" name="myselect">
                            <%
                                if (progress == null || progress.equals("")) {
                                    progress = "";
                                }

                                if (progress.equals("In progress")) {%>
                            <option value=""></option>
                            <option value="In progress" selected>In progress</option>
                            <option value="Technical issue" class="TimesheetProgressList">Technical issue<!--<button onClick="Display()" class="ButTech">Technical issue</button>--></option>
                            <!--<option>Technical issue</option>-->
                            <option value="Finished">Finished</option>
                            <%} else if (progress.equals("Technical issue")) {%>
                            <option value=""></option>
                            <option value="In progress">In progress</option>
                            <option value="Technical issue" class="TimesheetProgressList" selected>Technical issue<!--<button onClick="Display()" class="ButTech">Technical issue</button>--></option>
                            <!--<option>Technical issue</option>-->
                            <option value="Finished">Finished</option>
                            <%} else if (progress.equals("Finished")) {%>
                            <option value=""></option>
                            <option value="In progress">In progress</option>
                            <option value="Technical issue" class="TimesheetProgressList">Technical issue<!--<button onClick="Display()" class="ButTech">Technical issue</button>--></option>
                            <!--<option>Technical issue</option>-->
                            <option value="Finished" selected>Finished</option>
                            <%} else {%>
                            <option value="" selected></option>
                            <option value="In progress">In progress</option>
                            <option value="Technical issue" class="TimesheetProgressList">Technical issue<!--<button onClick="Display()" class="ButTech">Technical issue</button>--></option>
                            <!--<option>Technical issue</option>-->
                            <option value="Finished">Finished</option>
                            <%}%>
                        </select></td>
                    <td><img id="progimg" src="images_folder/plus.png" style="width: 20px; height: 20px; margin-left: 5px;"/></td>
                </tr>
                <tr><td colspan="3" style=""><button class="form_but" type="submit">Update data</button></td></tr>
            </form>
        </table>
    </body>
</html>
