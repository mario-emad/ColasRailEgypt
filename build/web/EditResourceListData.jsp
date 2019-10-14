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
        <link rel="stylesheet" type="text/css" href="CSS_folder/EditResoureListData.css"/>
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

        <%
            String fname = null, lname = null, fullname = null, function = null, status = null;
            int resourceid = Integer.parseInt(request.getParameter("resid"));

            Connection connection = ServerConnection.ConnectionMethod();
            Statement statement = connection.createStatement();
            String resSQL = "SELECT resource.resources_ID, resource.first_name, resource.last_name, resource.full_name, function.function_title, status.status_title FROM (resource INNER JOIN function ON resource.function_ID = function.function_ID) INNER JOIN status ON resource.status_ID = status.status_ID WHERE resource.resources_ID = " + resourceid + ";";
            ResultSet resultSet = statement.executeQuery(resSQL);
            if (resultSet.next()) {
//                project = resultSet.getString("project_title");
//                phase = resultSet.getString("phase_ID");
//                documentid = resultSet.getString("document_ID");
//                index = resultSet.getString("iss_index");
//                title = resultSet.getString("document_title");
//                foreseendate = resultSet.getString("foreseen_send_date");
//                estimateworkload = resultSet.getString("estimated_workload");
//                fname = resultSet.getString("first_name");
//                lname = resultSet.getString("last_name");
                fname = resultSet.getString("first_name");
                lname = resultSet.getString("last_name");
                fullname = resultSet.getString("full_name");
                function = resultSet.getString("function_title");
                status = resultSet.getString("status_title");

            }
        %>
        <!--header div-->
        <div class="HeaderDiv">
            <img src="images_folder/colaslogo2.png" alt="Colas logo">
            <header>Documentation Management System</header>
        </div>
        <table>
            <form action="EditResourceListDataServlet" id="editform">
                <tr>
                    <td><label class="label_form"><span>First name</span></label></td>
                    <td><input class="text_form" type="text" value="<%=fname%>" name="fnamename" disabled="true"/></td>
                    <td><img id="fnameimg" src="images_folder/minus.png" style="width: 20px; height: 20px; margin-left: 5px;"/></td>
                </tr>
                <tr>
                    <td><label class="label_form"><span>Last name</span></label></td>
                    <td><input class="text_form" type="text" value="<%=lname%>" name="lnamename" disabled="true"/></td>
                    <td><img id="lnameimg" src="images_folder/minus.png" style="width: 20px; height: 20px; margin-left: 5px;"/></td>
                </tr>
                <tr>
                    <td><label class="label_form"><span>Full name</span></label></td>
                    <td><input class="text_form" type="text" value="<%=fullname%>" name="resname" disabled="true"/></td>
                    <td><img id="resimg" src="images_folder/minus.png" style="width: 20px; height: 20px; margin-left: 5px;"/></td>
                    <input type="hidden" value="<%=fullname%>" name="fullname_name"/>
                </tr>
                <tr>
                    <td><label class="label_form"><span>Functin</span></label></td>
                    <td><input class="text_form" type="text" value="<%=function%>" name="functionname" disabled="true"/></td>
                    <td><img id="funimg" src="images_folder/minus.png" style="width: 20px; height: 20px; margin-left: 5px;"/></td>
                </tr>
                <tr>
                    <td><label class="label_form"><span>Status</span></label></td>
                    <td>
                        <select class="text_form" id="statusid" name="status_select" form="editform" onchange="changed('<%=status%>', this.value, 'statimg')">
                            <option value="" selected></option>
                            <%

                                String fullnameselectSQL = "SELECT status.status_title FROM status;";
                                resultSet = statement.executeQuery(fullnameselectSQL);
                                while (resultSet.next()) {
                                    if (status.equals(resultSet.getString("status_title"))) {
                            %>
                            <option value="<%=resultSet.getString("status_title")%>" selected><%=resultSet.getString("status_title")%></option>
                            <%
                            } else {
                            %>
                            <option value="<%=resultSet.getString("status_title")%>"><%=resultSet.getString("status_title")%></option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </td>
                    <td><img id="statimg" src="images_folder/plus.png" style="width: 20px; height: 20px; margin-left: 5px;"/></td>
                </tr>
                <tr><td colspan="3" style=""><button class="form_but" type="submit">Update data</button></td></tr>
            </form>
        </table>
    </body>
</html>
