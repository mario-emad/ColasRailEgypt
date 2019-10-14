<%-- 
    Document   : UpdateResource
    Created on : Sep 19, 2019, 3:02:39 PM
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
        <title>Update resource</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="CSS_folder/UpdateResource.css">
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
                <header>Colas Rail Egypt Documentation Management System<br/><span style="color: #18FC06;">UPDATE RESOURCE</span></header>
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
                <!--form to update resources-->
                <form id="ures_form_id" class="UResForm" action="UpdateResourceServlet">
                    <label class="main_label_form">Resource updating Form</label><!--share CSS-->

                    <!--update statement-->
                    <%
                        HttpSession session1 = request.getSession();

                        String checkfname = (String) session1.getAttribute("checkfname"),
                                checklname = (String) session1.getAttribute("checklname"),
                                checkfullname = (String) session1.getAttribute("checkfullname"),
                                checkfunction = (String) session1.getAttribute("checkfunction"),
                                checkstatus = (String) session1.getAttribute("checkstatus"),
                                checkall = (String) session1.getAttribute("checkall");

                        if (checkfname == null) {
                            checkfname = "no";
                        }
                        if (checklname == null) {
                            checklname = "no";
                        }
                        if (checkfullname == null) {
                            checkfullname = "no";
                        }
                        if (checkfunction == null) {
                            checkfunction = "no";
                        }
                        if (checkstatus == null) {
                            checkstatus = "no";
                        }
                        if (checkall == "add") {
                    %>
                    <span style="color: green; font-weight: bold;">Congratulations, Your update implemented successfully on (
                        <%
                            if (checkfname == "add") {
                        %>
                        <%="[ First name ]"%>
                        <%
                            }
                            if (checklname == "add") {
                        %>
                        <%="[ Last name ]"%>
                        <%
                            }
                            if (checkfullname == "add") {
                        %>
                        <%="[ Full name ]"%>
                        <%
                            }
                            if (checkfunction == "add") {
                        %>
                        <%="[ Function ]"%>
                        <%
                            }
                            if (checkstatus == "add") {
                        %>
                        <%="[ Status ]"%>
                        <%
                            }
                        %>
                        ).</span>
                        <%
                            }
                            checkall = null;
                            session1.setAttribute("checkall", checkall);
                        %>
                    <!--end section-->
                    
                    <label class="label_form"><span style="color: red; font-size: 25px;">*</span>Select resource you want to update</label>
                    <select class="select_form" name="uissue_resource_select" required="required">
                        <option value="">SELECT OPTION</option>
                        <%
                            Connection connection = ServerConnection.ConnectionMethod();
                            Statement statement = connection.createStatement();
                            String uresourceSQL = "SELECT resource.first_name, resource.last_name, resource.full_name FROM resource;";
                            ResultSet resultSet = statement.executeQuery(uresourceSQL);
                            while (resultSet.next()) {
                        %>
                        <option><%=resultSet.getString("first_name") + " " + resultSet.getString("last_name") + " -> " + resultSet.getString("full_name")%></option>
                        <%
                            }
                        %>
                    </select>

                    <label class="label_form">First Name</label>
                    <input class="text_form" type="text" name="ures_first_name" id="ufname" placeholder="Enter First ID">

                    <label class="label_form">Last Name</label>
                    <input class="text_form" type="text" name="ures_last_name" id="ulname" placeholder="Enter Last ID">

                    <label class="label_form">Full Name</label>
                    <input class="text_form" type="text" name="ures_full_name" id="ufullname" placeholder="Enter Full Name ID">

                    <label class="label_form">Function</label>
                    <select class="select_form" name="ures_function_select">
                        <option value="">SELECT OPTION</option>
                        <%
                            connection = ServerConnection.ConnectionMethod();
                            statement = connection.createStatement();
                            String ufunctionSQL = "SELECT function.function_title FROM function;";
                            resultSet = statement.executeQuery(ufunctionSQL);
                            while (resultSet.next()) {
                        %>
                        <option><%=resultSet.getString("function_title")%></option>
                        <%
                            }
                        %>
                    </select>

                    <label class="label_form">Status</label>
                    <select class="select_form" name="ures_status_select">
                        <option value="">SELECT OPTION</option>
                        <%
                            connection = ServerConnection.ConnectionMethod();
                            statement = connection.createStatement();
                            String ustatusSQL = "SELECT status.status_title FROM status;";
                            resultSet = statement.executeQuery(ustatusSQL);
                            while (resultSet.next()) {
                        %>
                        <option><%=resultSet.getString("status_title")%></option>
                        <%
                            }
                        %>
                    </select>

                    <div class="tooltip">
                        <button type="submit" class="form_but" style="margin-right: 3%;">Update Resource</button>
                        <button type="button" class="form_but" onClick="ClearField()">Adjust default values</button>
                        <!--<span class="tooltiptext">Before stacking your resource be ensure about your data.</span>-->
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
                document.getElementById("ufname").value = "";
                document.getElementById("ulname").value = "";
                document.getElementById("uselectedfunction").selected = true;
                document.getElementById("uselectedstatus").selected = true;
            }
        </script>
    </body>
</html>
