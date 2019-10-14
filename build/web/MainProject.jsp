
<%@page import="classes_package.SetGetData"%>
<%@page import="classes_package.ServerConnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="/ErrorPage.jsp" %>
<%!
    Connection connection = ServerConnection.ConnectionMethod();
    Statement statement = null, statement1 = null, statement2 = null, statement3 = null, statement4 = null;
    ResultSet resultSet = null, resultSet1 = null, resultSet2 = null, resultSet3 = null, resultSet4 = null;
    String PROJECTTITLE;
    int numproject = 0;
%>
<!doctype html>
<html>
    <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>System project</title>
        <link href="CSS_folder/MainProject.css" rel="stylesheet" type="text/css"/>
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
            <div class="BodyDiv">
                <form action="SaveProjectServlet" method="post">

                    <label class="label_form">Choose project</label>
                    <select class="select_form" name="base_project" required>
                        <%                            statement = connection.createStatement();
                            String sql = "SELECT project.project_title FROM project;";
                            resultSet = statement.executeQuery(sql);

                            while (resultSet.next()) {
                                PROJECTTITLE = resultSet.getString("project_title");
                        %>
                        <option><%= PROJECTTITLE%></option>
                        <%
                            }
                        %>
                    </select>

                    <button type="submit" class="form_but">Go</button>
                </form>
                <hr/>
                <span id="spansummary">Projects summary</span>
                <%
//                    statement = connection.createStatement();
//                    String numprojectSQL = "SELECT COUNT(project.project_ID) FROM project;";
//                    resultSet = statement.executeQuery(numprojectSQL);
//                    if (resultSet.next()) {
//                        numproject = resultSet.getInt("COUNT(project.project_ID)");
//                    }
                %>
                <table>
                    <tr>
                        <th>Project</th>
                        <th>Total document</th>
                        <th>Total sent</th>
                        <th>Total APP</th>
                        <th>Total RRS</th>
                    </tr>
                    <%                        statement = connection.createStatement();
                        String projectnameSQL = "SELECT project.project_title, project.project_ID FROM project;";
                        resultSet = statement.executeQuery(projectnameSQL);
                        while (resultSet.next()) {
                            statement1 = connection.createStatement();
                            String numdocumentforproject = "SELECT COUNT(document.doc_ID) FROM document WHERE document.project_ID = " + resultSet.getInt("project.project_ID") + ";";
                            resultSet1 = statement1.executeQuery(numdocumentforproject);
                            if (resultSet1.next()) {
                                statement2 = connection.createStatement();
                                String numsentforissuance = "SELECT COUNT(issuance.issuance_ID) FROM (issuance INNER JOIN document ON document.doc_ID = issuance.doc_ID) INNER JOIN project ON document.project_ID = project.project_ID WHERE project.project_title = '" + resultSet.getString("project.project_title") + "' AND issuance.real_date IS NOT NULL AND issuance.o_n_index = 'R';";
                                resultSet2 = statement2.executeQuery(numsentforissuance);
                                if (resultSet2.next()) {
                                    statement3 = connection.createStatement();
                                    String numappforissuance = "SELECT COUNT(issuance.issuance_ID) FROM (issuance INNER JOIN document ON document.doc_ID = issuance.doc_ID) INNER JOIN project ON document.project_ID = project.project_ID WHERE project.project_title = '" + resultSet.getString("project.project_title") + "' AND issuance.real_date IS NOT NULL AND issuance.o_n_index = 'R' AND issuance.status = 'APP';";
                                    resultSet3 = statement3.executeQuery(numappforissuance);
                                    if (resultSet3.next()) {
                                        statement4 = connection.createStatement();
                                        String numapanforissuance = "SELECT COUNT(issuance.issuance_ID) FROM (issuance INNER JOIN document ON document.doc_ID = issuance.doc_ID) INNER JOIN project ON document.project_ID = project.project_ID WHERE project.project_title = '" + resultSet.getString("project.project_title") + "' AND issuance.real_date IS NOT NULL AND issuance.o_n_index = 'R' AND issuance.status = 'RRS';";
                                        resultSet4 = statement4.executeQuery(numapanforissuance);
                                        if (resultSet4.next()) {
                    %>
                    <tr>
                        <td class="fcc"><%= resultSet.getString("project.project_title")%></td>
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
                <div id="prodiv">
                    <span class="headprosec">Project Department</span>
                    <div class="fsadd">
                        <!--<legend>add new project</legend>-->
                        <span class="spandivpro">Add New Project</span>
                        <form action="AddNewProjectServlet" name="newprojectform" id="formaddpro">
                            <input  type="text" placeholder="Create new project" class="createid" name="namepro" required="required"/>
                            <textarea name="textareapro" form="formaddpro" placeholder="Create description of project" class="describeid" ></textarea>
                            <button type="submit" class="createbutid">Insert project</button>
                        </form>
                    </div>
                    <div class="fsdel">
                        <!--<legend>delete project</legend>-->
                        <span class="spandivpro">Delete Project</span>
                        <form action="DeleteProjectServlet" method="post">
                            <select class="selectdelete" name="del_project" required>
                                <%
                                    statement = connection.createStatement();
                                    String delprosql = "SELECT project.project_title FROM project;";
                                    resultSet = statement.executeQuery(delprosql);

                                    while (resultSet.next()) {
                                        PROJECTTITLE = resultSet.getString("project_title");
                                %>
                                <option><%= PROJECTTITLE%></option>
                                <%
                                    }
                                %>
                            </select>
                            <button type="submit" class="deletebutid">Delete project</button>
                        </form>
                    </div>
                </div>
                <div id="secdiv">
                    <span class="headprosec">Section Department</span>
                    <div class="fsadd">
                        <span class="spandivpro">Add New Section</span>
                        <form action="AddNewSectionServlet" name="newsectionform" id="formaddsec">
                            <input  type="text" placeholder="Create new section" class="createid" name="namesec" required="required"/>
                            <textarea name="textareasec" form="formaddpro" placeholder="Create description of section" class="describeid" ></textarea>
                            <button type="submit" class="createbutid">Insert section</button>
                        </form>
                    </div>
                    <div class="fsdel">
                        <!--<legend>delete project</legend>-->
                        <span class="spandivpro">Delete Section</span>
                        <form action="DeleteSectionServlet" method="post">
                            <select class="selectdelete" name="del_section" required>
                                <%
                                    statement = connection.createStatement();
                                    String delsecsql = "SELECT section.section_name FROM section;";
                                    resultSet = statement.executeQuery(delsecsql);

                                    while (resultSet.next()) {
                                        PROJECTTITLE = resultSet.getString("section_name");
                                %>
                                <option><%= PROJECTTITLE%></option>
                                <%
                                    }
                                %>
                            </select>
                            <button type="submit" class="deletebutid">Delete section</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
