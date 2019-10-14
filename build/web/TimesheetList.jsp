<%-- 
    Document   : TimesheetList
    Created on : Sep 22, 2019, 3:18:56 PM
    Author     : mario
--%>

<%@page import="classes_package.SetGetData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="classes_package.ServerConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
    String PROJECT, PROJECTNAME, DOCUMENTID[], INDEX, TITLE, FORESEEN, ESTIMATE, RESOURCE, STARTPRODUCTION, ENDPRODUCTION, PROGRESS, ID1, ID2, ID3, ID4, ID5, ID6;
    int PHASEMODEL, issuanceid;
    Connection connection = ServerConnection.ConnectionMethod();
    Statement statement, statement1;
    ResultSet resultSet, resultSet1;

    Date todate;
    String date, datestring;
    DateFormat DF = new SimpleDateFormat("yyyy-MM-dd");
    DateFormat DF1 = new SimpleDateFormat("dd-MM-yyyy");
%>
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Timesheet list</title>
        <link rel="stylesheet" type="text/css" href="CSS_folder/TimesheetList.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script>
            function ListRows() {
                var rowsnumber = document.getElementById("tabletech").rows.length;
                document.getElementById("documentnumber").innerHTML = rowsnumber - 2;
            }
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
    <%!
        Connection connection2 = ServerConnection.ConnectionMethod();
        Statement statement2;
        ResultSet resultSet2;

    %>
    <body>
        <!--popup menu-->
        <div class="Parent" id="parent">
            <div class="Child" id="child">
                <button class="Btn" id="closebtn" value="" onClick="Close()">&times;</button>

                <!--form to add technical issue-->
                <form id="tech_form_id" class="TechForm" action="InsertTechnicalIssueServlet">
                    <!--					<label class="main_label_form">Technical issue Addition Form</label>-->
                    <h1 class="main_label_form">Add document technical issue</h1>

                    <label class="label_form">Technical issue date</label>
                    <input class="date_form" type="date" name="tech_date" placeholder="Enter technical issue Date"><!--share CSS-->

                    <label class="label_form">Document ID</label>
                    <select class="select_form" name="tech_doc_ID" form="tech_form_id" id="popupselect">
                        <option value=""></option>
                        <%
                            statement2 = connection2.createStatement();
                            String idindexSQL = "SELECT document.document_ID, issuance.iss_index FROM issuance LEFT JOIN document ON issuance.doc_ID = document.doc_ID;";
                            resultSet2 = statement2.executeQuery(idindexSQL);
                            while (resultSet2.next()) {

                        %>
                        <option><%=resultSet2.getString("document_ID") + "-" + resultSet2.getString("iss_index")%></option>
                        <%
                            }
                        %>
                    </select>

                    <!--                    <label class="label_form">Issuance index</label>
                                        <input class="text_form" type="text" name="tech_issue_index" placeholder="Enter Issuance Index">-->

                    <label class="label_form">Problem type</label>
                    <select class="select_form" name="tech_prob_type" form="tech_form_id">
                        <option></option>
                        <option>input muscaning</option>
                        <option>input</option>
                        <option>other</option>
                    </select>

                    <label class="label_form">Resource assigned</label>
                    <select class="select_form" name="tech_res_ass" form="tech_form_id">
                        <option value=""></option>
                        <%
                            statement2 = connection2.createStatement();
                            String resourceSQL = "SELECT resource.full_name FROM resource;";
                            resultSet2 = statement2.executeQuery(resourceSQL);
                            while (resultSet2.next()) {
                        %>
                        <option><%=resultSet2.getString("full_name")%></option>
                        <%
                            }
                        %>
                    </select>

                    <label class="label_form">Comments</label>
                    <textarea class="area_form" name="tech_com" placeholder="Leave your comment..."></textarea>

                    <div class="tooltip">
                        <button type="submit" class="form_but" id="import_btn">Stack technical issue</button>
                        <!--<span class="tooltiptext">Before stacking your import_btncument be ensure about your data.</span>-->
                    </div>
                </form>
            </div>
        </div>
        <%
            //    String username = request.getParameter("user");
            SetGetData userobj = (SetGetData) session.getAttribute("usernameatt");
            String username = userobj.getUser();
        %>
        <!--main div-->
        <div class="MainDiv">
            <!--header div-->
            <div class="HeaderDiv">
                <img src="images_folder/colaslogo2.png" alt="Colas logo"/>
                <header>Colas Rail Egypt Documentation Management System<br/><span style="color: #18FC06;">TIMESHEET LIST</span></header>
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
                    <!--
                    <li><a href="#">Export File</a></li>
                    <li><a href="#">Import File</a></li>
                    <li><a href="#">Last Revision</a></li>
                    -->
                    <li id="HorRight"><a href="Main.jsp"><i class="fa fa-fw fa-home"></i> Home</a></li>
                </ul>
            </div>
            <!--body div-->
            <div class="BodyDiv">
                <div class="InfoDiv">
                    <p class="ResNum">Number of documents : <span id="documentnumber"></span></p><!--number of documents shown-->
                </div>
                <div style="clear: both;"></div>
                <p id="demo"></p>
                <table id="tabletech">
                    <tr>
                        <th rowspan="2" style="width: 5%;">Porject name</th>
                        <th rowspan="2" style="width: 5%;">V model Phase</th>
                        <th colspan="7" style="width: 10%;" class="border">Document ID</th>
                        <th rowspan="2" style="width: 25%;" class="border">Title</th>
                        <th rowspan="2" style="width: 10%;" class="border">Foreseen date</th>
                        <th rowspan="2" style="width: 5%;">Estimated workload</th>
                        <th rowspan="2" style="width: 10%;">Resource</th>
                        <th colspan="2" style="width: 20%;" class="border">Production Date</th>
                        <th rowspan="2" style="width: 5%;" class="border">Progress</th>
                        <th rowspan="2" style="width: 5%; background-color: cadetblue;" class="border special">Update</th>
                    </tr>
                    <tr>
                        <th class="test border"><span>Rubric</span></th>
                        <th class="test"><span>Group</span></th>
                        <th class="test"><span>Issuer</span></th>
                        <th class="test"><span>Lot</span></th>
                        <th class="test"><span>Ref</span></th>
                        <th class="test"><span>Number</span></th>
                        <th class="test"><span>Index</span></th>
                        <th class="border" style="width: 10%;">Start Date</th>
                        <th style="width: 10%;">End Date</th>
                    </tr>
                    <%
                        HttpSession session1 = request.getSession();
                        SetGetData projectobj = (SetGetData) session1.getAttribute("projectname");
                        PROJECT = projectobj.getProject();
                        statement = connection.createStatement();
                        String workloadlistSQL = "SELECT issuance.issuance_ID, project.project_title, document.phase_ID, document.document_ID, issuance.iss_index, document.document_title, issuance.foreseen_send_date, issuance.estimated_workload, resource.first_name, resource.last_name, issuance.production_start_date, issuance.production_end_date, issuance.progress FROM ((document LEFT JOIN issuance ON document.doc_ID = issuance.doc_ID) LEFT JOIN project ON document.project_ID = project.project_ID) LEFT JOIN resource ON issuance.resource_ID = resource.resources_ID WHERE project.project_title = '" + PROJECT + "';";
                        resultSet = statement.executeQuery(workloadlistSQL);
                        while (resultSet.next()) {
                            issuanceid = resultSet.getInt("issuance_ID");
                            PROJECTNAME = resultSet.getString("project_title");
                            PHASEMODEL = resultSet.getInt("phase_ID");

                            String documentid = resultSet.getString("document_ID");
                            DOCUMENTID = documentid.split("-");
                            try {
                                ID1 = DOCUMENTID[0];
                            } catch (Exception ex) {
                                ID1 = "";
                            }
                            try {
                                ID2 = DOCUMENTID[1];
                            } catch (Exception ex) {
                                ID2 = "";
                            }
                            try {
                                ID3 = DOCUMENTID[2];
                            } catch (Exception ex) {
                                ID3 = "";
                            }
                            try {
                                ID4 = DOCUMENTID[3];
                            } catch (Exception ex) {
                                ID4 = "";
                            }
                            try {
                                ID5 = DOCUMENTID[4];
                            } catch (Exception ex) {
                                ID5 = "";
                            }
                            try {
                                ID6 = DOCUMENTID[5];
                            } catch (Exception ex) {
                                ID6 = "";
                            }

                            INDEX = resultSet.getString("iss_index");
                            if (INDEX == null) {
                                INDEX = "";
                            }
                            TITLE = resultSet.getString("document_title");

                            date = resultSet.getString("foreseen_send_date");
                            if (date == null) {
                                FORESEEN = "";
                            } else {
                                todate = DF.parse(date);
                                FORESEEN = DF1.format(todate);
                                if (FORESEEN == null) {
                                    FORESEEN = "";
                                }
                            }
//                            FORESEEN = resultSet.getString("foreseen_send_date");

                            ESTIMATE = resultSet.getString("estimated_workload");
                            if (ESTIMATE == null) {
                                ESTIMATE = "";
                            }

                            String fname, lname;
                            fname = resultSet.getString("first_name");
                            lname = resultSet.getString("last_name");
                            if (fname == null) {
                                fname = "";
                            }
                            if (lname == null) {
                                lname = "";
                            }
                            RESOURCE = fname + " " + lname;

//                            STARTPRODUCTION = resultSet.getString("production_start_date");
                            STARTPRODUCTION = resultSet.getString("production_start_date");
                            if (STARTPRODUCTION == null) {
                                STARTPRODUCTION = "";
                            }
//                      else {
//                                todate = DF.parse(date);
//                                STARTPRODUCTION = DF1.format(todate);
//                                if (STARTPRODUCTION == null) {
//                                    STARTPRODUCTION = "";
//                                }
//                            }

//                            ENDPRODUCTION = resultSet.getString("production_end_date");
                            ENDPRODUCTION = resultSet.getString("production_end_date");
                            if (ENDPRODUCTION == null) {
                                ENDPRODUCTION = "";
                            }
//                        else {
//                                todate = DF.parse(date);
//                                ENDPRODUCTION = DF1.format(todate);
//                                if (ENDPRODUCTION == null) {
//                                    ENDPRODUCTION = "";
//                                }
//                            }System.out.println("end = '" + ENDPRODUCTION + "'");

                            PROGRESS = resultSet.getString("progress");
                            if (PROGRESS == null) {
                                PROGRESS = "";
                            }
                    %><form action="EditTimesheetListData.jsp">
                        <tr id="idformark">
                            <td><%=PROJECTNAME%></td>
                            <td><%=PHASEMODEL%></td>
                            <td class="border"><%=ID1%></td>
                            <td><%=ID2%></td>
                            <td><%=ID3%></td>
                            <td><%=ID4%></td>
                            <td><%=ID5%></td>
                            <td><%=ID6%></td>
                            <td> <%= INDEX%></td>
                            <td class="border"><%=TITLE%></td>
                            <td class="border"><%=FORESEEN%></td>
                            <td><%=ESTIMATE%></td>
                            <td><%=RESOURCE%></td>
                            <td class="border"><%=STARTPRODUCTION%></td>
                            <td><%=ENDPRODUCTION%></td>
                            <td class="border"><%=PROGRESS%></td>
                            <td class="border"><button class="private" type="submit" value="<%=issuanceid%>" name="newissid" id="idfordisable">Update</button></td>
                        </tr></form>
                        <%
                            if (INDEX.equals("")) {
                        %>
                    <script>
                        document.getElementById("idformark").style.backgroundColor = "#aaaaaa";
                        document.getElementById("idfordisable").disabled = true;
                    </script>
                    <%
                        }
                    %>
                    <script>
                        document.getElementById("idformark").id = "";
                        document.getElementById("idfordisable").id = "";
                    </script>
                    <%
                        }
                    %>
                </table>
                <script>ListRows();</script>
            </div>
            <!--footer div-->
<!--            <div class="FooterDiv">
                <footer>Copyright &copy; 2019 - Colas Rail Egypt</footer>
            </div>-->
        </div>
        <!--scripts-->
        <script>

            function editRecord(id) {
                var f = document.form;
                f.method = "post";
                f.action = 'edit.jsp?id=' + id;
                f.submit();
            }

            /*--display popup menu for import file--*/
            function Display() {
                document.getElementById("parent").style.display = "block";
            }

//            var closehelp;
            //open popup menu and select the id that we choose to add technical issue
            function popuptechissue(selectedvalue, docID, docINDEX) {
//                closehelp = selectedvalue;
                if (selectedvalue == 'Technical issue') {
                    document.getElementById("parent").style.display = "block";
                    var id = docID + "-" + docINDEX;
                    var selectmenu = document.getElementById("popupselect");
                    setSelectedValue(selectmenu, id);
                }
                function setSelectedValue(selectObj, valueToSet) {
                    for (var i = 0; i < selectObj.options.length; i++) {
                        if (selectObj.options[i].text == valueToSet) {
                            selectObj.options[i].selected = true;
                            return;
                        }
                    }
                }
                //end section

//				else{
//					document.getElementById('blue').style.display = 'none';
//					document.getElementById('red').style.display = 'block';
//				}

                //var x = document.getElementsByClassName("TimesheetProgressList").;
                //var v = document.getElementById("demo").innerHTML = x;
            }

            /*--cloase popup menu for import file--*/
            function Close() {
                document.getElementById("parent").style.display = "none";
            }

            //----------------------------------------------------------

            //---------------------------------------------------------------

            /*function popuptechissue() {
             var x = document.querySelectorAll(".TimesheetProgressList");
             if (x[1].value == "techissue"){
             document.getElementById("parent").style.display = "block";
             }
             }*/
        </script>
        <style></style>
    </body>
</html>
