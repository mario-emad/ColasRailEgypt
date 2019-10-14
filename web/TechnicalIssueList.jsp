<%-- 
    Document   : TechnicalIssueList
    Created on : Sep 24, 2019, 9:21:10 AM
    Author     : mario
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="classes_package.ServerConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="classes_package.SetGetData"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Technical issue list</title>
        <link rel="stylesheet" type="text/css" href="CSS_folder/TechnicalIssueList.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .test 
            {
                vertical-align: bottom;
                text-align: center;
            }

            .test span 
            {
                -ms-writing-mode: tb-rl;
                -webkit-writing-mode: vertical-rl;
                writing-mode: vertical-rl;
                transform: rotate(180deg);
                white-space: nowrap;
            }
        </style>
        <script>
            function ListRows() {
                var rowsnumber = document.getElementById("tableid").rows.length;
                document.getElementById("documentnumber").innerHTML = rowsnumber - 2;
            }
        </script>
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
                <img src="images_folder/colaslogo2.png" alt="Colas Rail logo">
                <header>Colas Rail Documentation Management System<br><span>Technical issue list</span></header>
                <div id="namelogoid">
                    <span id="usernamespan"><span id="welcomeid">Welcome</span>&nbsp;&nbsp;&nbsp;<span id="usernameid"><%= username%></span></span>
                    <form action="LogoutSystemServlet">
                        <button type="submit" id="logoutid">Logout</button>
                    </form>
                </div>
            </div>
            <!--horizontal navigation div-->
            <div class="NavDiv">
                <ul>
                    <li id="HorRight"><a href="Main.jsp"><i class="fa fa-fw fa-home"></i> Home</a></li>
                </ul>
            </div>
            <!--body div-->
            <div class="BodyDiv">
                <div class="InfoDiv">
                    <p class="ResNum">Number of technical issue : <span id="documentnumber"></span></p>
                </div>
                <div style="clear: both;"></div>
                <table id="tableid">
                    <tr>
                        <th rowspan="2" style="width: 10%;">Date</th>
                        <th colspan="7" style="width: 15%;" class="border">Document ID</th>
                        <th rowspan="2" style="width: 15%;" class="border">Type of problem</th>
                        <th rowspan="2" style="width: 10%;">Assigned to</th>
                        <th rowspan="2" style="width: 50%; word-break: break-all;" class="border">Comment</th>
                    </tr>
                    <tr>
                        <th class="test border"><span>Rubric</span></th>
                        <th class="test"><span>Group</span></th>
                        <th class="test"><span>Issuer</span></th>
                        <th class="test"><span>Lot</span></th>
                        <th class="test"><span>Ref</span></th>
                        <th class="test"><span>Number</span></th>
                        <th class="test"><span>Index</span></th>
                    </tr>
                    <%
                        String id, idarr[], ID1, ID2, ID3, ID4, ID5, ID6;
                        Connection connection = ServerConnection.ConnectionMethod();
                        Statement statement = connection.createStatement();
                        String techSQL = "SELECT technicalissue.technical_date, document.document_ID, issuance.iss_index, technicalissue.problem_type, technicalissue.technical_assigned, technicalissue.technical_notes FROM (technicalissue LEFT JOIN issuance ON technicalissue.issuance_ID = issuance.issuance_ID) LEFT JOIN document ON issuance.doc_ID = document.doc_ID;";
                        ResultSet resultSet = statement.executeQuery(techSQL);
                        while (resultSet.next()) {
                            id = resultSet.getString("document_ID");
                            idarr = id.split("-");
                            try {
                                ID1 = idarr[0];
                            } catch (Exception ex) {
                                ID1 = "";
                            }
                            try {
                                ID2 = idarr[1];
                            } catch (Exception ex) {
                                ID2 = "";
                            }
                            try {
                                ID3 = idarr[2];
                            } catch (Exception ex) {
                                ID3 = "";
                            }
                            try {
                                ID4 = idarr[3];
                            } catch (Exception ex) {
                                ID4 = "";
                            }
                            try {
                                ID5 = idarr[4];
                            } catch (Exception ex) {
                                ID5 = "";
                            }
                            try {
                                ID6 = idarr[5];
                            } catch (Exception ex) {
                                ID6 = "";
                            }
                    %>
                    <tr>
                        <td><%=resultSet.getString("technical_date")%></td>
                        <td class="border"><%=ID1%></td>
                        <td><%=ID2%></td>
                        <td><%=ID3%></td>
                        <td><%=ID4%></td>
                        <td><%=ID5%></td>
                        <td><%=ID6%></td>
                        <td><%=resultSet.getString("iss_index")%></td>
                        <td class="border"><%=resultSet.getString("problem_type")%></td>
                        <td><%=resultSet.getString("technical_assigned")%></td>
                        <td class="border"><%=resultSet.getString("technical_notes")%></td>
                    </tr>
                    <%
                        }
                    %>
                </table>
                <script>ListRows();</script>
            </div>
            <!--footer div-->
            <div class="FooterDiv">
                <footer>Copyright &copy; 2019 - Colas Rail Egypt</footer>
            </div>
        </div>
    </body>
</html>
