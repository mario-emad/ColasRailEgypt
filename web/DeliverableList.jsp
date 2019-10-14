
<%@page import="classes_package.SetGetData"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="javax.script.Invocable"%>
<%@page import="javax.script.ScriptEngine"%>
<%@page import="javax.script.ScriptEngineManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="classes_package.ServerConnection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="/ErrorPage.jsp" %>
<%!
    Connection connection = ServerConnection.ConnectionMethod();
    Statement statement = null, statement1 = null, statement2 = null, statement3 = null;
    ResultSet resultSet = null, resultSet1 = null, resultSet2 = null, resultSet3 = null;
    String PROJECT = null;
%>

<%!
    Date todate;
    String date, datestring;
    DateFormat DF = new SimpleDateFormat("yyyy-MM-dd");
    DateFormat DF1 = new SimpleDateFormat("dd-MM-yyyy");
    String documentIDstring = "", issuanceid = "";
    String[] documentIDarray = new String[6];
    String PROJECTNAME = "", PHASEID = "", ID1 = "", ID2 = "", ID3 = "", ID4 = "", ID5 = "", ID6 = "", ISSAUNCEINDEX = "", DOCUMENTTITLE = "", FORESEENDATE = "", REALDATE = "", STATUS = "", ESTIMATEDWORKLOAD = "", str15 = "", ISSUANCE_ID = "", LETTERTITLE = "";
%>
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Deliverabe list</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="CSS_folder/DeliverableList.css">
        <!--scripts-->
        <script>

            /*--display popup menu for import file--*/
            function Display() {
                document.getElementById("parent").style.display = "block";
            }

            /*--cloase popup menu for import file--*/
            function Close() {
                document.getElementById("parent").style.display = "none";
                document.getElementById("popup_file_id").value = "";
            }

            function ListRows() {
                var rowsnumber = document.getElementById("tableid").rows.length;
                document.getElementById("documentnumber").innerHTML = rowsnumber - 2;
            }

            function selectsubsystem(selectedvalue) {
            <%
//                String pro = null;
//                HttpSession session1 = request.getSession();
//                SetGetData projectobj = (SetGetData) session1.getAttribute("projectname");
//                pro = projectobj.getProject();
//                statement3 = connection.createStatement();
//                String subsystemSQL = "SELECT project.project_title, document.phase_ID, document.document_ID, issuance.iss_index, document.document_title, issuance.foreseen_send_date, issuance.real_date, issuance.status, issuance.estimated_workload, issuance.issuance_ID FROM (document LEFT JOIN issuance ON document.doc_ID = issuance.doc_ID) LEFT JOIN project ON document.project_ID = project.project_ID LEFT JOIN section ON document.section_ID = section.section_ID WHERE project.project_title = '" + pro + "' AND section.section_name = '" + selectedvalue + "' UNION SELECT project.project_title, document.phase_ID, document.document_ID, issuance.iss_index, document.document_title, issuance.foreseen_send_date, issuance.real_date, issuance.status, issuance.estimated_workload, issuance.issuance_ID FROM (document RIGHT JOIN issuance ON issuance.doc_ID = document.doc_ID) LEFT JOIN project ON document.project_ID = project.project_ID LEFT JOIN section ON document.section_ID = section.section_ID WHERE project.project_title = '" + pro + "' AND section.section_name = '" + selectedvalue + "';";
            %>
            }


            //////////////////////////////////

//            function addField(argument) {
//                var myTable = document.getElementById("tableid");
//                var currentIndex = myTable.rows.length;
//                var currentRow = myTable.insertRow(-1);
//
//                var linksBox = document.createElement("input");
//                linksBox.setAttribute("name", "links" + currentIndex);
//
//                var keywordsBox = document.createElement("input");
//                keywordsBox.setAttribute("name", "keywords" + currentIndex);
//
//                var violationsBox = document.createElement("input");
//                violationsBox.setAttribute("name", "violationtype" + currentIndex);
//                
//                var RSSBox = document.createElement("input");
//                violationsBox.setAttribute("name", "RSStype" + currentIndex);
//
//                var addRowBox = document.createElement("input");
//                addRowBox.setAttribute("type", "button");
//                addRowBox.setAttribute("value", "Add another line");
//                addRowBox.setAttribute("onclick", "addField();");
//                addRowBox.setAttribute("class", "button");
//
//                var currentCell = currentRow.insertCell(-1);
//                currentCell.appendChild(addRowBox);
//
//                currentCell = currentRow.insertCell(-1);
//                currentCell.appendChild(keywordsBox);
//
//                currentCell = currentRow.insertCell(-1);
//                currentCell.appendChild(violationsBox);
//
//                currentCell = currentRow.insertCell(-1);
//                currentCell.appendChild(linksBox);
//                
//                currentCell = currentRow.insertCell(-1);
//                currentCell.appendChild(RSSBox);
//            }

            //////////////////////////////////

        </script>
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
    </head>
    <%
        //    String username = request.getParameter("user");
        SetGetData userobj = (SetGetData) session.getAttribute("usernameatt");
        String username = userobj.getUser();
    %>
    <body> 
        <!--popup menu-->
        <form action="ImportFileIntoDataBaseServlet">
            <div class="Parent" id="parent">
                <div class="Child" id="child">
                    <input class="Btn" id="closebtn" onClick="Close()" value="&times;">
                    <h1>Import the excel file</h1>
                    <p><span>Warning</span> : Excel file must be arranged by metadata to avoid errors in import process into database.</p>
                    <input type="file" name="file_input_popup" id="popup_file_id" accept="application/msexcel"/>
                    <button id="import_btn" name="import_button_popup">Import file</button>
                    <!--<input type="submit" value="Import file"/>-->
                </div>
            </div>
        </form>
        <!--main div-->
        <div class="MainDiv">
            <!--header div-->
            <div class="HeaderDiv">
                <img src="images_folder/colaslogo2.png" alt="Colas logo"/>
                <header>Colas Rail Egypt Documentation Management System<br/><span style="color: #18FC06;">DELIVERABLE LIST</span></header>
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
                    <li><button id="importtbtn" onClick="Display()">Import File</button></li>
                    <li><form action="ExportDeliverableListServlet"><button type="submit" name="export_button">Export File</button></form></li>
                    <li class="NavList">
                        <form action="DeliverableList.jsp" id="subsystemform" method="post">
                            <select id="subsystem" name="subsystem_select" style="float: left;">
                                <option value="All Subsystems">All Subsystems</option>
                                <%
                                    statement3 = connection.createStatement();
                                    String subsystemSQL = "SELECT section.section_name FROM section;";
                                    resultSet3 = statement3.executeQuery(subsystemSQL);
                                    String subname = request.getParameter("subsystem_select");
                                    if(subname == null) subname = "All Subsystems";
                                    while (resultSet3.next()) {
                                        if (subname.equals(resultSet3.getString("section.section_name"))) {
                                %>
                                <option selected value="<%= resultSet3.getString("section.section_name")%>"><%= resultSet3.getString("section.section_name")%></option>
                                <%
                                } else {
                                %>
                                <option value="<%= resultSet3.getString("section.section_name")%>"><%= resultSet3.getString("section.section_name")%></option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                            <li><button type="submit" style="float: left;">Confirm subsystem</button></li>
                            <!--<li><input type="button" value="Confirm subsystem"/></li>-->
                        </form>
                    </li>
                    <li id="HorRight"><a href="Main.jsp"><i class="fa fa-fw fa-home"></i> Home</a></li>
                </ul>
            </div>
            <!--body div-->
            <div class="BodyDiv">
                <div class="InfoDiv">
                    <!--<p class="ResNum">Index of this menu : <span>A</span></p><p class="ResNum">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p><!--list index a or b or ....-->
                    <p class="ResNum">Number of documents : <span id="documentnumber"></span></p><!--number of documents shown-->
                </div>
                <div style="clear: both;"></div>
                <table id="tableid">
                    <tr id="tablehead">
                        <th rowspan="2" style="width: 5%;" class="left_shadow">Porject name</th>
                        <th rowspan="2" style="width: 5%;" class="left_shadow">V model Phase</th>
                        <th colspan="7" style="width: 10%;" class="border left_shadow">Document ID</th>
                        <th rowspan="2" style="width: 50%;" class="border left_shadow">Title</th>
                        <th colspan="2" style="width: 10%;" class="border left_shadow">Submission Date</th>
                        <th rowspan="2" style="width: 5%;" class="border left_shadow">Status</th>
                        <th rowspan="2" style="width: 5%;" class="left_shadow">Estimated workload</th>
                        <th rowspan="2" style="width: 10%;" class="left_shadow">Letters</th>
                    </tr>
                    <tr>
                        <th class="test border left_shadow"><span>Rubric</span></th>
                        <th class="test left_shadow"><span>Group</span></th>
                        <th class="test left_shadow"><span>Issuer</span></th>
                        <th class="test left_shadow"><span>Lot</span></th>
                        <th class="test left_shadow"><span>Ref</span></th>
                        <th class="test left_shadow"><span>Number</span></th>
                        <th class="test left_shadow"><span>Index</span></th>
                        <th style="width: 50%;" class="border left_shadow">Foreseen date</th>
                        <th style="width: 50%;" class="left_shadow">Real date</th>
                    </tr>
                    <%
                        String sub = request.getParameter("subsystem_select");
//                        System.out.println(sub);
                        int ISSUANCEID = 0;
                        HttpSession session1 = request.getSession();
                        SetGetData projectobj = (SetGetData) session1.getAttribute("projectname");
                        PROJECT = projectobj.getProject();

                        String deliverablelistSQL = "SELECT project.project_title, document.phase_ID, document.document_ID, issuance.iss_index, document.document_title, issuance.foreseen_send_date, issuance.real_date, issuance.status, issuance.estimated_workload, issuance.issuance_ID FROM (document LEFT JOIN issuance ON document.doc_ID = issuance.doc_ID) LEFT JOIN project ON document.project_ID = project.project_ID WHERE project.project_title = '" + PROJECT + "' UNION SELECT project.project_title, document.phase_ID, document.document_ID, issuance.iss_index, document.document_title, issuance.foreseen_send_date, issuance.real_date, issuance.status, issuance.estimated_workload, issuance.issuance_ID FROM (document RIGHT JOIN issuance ON issuance.doc_ID = document.doc_ID) LEFT JOIN project ON document.project_ID = project.project_ID WHERE project.project_title = '" + PROJECT + "';";
                        if (sub == null) {
                            deliverablelistSQL = "SELECT project.project_title, document.phase_ID, document.document_ID, issuance.iss_index, document.document_title, issuance.foreseen_send_date, issuance.real_date, issuance.status, issuance.estimated_workload, issuance.issuance_ID FROM (document LEFT JOIN issuance ON document.doc_ID = issuance.doc_ID) LEFT JOIN project ON document.project_ID = project.project_ID WHERE project.project_title = '" + PROJECT + "' UNION SELECT project.project_title, document.phase_ID, document.document_ID, issuance.iss_index, document.document_title, issuance.foreseen_send_date, issuance.real_date, issuance.status, issuance.estimated_workload, issuance.issuance_ID FROM (document RIGHT JOIN issuance ON issuance.doc_ID = document.doc_ID) LEFT JOIN project ON document.project_ID = project.project_ID WHERE project.project_title = '" + PROJECT + "';";
                        } else if (sub.equals("All Subsystems")) {
                            deliverablelistSQL = "SELECT project.project_title, document.phase_ID, document.document_ID, issuance.iss_index, document.document_title, issuance.foreseen_send_date, issuance.real_date, issuance.status, issuance.estimated_workload, issuance.issuance_ID FROM (document LEFT JOIN issuance ON document.doc_ID = issuance.doc_ID) LEFT JOIN project ON document.project_ID = project.project_ID WHERE project.project_title = '" + PROJECT + "' UNION SELECT project.project_title, document.phase_ID, document.document_ID, issuance.iss_index, document.document_title, issuance.foreseen_send_date, issuance.real_date, issuance.status, issuance.estimated_workload, issuance.issuance_ID FROM (document RIGHT JOIN issuance ON issuance.doc_ID = document.doc_ID) LEFT JOIN project ON document.project_ID = project.project_ID WHERE project.project_title = '" + PROJECT + "';";
                        } else {
                            deliverablelistSQL = "SELECT project.project_title, document.phase_ID, document.document_ID, issuance.iss_index, document.document_title, issuance.foreseen_send_date, issuance.real_date, issuance.status, issuance.estimated_workload, issuance.issuance_ID FROM (document LEFT JOIN issuance ON document.doc_ID = issuance.doc_ID) LEFT JOIN project ON document.project_ID = project.project_ID LEFT JOIN section ON document.section_ID = section.section_ID WHERE project.project_title = '" + PROJECT + "' AND section.section_name = '" + sub + "' UNION SELECT project.project_title, document.phase_ID, document.document_ID, issuance.iss_index, document.document_title, issuance.foreseen_send_date, issuance.real_date, issuance.status, issuance.estimated_workload, issuance.issuance_ID FROM (document RIGHT JOIN issuance ON issuance.doc_ID = document.doc_ID) LEFT JOIN project ON document.project_ID = project.project_ID LEFT JOIN section ON document.section_ID = section.section_ID WHERE project.project_title = '" + PROJECT + "' AND section.section_name = '" + sub + "';";
                        }
//                        String deliverablelistSQL = "SELECT project.project_title, document.phase_ID, document.document_ID, issuance.iss_index, document.document_title, issuance.foreseen_send_date, issuance.real_date, issuance.status, issuance.estimated_workload, issuance.issuance_ID FROM (document LEFT JOIN issuance ON document.doc_ID = issuance.doc_ID) LEFT JOIN project ON document.project_ID = project.project_ID WHERE project.project_title = '" + PROJECT + "' UNION SELECT project.project_title, document.phase_ID, document.document_ID, issuance.iss_index, document.document_title, issuance.foreseen_send_date, issuance.real_date, issuance.status, issuance.estimated_workload, issuance.issuance_ID FROM (document RIGHT JOIN issuance ON issuance.doc_ID = document.doc_ID) LEFT JOIN project ON document.project_ID = project.project_ID WHERE project.project_title = '" + PROJECT + "';";
                        statement = connection.createStatement();
                        resultSet = statement.executeQuery(deliverablelistSQL);
                        ////////////////////////////////////////////
//                        if (resultSet.next()) {
//                            documentIDstring = resultSet.getString("document_ID");
//                            documentIDarray = documentIDstring.split("-");
//                        }
//                        resultSet.beforeFirst();
                        ////////////////////////////////////////////
                        while (resultSet.next()) {
                            ISSUANCE_ID = resultSet.getString("issuance_ID");
                            String letterofissuanceSQL = "SELECT mainletter.letter_title FROM mainletter RIGHT JOIN issuance ON issuance.issuance_ID = mainletter.issuance_ID WHERE issuance.issuance_ID = " + ISSUANCE_ID + " AND mainletter.letter_kind = 'in';";
//                            String letterofissuanceSQL = "SELECT mainletter.letter_title FROM mainletter WHERE mainletter.issuance_ID = " + ISSUANCE_ID + " AND mainletter.letter_kind = 'in';";
                            statement1 = connection.createStatement();
                            resultSet1 = statement1.executeQuery(letterofissuanceSQL);
                            boolean linkexist = true;
                            if (resultSet1.next()) {
                                LETTERTITLE = resultSet1.getString("letter_title");
                            } else {
                                linkexist = false;
                            }
                            String sletterofissuance = "SELECT DISTINCT secondaryletter.s_issuance_id FROM secondaryletter WHERE secondaryletter.s_issuance_id = " + ISSUANCE_ID + ";";
                            statement2 = connection.createStatement();
                            resultSet2 = statement2.executeQuery(sletterofissuance);
                            boolean linkopenexist = true;
                            if (resultSet2.next()) {
                                ISSUANCEID = resultSet2.getInt("s_issuance_id");
                            } else {
                                linkopenexist = false;
                            }

//                            documentCounter++;
                            PROJECTNAME = resultSet.getString("project_title");
                            if (PROJECTNAME == null) {
                                PROJECTNAME = "";
                            }
                            PHASEID = resultSet.getString("phase_ID");
                            /////////////////////////////////////////////
                            documentIDstring = resultSet.getString("document_ID");
                            documentIDarray = documentIDstring.split("-");

                            try {
                                ID1 = documentIDarray[0];
                            } catch (Exception ex) {
                                ID1 = "";
                            }
                            try {
                                ID2 = documentIDarray[1];
                            } catch (Exception ex) {
                                ID2 = "";
                            }
                            try {
                                ID3 = documentIDarray[2];
                            } catch (Exception ex) {
                                ID3 = "";
                            }
                            try {
                                ID4 = documentIDarray[3];
                            } catch (Exception ex) {
                                ID4 = "";
                            }
                            try {
                                ID5 = documentIDarray[4];
                            } catch (Exception ex) {
                                ID5 = "";
                            }
                            try {
                                ID6 = documentIDarray[5];
                            } catch (Exception ex) {
                                ID6 = "";
                            }

//                            str = documentIDstring.split("-");
//                            al = Arrays.asList(str);
                            ////////////////////////////////////////////
                            ISSAUNCEINDEX = resultSet.getString("iss_index");
                            if (ISSAUNCEINDEX == null) {
                                ISSAUNCEINDEX = "";
                            }
                            DOCUMENTTITLE = resultSet.getString("document_title");
                            //-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
//                            FORESEENDATE = resultSet.getString("foreseen_send_date");
//                            if (FORESEENDATE == null) {
//                                FORESEENDATE = "";
//                            }
                            date = resultSet.getString("foreseen_send_date");
                            if (date == null) {
                                FORESEENDATE = "";
                            } else {
                                todate = DF.parse(date);
                                FORESEENDATE = DF1.format(todate);
                                if (FORESEENDATE == null) {
                                    FORESEENDATE = "";
                                }
                            }
                            //-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
                            REALDATE = resultSet.getString("real_date");
                            if (REALDATE == null) {
                                REALDATE = "";
                            }
                            STATUS = resultSet.getString("status");
                            if (STATUS == null) {
                                STATUS = "";
                            }
                            ESTIMATEDWORKLOAD = resultSet.getString("estimated_workload");
                            if (ESTIMATEDWORKLOAD == null) {
                                ESTIMATEDWORKLOAD = "";
                            }
//str15 = 
%>
                    <tr>
                        <td><%= PROJECTNAME%></td>
                        <td><%= PHASEID%></td>

                        <td class="border"><%=  ID1%></td>
                        <td><%= ID2%></td>
                        <td><%=  ID3%></td>
                        <td><%=  ID4%></td>
                        <td><%=  ID5%></td>
                        <td><%=  ID6%></td>
                        <td><%= ISSAUNCEINDEX%></td>
                        <td class="border"><%= DOCUMENTTITLE%></td>
                        <td class="border"><%= FORESEENDATE%></td>
                        <td><input type="date" value="<%= REALDATE%>"/></td>
                            <%if (linkexist == true) {%>
                        <td class="border"><a href="mainletters/<%= LETTERTITLE%>.pdf" target="_blank" name="attached_link"><%= STATUS%></a></td>
                            <%} else {%>
                        <td class="border"></td>
                        <%}%>
                        <td><%= ESTIMATEDWORKLOAD%></td>
                        <%if (linkopenexist == true) {%>
                        <td><a href="SecondaryLetterList.jsp?issuanceID=<%= ISSUANCEID%>">Open</a></td>
                        <%} else {%>
                        <td></td>
                        <%}%>
                    </tr>
                    <%
                        }
                    %>
                </table>
                <!--<input type="button" value="add new document" onclick=""/>-->
                <script>ListRows();</script>
            </div>
            <!--footer div-->
<!--            <div class="FooterDiv">
                <footer>All Data are appeared, if there is no data appeared then this mean that no data founded dependent your specification. <br/>Thanks for your patience</footer>
            </div>-->
        </div>
    </body>
</html>

