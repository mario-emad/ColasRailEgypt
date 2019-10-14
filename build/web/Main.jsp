
<%@page import="classes_package.ServerConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="classes_package.SetGetData"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="/ErrorPage.jsp" %>
<%!
    Connection connection = ServerConnection.ConnectionMethod();
    Statement statement = null, statement1 = null, statement2 = null, statement3 = null, statement4 = null;
    ResultSet resultSet = null, resultSet1 = null, resultSet2 = null, resultSet3 = null, resultSet4 = null;
    int numsection = 0;
%>
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>System Main Page</title>
        <link href="CSS_folder/Main.css" rel="stylesheet" type="text/css"/>
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
                <header>Colas Rail Egypt Documentation Management System</header>
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
                    <li><a href="WorkloadPeriodAdjustmentServlet">Work load list</a></li>
                    <li><a href="TimesheetList.jsp">Time Sheet list</a></li>
                    <li><a href="#">Dashboard list</a></li>
                    <li><a href="TechnicalIssueList.jsp">Technical issue list</a></li>
                    <li id="HorRight"><a href="#">Reporting</a></li>
                </ul>
            </div>
            <!--body div-->
            <div class="BodyDiv">
                <!--hor nav bar-->
                <div class="navbar">

                    <div class="dropdown">
                        <button class="dropbtn">Add Items <i class="fa fa-caret-down"></i></button>
                        <div class="dropdown-content">
                            <a href="AddDocument.jsp">Add Document</a>
                            <a href="AddIssuance.jsp">Add Issuance</a>
                            <a href="AddResource.jsp">Add Resource</a>
                            <a href="AddTechnicalIssue.html">Add Technial Issue</a>
                            <a href="AddLetter.jsp">Add Letter</a>
                        </div>
                    </div>

                    <div class="dropdown">
                        <button class="dropbtn">Update Items <i class="fa fa-caret-down"></i></button>
                        <div class="dropdown-content">
                            <a href="UpdateDocument.jsp">Update Document</a>
                            <a href="UpdateIssuance.jsp">Update Issuance</a>
                            <a href="UpdateResource.jsp">Update Resource</a>
                            <a href="UpdateTechnicalIssue.html">Update Technial Issue</a>
                        </div>
                    </div>

                    <a class="DirNavLink" href="DeleteItems.jsp">Delete Items</a>
                    
                    <a class="DirNavLink" href="MainProject.jsp" id="return_project_main">Return to select project</a>

                </div>
                <!--introduction to system-->
                <div class="intro" id="IntroDiv">

                    <!--<p class="WhatProject">Data will be applied for project : Kozika</p>-->

                    <%
                        HttpSession session1 = request.getSession();
                        SetGetData project = (SetGetData) session1.getAttribute("projectname");
                    %>
                    <p style="text-align: center;"><span style="text-decoration: underline;"><%= project.getProject()%></span></p>

                    <p>Project summary</p>
                    <%
//                        statement = connection.createStatement();
//                        String numprojectSQL = "SELECT COUNT(section.section_ID) FROM section;";
//                        resultSet = statement.executeQuery(numprojectSQL);
//                        if (resultSet.next()) {
//                            numsection = resultSet.getInt("COUNT(section.section_ID))");
//                        }
                    %>
                    <table>
                        <tr>
                            <th>Project section</th>
                            <th>Total document</th>
                            <th>Total sent</th>
                            <th>Total APP</th>
                            <th>Total RRS</th>
                        </tr>
                        <%
                            statement = connection.createStatement();
                            String projectnameSQL = "SELECT section.section_name, section.section_ID FROM section;";
                            resultSet = statement.executeQuery(projectnameSQL);
                            while (resultSet.next()) {
                                statement1 = connection.createStatement();
                                String totaldocumentSQL = "SELECT COUNT(document.doc_ID) FROM (document INNER JOIN section ON document.section_ID = section.section_ID) INNER JOIN project ON document.project_ID = project.project_ID WHERE section.section_name = '" + resultSet.getString("section.section_name") + "' AND project.project_title = '" + project.getProject() + "';";
                                resultSet1 = statement1.executeQuery(totaldocumentSQL);
                                while (resultSet1.next()) {
                                    statement2 = connection.createStatement();
                                    String totalsentdocumentSQL = "SELECT COUNT(issuance.issuance_ID) FROM ((issuance INNER JOIN document ON issuance.doc_ID = document.doc_ID) INNER JOIN section ON document.section_ID = section.section_ID) INNER JOIN project ON document.project_ID = project.project_ID WHERE section.section_name = '" + resultSet.getString("section.section_name") + "' AND project.project_title = '" + project.getProject() + "' AND issuance.real_date IS NOT NULL AND issuance.o_n_index = 'R';";
                                    resultSet2 = statement2.executeQuery(totalsentdocumentSQL);
                                    while (resultSet2.next()) {
                                        statement3 = connection.createStatement();
                                        String totalappdocumentSQL = "SELECT COUNT(issuance.issuance_ID) FROM ((issuance INNER JOIN document ON issuance.doc_ID = document.doc_ID) INNER JOIN section ON document.section_ID = section.section_ID) INNER JOIN project ON document.project_ID = project.project_ID WHERE section.section_name = '" + resultSet.getString("section.section_name") + "' AND project.project_title = '" + project.getProject() + "' AND issuance.real_date IS NOT NULL AND issuance.o_n_index = 'R' AND issuance.status = 'APP';";
                                        resultSet3 = statement3.executeQuery(totalappdocumentSQL);
                                        while (resultSet3.next()) {
                                            statement4 = connection.createStatement();
                                            String totalapandocumentSQL = "SELECT COUNT(issuance.issuance_ID) FROM ((issuance INNER JOIN document ON issuance.doc_ID = document.doc_ID) INNER JOIN section ON document.section_ID = section.section_ID) INNER JOIN project ON document.project_ID = project.project_ID WHERE section.section_name = '" + resultSet.getString("section.section_name") + "' AND project.project_title = '" + project.getProject() + "' AND issuance.real_date IS NOT NULL AND issuance.o_n_index = 'R' AND issuance.status = 'APAN';";
                                            resultSet4 = statement4.executeQuery(totalapandocumentSQL);
                                            while (resultSet4.next()) {
                        %>
                        <tr>
                            <td class="fcc"><%= resultSet.getString("section.section_name")%></td>
                            <td><%= resultSet1.getInt("COUNT(document.doc_ID)")%></td>
                            <td><%= resultSet2.getInt("COUNT(issuance.issuance_ID)")%></td>
                            <td><%= resultSet3.getInt("COUNT(issuance.issuance_ID)")%></td>
                            <td><%= resultSet4.getInt("COUNT(issuance.issuance_ID)")%></td>
                        </tr>
                        <%
                                            }
                                        }
                                    }
                                }
                            }
                        %>
                    </table>
                </div>
            </div>
            <!--footer div-->
            <div class="FooterDiv">
                <footer>Copyright &copy; 2019 - Colas Rail Egypt</footer>
            </div>
        </div>
    </body>
</html>
