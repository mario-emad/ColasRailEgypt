
<%@page import="classes_package.SetGetData"%>
<%@page import="classes_package.ServerConnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
    Connection connection = ServerConnection.ConnectionMethod();
    Statement statement;
    ResultSet resultSet;
%>
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Delete Item</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="CSS_folder/DeleteItems.css">
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
                <header>Colas Rail Egypt Documentation Management System<br/><span style="color: #18FC06;">DELETE ITEM</span></header>
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
                <!--form to delete anything-->
                <div id="del_form_id" class="DelForm">
                    <label class="main_label_form">Deleting Items Form</label><!--share CSS-->

                    <%
                        HttpSession session1 = request.getSession();
                        String checkres = (String) session1.getAttribute("checkres");
                        if (checkres == "done") {
                    %>
                    <span style="color: green; font-weight: bold;">The resource deleted successfully.</span>
                    <%
                        }
                        checkres = "no";
                        session1.setAttribute("checkres", checkres);

                        String checkissue = (String) session1.getAttribute("checkissue");
                        if (checkissue == "done") {
                    %>
                    <span style="color: green; font-weight: bold;">The issuance deleted successfully.</span>
                    <%
                        }
                        checkissue = "no";
                        session1.setAttribute("checkissue", checkissue);

                        String checkdoc = (String) session1.getAttribute("checkdoc");
                        if (checkdoc == "done") {
                    %>
                    <span style="color: green; font-weight: bold;">The Document and its issuance deleted successfully.</span>
                    <%
                        }
                        checkdoc = "no";
                        session1.setAttribute("checkdoc", checkdoc);
                    %>

                    <form action="DeleteDocumentServlet">
                        <label class="label_form">Document ID</label>
                        <select class="select_form" name="delete_document_ID_select">
                            <option>SELECT OPTION</option>
                            <%
                                statement = connection.createStatement();
                                String documentidSQL = "SELECT document.document_ID FROM document;";
                                resultSet = statement.executeQuery(documentidSQL);
                                while (resultSet.next()) {
                            %>
                            <option><%= resultSet.getString("document_ID")%></option>
                            <%
                                }
                            %>
                        </select>

                        <button type="submit" class="del_but">Delete Document</button>
                        <!--<a href="#" class="del_but" style="text-align: center; text-decoration: none; padding-top: 1%;">Delete Document</a>-->
                    </form>

                    <form action="DeleteIssuanceServlet">
                        <label class="label_form">Issuance ID</label>
                        <select class="select_form" name="delete_issuance_select">
                            <option>SELECT OPTION</option>
                            <%
                                statement = connection.createStatement();
                                String issuanceSQL = "SELECT document.document_ID, issuance.iss_index FROM issuance LEFT JOIN document ON issuance.doc_ID = document.doc_ID;";
                                resultSet = statement.executeQuery(issuanceSQL);
                                while (resultSet.next()) {
                            %>
                            <option><%= resultSet.getString("document_ID") + "-" + resultSet.getString("iss_index")%></option>
                            <%
                                }
                            %>
                        </select>


                        <button type="submit" class="del_but">Delete Issaunce</button>
                        <!--<a href="#" class="del_but" style="text-align: center; text-decoration: none; padding-top: 1%;">Delete Issuance</a>-->
                    </form>

                    <form action="DeleteResourceServlet">
                        <label class="label_form">Resource name</label>
                        <select class="select_form" name="delete_resource_select">
                            <option>SELECT OPTION</option>
                            <%
                                statement = connection.createStatement();
                                String resourceSQL = "SELECT resource.first_name, resource.last_name FROM resource;";
                                resultSet = statement.executeQuery(resourceSQL);
                                while (resultSet.next()) {
                            %>
                            <option><%= resultSet.getString("first_name") + " " + resultSet.getString("last_name")%></option>
                            <%
                                }
                            %>
                        </select>

                        <button type="submit" class="del_but">Delete Resource</button>
                        <!--<a href="#" class="del_but" style="text-align: center; text-decoration: none; padding-top: 1%;">Delete Resource</a>-->
                    </form>


                    <!--                    <label class="label_form">Issuance ID of technical issue</label>
                                        <select class="select_form" name="delete_technical_select">
                                            <option></option>
                                            <option>Asada</option>
                                            <option>Bsas</option>
                                            <option>Csas</option>
                                            <option>Ddsada</option>
                                        </select>-->

                    <!--<button type="button" class="del_but" onClick="---------------------- -" name="delete_technical_button">Delete Technical Issue</button>-->
                    <!--////<a href="#" class="del_but" style="text-align: center; text-decoration: none; padding-top: 1%;">Delete Technical Issue</a>-->

                    <!--                    <label class="label_form">Letter title</label>
                                        <select class="select_form" name="delete_technical_select">
                                            <option></option>
                                            <option>Asada</option>
                                            <option>Bsas</option>
                                            <option>Csas</option>
                                            <option>Ddsada</option>
                                        </select>-->

                    <!--<button type="button" class="del_but" onClick="---------------------- -" name="delete_letter_button">Delete Letter</button>-->
                    <!--////<a href="#" class="del_but" style="text-align: center; text-decoration: none; padding-top: 1%;">Delete Letter</a>-->

                    <div class="tooltip">
                        <!--<button type="button" class="form_but" onClick="ClickForm()">Stack document</button>-->
                        <!--<span class="tooltiptext">Before stacking your document be ensure about your data.</span>-->
                    </div>
                </div>
                <!--fixed form delete document-->
            </div>
            <!--footer div-->
            <div class="FooterDiv">
                <footer>Copyright &copy; 2019 - Colas Rail Egypt</footer>
            </div>
        </div>
    </body>
</html>

