<%-- 
    Document   : UpdateIssuance
    Created on : Sep 18, 2019, 9:30:21 AM
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
        <title>Update issuance</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="CSS_folder/UpdateIssuance.css">
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
                <header>Colas Rail Egypt Documentation Management System<br/><span style="color: #18FC06;">UPDATE ISSUANCE</span></header>
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
                <!--form to update issuance-->
                <form id="uissue_form_id" class="UIssueForm" action="UpdateIssuanceServlet">
                    <label class="main_label_form">Issuance Updating Form</label><!--share CSS-->

                    <!--updating statement-->
                    <%
                        HttpSession session1 = request.getSession();

                        String checkissueindex = (String) session1.getAttribute("checkissueindex"),
                                checkforeseen = (String) session1.getAttribute("checkforeseen"),
                                checkreal = (String) session1.getAttribute("checkreal"),
                                checkstatus = (String) session1.getAttribute("checkstatus"),
                                checkprodstart = (String) session1.getAttribute("checkprodstart"),
                                checkprodend = (String) session1.getAttribute("checkprodend"),
                                checkprogress = (String) session1.getAttribute("checkprogress"),
                                checkresource = (String) session1.getAttribute("checkresource"),
                                checkestimate = (String) session1.getAttribute("checkestimate"),
                                checkfile = (String) session1.getAttribute("checkfile"),
                                checkall = (String) session1.getAttribute("checkall");

                        if (checkissueindex == null) {
                            checkissueindex = "no";
                        }
                        if (checkforeseen == null) {
                            checkforeseen = "no";
                        }
                        if (checkreal == null) {
                            checkreal = "no";
                        }
                        if (checkstatus == null) {
                            checkstatus = "no";
                        }
                        if (checkprodstart == null) {
                            checkprodstart = "no";
                        }
                        if (checkprodend == null) {
                            checkprodend = "no";
                        }
                        if (checkprogress == null) {
                            checkprogress = "no";
                        }
                        if (checkresource == null) {
                            checkresource = "no";
                        }
                        if (checkestimate == null) {
                            checkestimate = "no";
                        }
                        if (checkfile == null) {
                            checkfile = "no";
                        }
                        if(checkall == null){
                            checkall = "no";
                        }
                        if (checkall == "add") {
                    %>
                    <span style="color: green; font-weight: bold;">Congratulations, Your update implemented successfully on (
                        <%
                            if (checkissueindex == "add") {
                        %>
                        <%="[ issuance index ]"%>
                        <%
                            }
                            if (checkforeseen == "add") {
                        %>
                        <%="[ foreseen date ]"%>
                        <%
                            }
                            if (checkreal == "add") {
                        %>
                        <%="[ real date ]"%>
                        <%
                            }
                            if (checkstatus == "add") {
                        %>
                        <%="[ status ]"%>
                        <%
                            }
                            if (checkprodstart == "add") {
                        %>
                        <%="[ production start date ]"%>
                        <%
                            }
                            if (checkprodend == "add") {
                        %>
                        <%="[ production end date ]"%>
                        <%
                            }
                            if (checkprogress == "add") {
                        %>
                        <%="[ progress ]"%>
                        <%
                            }
                            if (checkresource == "add") {
                        %>
                        <%="[ resource ]"%>
                        <%
                            }
                            if (checkestimate == "add") {
                        %>
                        <%="[ estimate ]"%>
                        <%
                            }
                            if (checkfile == "add") {
                        %>
                        <%="[ file ]"%>
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
                    
                    <label class="label_form"><span style="color: red; font-size: 25px;">*</span>Select the issuance ID which will be update</label><!--share CSS-->
                    <select class="select_form" name="uissue_main_doc_select" required>
                        <option value="">SELECT OPTION</option>
                        <%
                            Connection connection = ServerConnection.ConnectionMethod();
                            Statement statement = connection.createStatement();
                            String issuanceSQL = "SELECT document.document_ID, issuance.iss_index FROM document INNER JOIN issuance ON document.doc_ID = issuance.doc_ID;";
                            ResultSet resultSet = statement.executeQuery(issuanceSQL);
                            while(resultSet.next()){
                                %>
                                <option><%=resultSet.getString("document_ID") + "-" + resultSet.getString("iss_index")%></option>
                        <%
                            }
                        %>
                    </select><!--share CSS-->

<!--                    <label class="label_form">Select the index of updating issuance</label>share CSS
                    <select class="select_form" name="uissue_main_index_select" required>
                        <option>A</option>
                        <option>B</option>
                        <option>C</option>
                        <option>D</option>
                    </select>-->

                    <label class="label_form">Issuance index</label><!--share CSS-->
                    <input class="text_form" type="text" name="uissue_index" id="uissindex" placeholder="Enter Issuance Index"><!--share CSS-->

                    <label class="label_form">Foreseen send date</label><!--share CSS-->
                    <input class="date_form" type="date" name="uissue_foreseen_send" id="uissforeseen" placeholder="Enter Foreseen Send Date"><!--share CSS-->

                    <label class="label_form">Real send date</label><!--share CSS-->
                    <input class="date_form" type="date" name="uissue_real_send" id="uissreal" placeholder="Enter Real Send Date"><!--share CSS-->

                    <label class="label_form">Status</label>
                    <select class="select_form" name="uissue_status_select">
                        <option value="">SELECT OPTION</option>
                        <option>APP</option>
                        <option>APAN</option>
                        <option>RRS</option>
                    </select><!--share CSS-->

                    <label class="label_form">Production start date</label><!--share CSS-->
                    <input class="date_form" type="date" name="uissue_production_start" id="uissstart"><!--share CSS-->

                    <label class="label_form">Production end date</label><!--share CSS-->
                    <input class="date_form" type="date" name="uissue_production_end" id="uissend"><!--share CSS-->

                    <label class="label_form">Progress</label><!--share CSS-->
                    <select class="select_form" name="uissue_progress_select">
                        <option value="">SELECT OPTION</option>
                        <option>In Progress</option>
                        <option>Technical Issue</option>
                        <option>Finished</option>
                    </select><!--share CSS-->

                    <label class="label_form">Resource</label><!--share CSS-->
                    <select class="select_form" name="uissue_resource_select">
                        <option value="">SELECT OPTION</option>
                        <%
                            statement = connection.createStatement();
                            String uresourceSQL = "SELECT resource.first_name, resource.last_name, resource.full_name FROM resource;";
                            resultSet = statement.executeQuery(uresourceSQL);
                            while(resultSet.next()){
                                %>
                                <option><%=resultSet.getString("first_name") + " " + resultSet.getString("last_name") + " -> " + resultSet.getString("full_name")%></option>
                        <%
                            }
                        %>
                    </select><!--share CSS-->

                    <label class="label_form">Estimated workload</label>
                    <input class="text_form" type="text" name="uisuue_est_workload" id="uissestimate" placeholder="Enter Estimated workload" pattern="[0-9]">

<!--                    <label class="label_form">Choose file of this issuance</label>
                    <input class="file_form" type="file" name="uissue_file" id="uissfile">-->
                    
                    <label class="label_form">Choose file of this issuance</label>
                    <label class="label_file_form" for="issfile"><i class="fa fa-cloud-upload"></i> Upload file</label>
                    <label id="filenamelabel" oninput="newfun()"></label>
                    <input class="file_form" type="file" name="issue_file" id="issfile">
                    
                    <div class="tooltip">
                        <button type="submit" class="form_but" style="margin-right: 3%;">Update Issuance</button>
                        <button type="button" class="form_but" onClick="ClearField()">Adjust default values</button>
                        <!--<span class="tooltiptext">Before stacking your Issuance be ensure about your data.</span>-->
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
                //document.getElementById("selecteddoc").selected = true;
                document.getElementById("uissindex").value = "";
                document.getElementById("uissforeseen").value = "";
                document.getElementById("uissreal").value = "";
                document.getElementById("uselecteddec").selected = true;
                document.getElementById("uissstart").value = "";
                document.getElementById("uissend").value = "";
                document.getElementById("uselectedprog").selected = true;
                document.getElementById("uselectedres").selected = true;
                document.getElementById("uissestimate").value = "";
                document.getElementById("uissfile").value = "";
            }
            
            //write file path in label
            var input = document.getElementById('issfile');
            var infoArea = document.getElementById('filenamelabel');

            input.addEventListener('change', showFileName);

            function showFileName(event) {

                // the change event gives us the input it occurred in 
                var input = event.srcElement;

                // the input has an array of files in the `files` property, each one has a name that you can use. We're just using the name here.
                var fileName = input.files[0].name;

                // use fileName however fits your app best, i.e. add it into a div
                infoArea.textContent = fileName;
            }
            
            function newfun(){
                alert("dffdfsfdfs");
            }
        </script>
    </body>
</html>
