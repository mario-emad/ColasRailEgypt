
<%@page import="classes_package.SetGetData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="classes_package.ServerConnection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="/ErrorPage.jsp" %>
<%!
    Connection connection = ServerConnection.ConnectionMethod();
    Statement ststatement = null;
    ResultSet resultSet = null;
%>
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add document</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="CSS_folder/AddDocument.css" rel="stylesheet" type="text/css"/>
    </head>
    <%
        //    String username = request.getParameter("user");
        SetGetData userobj = (SetGetData) session.getAttribute("usernameatt");
        String username = userobj.getUser();
    %>
    <body>
        <div class="MainDiv">
            <!--header div-->
            <div class="HeaderDiv">
                <img src="images_folder/colaslogo2.png" alt="Colas logo"/>
                <header>Colas Rail Egypt Documentation Management System<br/><span style="color: #18FC06;">ADD NEW DOCUMENT</span></header>
                <div id="namelogoid">
                    <span id="usernamespan"><span id="welcomeid">Welcome</span>&nbsp;&nbsp;&nbsp;<span id="usernameid"><%= username%></span></span>
                    <form action="LogoutSystemServlet">
                        <button type="submit" id="logoutid">Logout</button>
                    </form>
                </div>
            </div>
            <!--vertical navigation div-->
            <div class="NavDiv">
                <ul>
                    <li><a href="DeliverableList.jsp">Deliverable list</a></li>
                    <li><a href="ResourceList.jsp">Resource list</a></li>
                    <li><a href="WorkloadList.jsp">Work load list</a></li>
                    <li><a href="TimesheetList.jsp">Time Sheet list</a></li>
                    <li><a href="#">Dashboard list</a></li>
                    <li><a href="TechnicalIssue.jsp">Technical issue list</a></li>
                    <li id="HorRight"><a href="#">Reporting</a></li>
                </ul>
            </div>
            <!--body div-->
            <div class="BodyDiv">
                <!--hor nav bar-->
                <div class="HorNav">
                    <ul>
                        <li id="right"><a href="Main.jsp"><i class="fa fa-fw fa-home"></i> Home</a></li>
                    </ul>
                </div>
                <!--form to add document-->
                <form id="doc_form_id" class="DocForm" action="AddDocumentServlet" method="post">
                    <label class="main_label_form">Document Addition Form</label><!--share CSS-->
                    <%
                        HttpSession session1 = request.getSession();
                        String check = (String) session1.getAttribute("check");
                        if (check == null) {
                            check = "no";
                        }
                        if (check.equals("yes")) {
                    %>
                    <span style="color: red; font-weight: bold;">Sorry, This document already exist.</span>
                    <%
                    } else {
                        if (check.equals("add")) {
                    %>
                    <span style="color: green; font-weight: bold;">Congratulations, Your Document add successfully.</span>
                    <%
                            }
                        }
                        check = null;
                        session1.setAttribute("check", check);
                    %>

                    <label class="label_form">Document ID</label>
                    <input class="text_form" type="text" name="doc_id" id="docid" placeholder="Enter Document ID" required="required">

                    <label class="label_form">Phase number</label>
                    <select class="select_form" name="doc_phase" form="doc_form_id" id="docphase" required="required">
                        <option value="" id="sdocphase">SELECT OPTION</option>
                        <%
                            connection = ServerConnection.ConnectionMethod();
                            ststatement = connection.createStatement();
                            String phaseSQL = "SELECT modelphase.phase_ID FROM modelphase;";
                            resultSet = ststatement.executeQuery(phaseSQL);
                            while (resultSet.next()) {
                        %>
                        <option value="<%= resultSet.getInt("phase_ID")%>"><%= resultSet.getInt("phase_ID")%></option>
                        <%
                            }
                        %>
                    </select>

                    <label class="label_form">Document title</label>
                    <input class="text_form" type="text" name="doc_title" id="doctitle" placeholder="Enter Document Title" required="required">

                    <label class="label_form">Project name</label>
                    <select class="select_form" name="project_name" form="doc_form_id" id="docproject" required="required">
                        <option value="" id="sdocproject">SELECT OPTION</option>
                        <%
                            ststatement = connection.createStatement();
                            String projectSQL = "SELECT project.project_title FROM project;";
                            resultSet = ststatement.executeQuery(projectSQL);
                            while (resultSet.next()) {
                        %>
                        <option><%= resultSet.getString("project_title")%></option>
                        <%
                            }
                        %>
                    </select>

                    <label class="label_form">Section name</label>
                    <select class="select_form" name="section_name" form="doc_form_id" id="docsection" required="required">
                        <option value="" id="sdocsection">SELECT OPTION</option>
                        <%
                            ststatement = connection.createStatement();
                            String sectionSQL = "SELECT section.section_name FROM section;";
                            resultSet = ststatement.executeQuery(sectionSQL);
                            while (resultSet.next()) {
                        %>
                        <option><%= resultSet.getString("section_name")%></option>
                        <%
                            }
                        %>
                    </select>

                    <label class="label_form">List index</label>
                    <select class="select_form" name="list_index" form="doc_form_id" id="doclistindex" required="required">
                        <option value="" id="sdoclistindex">SELECT OPTION</option>
                        <option>A</option>
                        <option>B</option>
                        <option>C</option>
                        <option>D</option>
                        <option>E</option>
                    </select>

                    <div class="tooltip">
                        <button type="submit" class="form_but" onClick="---------- -" style="margin-right: 3%;">Stack document</button>
                        <button type="button" class="form_but" onClick="ClearField()">Adjust default values</button>
                        <!--<span class="tooltiptext">Before stacking your document be ensure about your data.</span>-->
                    </div>
                </form>
            </div>
            <!--footer div-->
            <div class="FooterDiv">
                <footer>Copyright &copy; 2019 - Colas Rail Egypt</footer>
            </div>
        </div>
        <script>
            function ClearField() {
                document.getElementById("docid").value = "";
                document.getElementById("sdocsection").selected = true;
                document.getElementById("sdoclistindex").selected = true;
                document.getElementById("sdocproject").selected = true;
                document.getElementById("sdocphase").selected = true;
                document.getElementById("doctitle").value = "";
            }
        </script>
    </body>
</html>
