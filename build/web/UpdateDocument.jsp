<%-- 
    Document   : UpdateDocument
    Created on : Sep 17, 2019, 11:02:49 AM
    Author     : mario
--%>

<%@page import="classes_package.SetGetData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="classes_package.ServerConnection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Update document</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="CSS_folder/UpdateDocument.css">
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
                <header>Colas Rail Egypt Documentation Management System<br/><span style="color: #18FC06;">UPDATE DOCUMENT</span></header>
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
                <!--form to update document-->
                <!--update document in document table and isuuance table in databse-->
                <form id="udoc_form_id" class="UDocForm" action="UpdateDocumentServlet">
                    <label class="main_label_form">Document Updating Form</label><!--share CSS-->

                    <%
                        HttpSession session1 = request.getSession();

                        String checkudocid = (String) session1.getAttribute("checkudocid"),
                                checkdoctitle = (String) session1.getAttribute("checkdoctitle"),
                                checkdocproject = (String) session1.getAttribute("checkdocproject"),
                                checkdoclist = (String) session1.getAttribute("checkdoclist"),
                                checkdocsection = (String) session1.getAttribute("checkdocsection"),
                                checkdocphase = (String) session1.getAttribute("checkdocphase"),
                                checkall = (String) session1.getAttribute("checkall");

                        if (checkudocid == null) {
                            checkudocid = "no";
                        }
                        if (checkdoctitle == null) {
                            checkdoctitle = "no";
                        }
                        if (checkdocproject == null) {
                            checkdocproject = "no";
                        }
                        if (checkdoclist == null) {
                            checkdoclist = "no";
                        }
                        if (checkdocsection == null) {
                            checkdocsection = "no";
                        }
                        if (checkdocphase == null) {
                            checkdocphase = "no";
                        }
                        if (checkall == "add") {
                    %>
                    <span style="color: green; font-weight: bold;">Congratulations, Your update implemented successfully on (
                        <%
                            if (checkudocid == "add") {
                        %>
                        <%="[ Document ID ]"%>
                        <%
                            }
                            if (checkdoctitle == "add") {
                        %>
                        <%="[ Document title ]"%>
                        <%
                            }
                            if (checkdocproject == "add") {
                        %>
                        <%="[ Document project ]"%>
                        <%
                            }
                            if (checkdoclist == "add") {
                        %>
                        <%="[ Document list ]"%>
                        <%
                            }
                            if (checkdocsection == "add") {
                        %>
                        <%="[ Document section ]"%>
                        <%
                            }
                            if (checkdocphase == "add") {
                        %>
                        <%="[ Document phase ]"%>
                        <%
                            }
                        %>
                        ).</span>
                        <%
                            }
                            checkall = null;
                            session1.setAttribute("checkall", checkall);
                        %>

                    <label class="label_form"><span style="color: red; font-size: 25px;">*</span>Select document ID you want to update</label>
                    <select class="select_form" name="udoc_main_doc_select" required>
                        <option value="">SELECT OPTION</option>
                        <%
                            Connection connection = ServerConnection.ConnectionMethod();
                            Statement statement = connection.createStatement();
                            String documentsidsSQL = "SELECT document.document_ID FROM document;";
                            ResultSet resultSet = statement.executeQuery(documentsidsSQL);
                            while (resultSet.next()) {
                        %>
                        <option><%= resultSet.getString("document_ID")%></option>
                        <%
                            }
                        %>
                    </select>

                    <label class="label_form">Document ID</label>
                    <input class="text_form" type="text" name="udoc_id" id="udocid" placeholder="Enter New Document ID">

                    <label class="label_form">Phase number</label>
                    <select class="select_form" name="udoc_phase_select">
                        <option id="uselected" value="">SELECT OPTION</option>
                        <%
                            statement = connection.createStatement();
                            String phaseidsSQL = "SELECT modelphase.phase_ID FROM modelphase;";
                            resultSet = statement.executeQuery(phaseidsSQL);
                            while (resultSet.next()) {
                        %>
                        <option><%= resultSet.getString("phase_ID")%></option>
                        <%
                            }
                        %>
                    </select>

                    <label class="label_form">Document title</label>
                    <input class="text_form" type="text" name="udoc_title" id="udoctitle" placeholder="Enter New Document Title">

                    <label class="label_form">Project name</label>
                    <!--<input class="text_form" type="text" name="udoc_project_name" id="udocproject" placeholder="Enter Project Name">-->
                    <select class="select_form" name="udoc_project_select">
                        <option id="uselected" value="">SELECT OPTION</option>
                        <%
                            statement = connection.createStatement();
                            String projectSQL = "SELECT project.project_title FROM project;";
                            resultSet = statement.executeQuery(projectSQL);
                            while (resultSet.next()) {
                        %>
                        <option><%= resultSet.getString("project_title")%></option>
                        <%
                            }
                        %>
                    </select>

                    <label class="label_form">List index</label>
                    <input class="text_form" type="text" name="ulist_index" id="ulistindex" placeholder="Enter New List Index">

                    <label class="label_form">Section name</label>
                    <select class="select_form" name="udoc_section_select">
                        <option id="uselected" value="">SELECT OPTION</option>
                        <%
                            statement = connection.createStatement();
                            String sectionSQL = "SELECT section.section_name FROM section;";
                            resultSet = statement.executeQuery(sectionSQL);
                            while (resultSet.next()) {
                        %>
                        <option><%= resultSet.getString("section_name")%></option>
                        <%
                            }
                        %>
                    </select>

                    <div class="tooltip">
                        <button type="submit" class="form_but" style="margin-right: 3%;">Update Document</button>
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
                document.getElementById("udocid").value = "";
//                document.getElementById("uselected").selected = true;
                document.getElementById("udoctitle").value = "";
                document.getElementById("udocproject").value = "";
                document.getElementById("ulistindex").value = "";
            }
        </script>
    </body>
</html>
