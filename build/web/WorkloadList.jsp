
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.sql.Date"%>
<%@page import="classes_package.SetGetWorkloadList"%>
<%@page import="classes_package.SetGetData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="classes_package.ServerConnection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="/ErrorPage.jsp" %>
<%!
    Connection connection = ServerConnection.ConnectionMethod();
    Statement statement = null, statement1 = null;
    ResultSet resultSet = null, resultSet1 = null;

    Date date;
    DateFormat DF = new SimpleDateFormat("dd-MM-yyyy");
    String documentIDstring, WORKLOADDECISION, START, END, PROJECT;
    String[] documentIDarray = new String[6];
    String PROJECTNAME = "", PHASEID = "", ID1 = "", ID2 = "", ID3 = "", ID4 = "", ID5 = "", ID6 = "", ISSAUNCEINDEX = "", DOCUMENTTITLE = "", FORESEENDATE = "", ESTIMATEDWORKLOAD = "", FIRSTNAME = "", LASTNAME = "";
    int RESOURCEID = 0;

    public void changeworkloadlist() {
    }
%>
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Workload list</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="CSS_folder/WorkloadList.css">
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

        <!--popup menu for random period-->
        <form action="WorkloadPeriodAdjustmentServlet">
            <div class="Parent" id="parent">
                <div class="Child" id="child">
                    <input class="Btn" id="btn" onClick="Close()" value="&times;"/>
                    <p>Choose the period of your workload list</p>
                    <div class="PopupDateContent">
                        <label class="PopupPeriodLabel">Start date : </label><input type="date" id="start_period" class="WorkloadDate" name="startDate"/>
                        <label class="PopupPeriodLabel">End date : </label><input type="date" id="end_period" class="WorkloadDate" name="endDate"/>
                        <!--<button>Show period list</button>-->
                        <input type="submit" value="Show period list" class="SUBbtn"/>
                    </div>
                </div>
            </div>
        </form>
        <!--main div-->
        <div class="MainDiv">
            <!--header div-->
            <div class="HeaderDiv">
                <img src="images_folder/colaslogo2.png" alt="Colas logo"/>
                <header>Colas Rail Egypt Documentation Management System<br/><span style="color: #18FC06;">WORKLOAD LIST</span></header>
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
                    <!--dropdown list for random period-->
                    <div class="dropdown">
                        <li id="dropdownli">Fixed Period &nbsp;&nbsp;&nbsp;<i class="fa fa-caret-down"></i></li>
                        <div style="clear: both;"></div>
                        <div class="dropdown-content">
                            <!--                            <form action="OneWeekServlet">
                                                        <button class="WorkloadInsideBtnNav" name="OW" value="oneweek" onclick="func()">One Week</button>
                                                        </form>
                                                        <button class="WorkloadInsideBtnNav">Two Week</button>
                                                        <button class="WorkloadInsideBtnNav">One Month</button>-->
                            <a class="WorkloadInsideBtnNav" href="OneWeekServlet">One Week</a>
                            <a class="WorkloadInsideBtnNav" href="TwoWeekServlet">Two Week</a>
                            <a class="WorkloadInsideBtnNav" href="OneMonthServlet">One Month</a>
                        </div>
                    </div>

                    <div>
                        <li><button class="WorkloadOutBtnNav" name="random_period_btn" onClick="Display()">Random Period</button></li>
                    </div>
                    <li><button class="WorkloadOutBtnNav" name="last_version_button">Last Revision</button></li>
                    <li class="NavList">
                        <form action="WorkloadList.jsp" id="subsystemform" method="post">
                            <select id="subsystem" name="subsystem_select" style="float: left;">
                                <option value="All Subsystems">All Subsystems</option>
                                <%
                                    statement1 = connection.createStatement();
                                    String subsystemSQL = "SELECT section.section_name FROM section;";
                                    resultSet1 = statement1.executeQuery(subsystemSQL);
                                    String subname = request.getParameter("subsystem_select");
                                    if(subname == null) subname = "All Subsystems";
                                    while (resultSet1.next()) {
                                        if (subname.equals(resultSet1.getString("section.section_name"))) {
                                %>
                                <option selected value="<%= resultSet1.getString("section.section_name")%>"><%= resultSet1.getString("section.section_name")%></option>
                                <%
                                } else {
                                %>
                                <option value="<%= resultSet1.getString("section.section_name")%>"><%= resultSet1.getString("section.section_name")%></option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                            <li><button class="WorkloadOutBtnNav" type="submit" style="float: left;">Confirm subsystem</button></li>
                            <!--<li><input type="button" value="Confirm subsystem"/></li>-->
                        </form>
                    </li>
                    <li id="HorRight"><a href="Main.jsp"><i class="fa fa-fw fa-home"></i> Home</a></li>
                </ul>
            </div>
            <!--body div-->
            <div class="BodyDiv">
                <div style="clear: both;"></div>
                <table style="border-bottom: solid 1px black;">
                    <tr>
                        <th rowspan="2" style="width: 5%;">Porject name</th>
                        <th rowspan="2" style="width: 5%;">V model Phase</th>
                        <th colspan="7" style="width: 20%;" class="border">Document ID</th>
                        <th rowspan="2" style="width: 40%;" class="border">Title</th>
                        <th rowspan="2" style="width: 10%;" class="border">Foreseen date</th>
                        <th rowspan="2" style="width: 5%;" class="border">Estimated workload</th>
                        <th rowspan="2" style="width: 10%;">Resource</th>
                        <th rowspan="2" style="width: 5%; background-color: cadetblue;" class="border">Update</th>
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
                        HttpSession session1 = request.getSession();
                        SetGetWorkloadList WORKLOADOBJ = (SetGetWorkloadList) session1.getAttribute("load1");
                        WORKLOADDECISION = WORKLOADOBJ.getWorkloadlist();
                        START = WORKLOADOBJ.getStartperiod();
                        END = WORKLOADOBJ.getEndperiod();

                        SetGetData projectobj = (SetGetData) session1.getAttribute("projectname");
                        PROJECT = projectobj.getProject();

                        statement = connection.createStatement();
                        String sql = null;
                        String subsystem = request.getParameter("subsystem_select");
                        if (subsystem == null || subsystem.equals("All Subsystems")) {
                            if (WORKLOADDECISION == "all") {
                                sql = "SELECT issuance.issuance_ID, project.project_title, document.phase_ID, document.document_ID, issuance.iss_index, document.document_title, issuance.foreseen_send_date, issuance.estimated_workload, resource.first_name, resource.last_name, resource.resources_ID FROM ((document LEFT JOIN issuance ON document.doc_ID = issuance.doc_ID) LEFT JOIN project ON document.project_ID = project.project_ID) LEFT JOIN resource ON issuance.resource_ID = resource.resources_ID WHERE project.project_title = '" + PROJECT + "';";
                            } else if (WORKLOADDECISION == "specificperiod") {
                                sql = "SELECT issuance.issuance_ID, project.project_title, document.phase_ID,issuance.iss_index, document.document_ID, document.document_title, issuance.foreseen_send_date, issuance.estimated_workload, resource.first_name, resource.last_name, resource.resources_ID FROM ((document LEFT JOIN issuance ON document.doc_ID = issuance.doc_ID) LEFT JOIN project ON document.project_ID = project.project_ID) LEFT JOIN resource ON issuance.resource_ID = resource.resources_ID WHERE issuance.foreseen_send_date BETWEEN '" + START + "' AND '" + END + "' AND project.project_title = '" + PROJECT + "';";
                            } else if (WORKLOADDECISION == "oneweek") {
                                sql = "SELECT issuance.issuance_ID, project.project_title, document.phase_ID,issuance.iss_index, document.document_ID, document.document_title, issuance.foreseen_send_date, issuance.estimated_workload, resource.first_name, resource.last_name, resource.resources_ID FROM ((document LEFT JOIN issuance ON document.doc_ID = issuance.doc_ID) LEFT JOIN project ON document.project_ID = project.project_ID) LEFT JOIN resource ON issuance.resource_ID = resource.resources_ID WHERE issuance.foreseen_send_date BETWEEN '" + START + "' AND '" + END + "' AND project.project_title = '" + PROJECT + "';";
                            } else if (WORKLOADDECISION == "twoweek") {
                                sql = "SELECT issuance.issuance_ID, project.project_title, document.phase_ID,issuance.iss_index, document.document_ID, document.document_title, issuance.foreseen_send_date, issuance.estimated_workload, resource.first_name, resource.last_name, resource.resources_ID FROM ((document LEFT JOIN issuance ON document.doc_ID = issuance.doc_ID) LEFT JOIN project ON document.project_ID = project.project_ID) LEFT JOIN resource ON issuance.resource_ID = resource.resources_ID WHERE issuance.foreseen_send_date BETWEEN '" + START + "' AND '" + END + "' AND project.project_title = '" + PROJECT + "';";
                            } else if (WORKLOADDECISION == "onemonth") {
                                sql = "SELECT issuance.issuance_ID, project.project_title, document.phase_ID,issuance.iss_index, document.document_ID, document.document_title, issuance.foreseen_send_date, issuance.estimated_workload, resource.first_name, resource.last_name, resource.resources_ID FROM ((document LEFT JOIN issuance ON document.doc_ID = issuance.doc_ID) LEFT JOIN project ON document.project_ID = project.project_ID) LEFT JOIN resource ON issuance.resource_ID = resource.resources_ID WHERE issuance.foreseen_send_date BETWEEN '" + START + "' AND '" + END + "' AND project.project_title = '" + PROJECT + "';";
                            }
                        } else {
                            if (WORKLOADDECISION == "all") {
                                sql = "SELECT issuance.issuance_ID, project.project_title, document.phase_ID, document.document_ID, issuance.iss_index, document.document_title, issuance.foreseen_send_date, issuance.estimated_workload, resource.first_name, resource.last_name, resource.resources_ID FROM ((document LEFT JOIN issuance ON document.doc_ID = issuance.doc_ID) LEFT JOIN project ON document.project_ID = project.project_ID) LEFT JOIN resource ON issuance.resource_ID = resource.resources_ID INNER JOIN section ON document.section_ID = section.section_ID WHERE project.project_title = '" + PROJECT + "' AND section.section_name = '" + subsystem + "';";
                            } else if (WORKLOADDECISION == "specificperiod") {
                                sql = "SELECT issuance.issuance_ID, project.project_title, document.phase_ID,issuance.iss_index, document.document_ID, document.document_title, issuance.foreseen_send_date, issuance.estimated_workload, resource.first_name, resource.last_name, resource.resources_ID FROM ((document LEFT JOIN issuance ON document.doc_ID = issuance.doc_ID) LEFT JOIN project ON document.project_ID = project.project_ID) LEFT JOIN resource ON issuance.resource_ID = resource.resources_ID INNER JOIN section ON document.section_ID = section.section_ID WHERE issuance.foreseen_send_date BETWEEN '" + START + "' AND '" + END + "' AND project.project_title = '" + PROJECT + "' AND section.section_name = '" + subsystem + "';";
                            } else if (WORKLOADDECISION == "oneweek") {
                                sql = "SELECT issuance.issuance_ID, project.project_title, document.phase_ID,issuance.iss_index, document.document_ID, document.document_title, issuance.foreseen_send_date, issuance.estimated_workload, resource.first_name, resource.last_name, resource.resources_ID FROM ((document LEFT JOIN issuance ON document.doc_ID = issuance.doc_ID) LEFT JOIN project ON document.project_ID = project.project_ID) LEFT JOIN resource ON issuance.resource_ID = resource.resources_ID INNER JOIN section ON document.section_ID = section.section_ID WHERE issuance.foreseen_send_date BETWEEN '" + START + "' AND '" + END + "' AND project.project_title = '" + PROJECT + "' AND section.section_name = '" + subsystem + "';";
                            } else if (WORKLOADDECISION == "twoweek") {
                                sql = "SELECT issuance.issuance_ID, project.project_title, document.phase_ID,issuance.iss_index, document.document_ID, document.document_title, issuance.foreseen_send_date, issuance.estimated_workload, resource.first_name, resource.last_name, resource.resources_ID FROM ((document LEFT JOIN issuance ON document.doc_ID = issuance.doc_ID) LEFT JOIN project ON document.project_ID = project.project_ID) LEFT JOIN resource ON issuance.resource_ID = resource.resources_ID INNER JOIN section ON document.section_ID = section.section_ID WHERE issuance.foreseen_send_date BETWEEN '" + START + "' AND '" + END + "' AND project.project_title = '" + PROJECT + "' AND section.section_name = '" + subsystem + "';";
                            } else if (WORKLOADDECISION == "onemonth") {
                                sql = "SELECT issuance.issuance_ID, project.project_title, document.phase_ID,issuance.iss_index, document.document_ID, document.document_title, issuance.foreseen_send_date, issuance.estimated_workload, resource.first_name, resource.last_name, resource.resources_ID FROM ((document LEFT JOIN issuance ON document.doc_ID = issuance.doc_ID) LEFT JOIN project ON document.project_ID = project.project_ID) LEFT JOIN resource ON issuance.resource_ID = resource.resources_ID INNER JOIN section ON document.section_ID = section.section_ID WHERE issuance.foreseen_send_date BETWEEN '" + START + "' AND '" + END + "' AND project.project_title = '" + PROJECT + "' AND section.section_name = '" + subsystem + "';";
                            }
                        }
                        resultSet = statement.executeQuery(sql);

//                        statement = connection.createStatement();
//                        String sql = "SELECT project.project_title, document.phase_ID, document.document_ID, issaunce.iss_index, document.document_title, issaunce.foreseen_send_date, issaunce.estimated_workload, resource.first_name, resource.last_name FROM ((document LEFT JOIN issaunce ON document.doc_ID = issaunce.doc_ID) LEFT JOIN project ON document.project_ID = project.project_ID) LEFT JOIN resource ON issaunce.resource_ID = resource.resources_ID;";
//                        resultSet = statement.executeQuery(sql);
                        while (resultSet.next()) {
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
//                            FORESEENDATE = resultSet.getString("foreseen_send_date");
//                            if (FORESEENDATE == null) {
//                                FORESEENDATE = "";
//                            }
                            date = resultSet.getDate("foreseen_send_date");
                            if (date == null) {
                                FORESEENDATE = "";
                            } else {
                                FORESEENDATE = DF.format(date);
                                if (FORESEENDATE == null) {
                                    FORESEENDATE = "";
                                }
                            }
                            ESTIMATEDWORKLOAD = resultSet.getString("estimated_workload");
                            if (ESTIMATEDWORKLOAD == null) {
                                ESTIMATEDWORKLOAD = "";
                            }
                            FIRSTNAME = resultSet.getString("first_name");
                            if (FIRSTNAME == null) {
                                FIRSTNAME = "";
                            }
                            LASTNAME = resultSet.getString("last_name");
                            if (LASTNAME == null) {
                                LASTNAME = "";
                            }
                            RESOURCEID = resultSet.getInt("resources_ID");
                    %>
                    <form action="EditWorkloadListData.jsp">
                        <tr id="idformark">
                            <td><%= PROJECTNAME%></td>
                            <td><%= PHASEID%></td>
                            <td class="border"><%= ID1%></td>
                            <td><%= ID2%></td>
                            <td><%= ID3%></td>
                            <td><%= ID4%></td>
                            <td><%= ID5%></td>
                            <td><%= ID6%></td>
                            <td><%= ISSAUNCEINDEX%></td>
                            <td class="border"><%= DOCUMENTTITLE%></td>
                            <td class="border"><%= FORESEENDATE%></td>
                            <td class="border"><%= ESTIMATEDWORKLOAD%></td>
                            <td><%= FIRSTNAME + " " + LASTNAME%></td>
                            <td class="border"><button class="private" type="submit" value="<%=resultSet.getInt("issuance_ID")%>" name="newissid" id="idfordisable">Update</button></td>
                        </tr>
                    </form>
                    <%
                        if (ISSAUNCEINDEX.equals("")) {
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
            </div>
            <!--footer div-->
            <!--            <div class="FooterDiv">
                            <footer>All Data are appeared, if there is no data appeared then this mean that no data founded dependent your specification. <br/>Thanks for your patience</footer>
                        </div>-->
        </div>
        <!--scripts-->
        <script>

            /*--display popup menu for import file--*/
            function Display() {
                document.getElementById("parent").style.display = "block";
            }

            /*--cloase popup menu for import file--*/
            function Close() {
                document.getElementById("parent").style.display = "none";
            }
        </script>
    </body>
</html>
