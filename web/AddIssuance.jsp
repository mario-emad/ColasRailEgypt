
<%@page import="classes_package.SetGetData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="classes_package.ServerConnection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="/ErrorPage.jsp" %>
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
        <title>Add issuance</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="CSS_folder/AddIssuance.css" rel="stylesheet" type="text/css"/>
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
                <header>Colas Rail Egypt Documentation Management System<br/><span style="color: #18FC06;">ADD NEW ISSUANCE</span></header>
                <div id="namelogoid">
                    <span id="usernamespan"><span id="welcomeid">Welcome</span>&nbsp;&nbsp;&nbsp;<span id="usernameid"><%= username%></span></span>
                    <form action="LogoutSystemServlet">
                        <button type="submit" id="logoutid">Logout</button>
                    </form>
                </div>
            </div>
            <!--vertical navigation div-->
            <div class="NavDiv" id="navdivid">
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
            <div class="BodyDiv" id="bodydivid">
                <!--hor nav bar-->
                <div class="HorNav">
                    <ul>
                        <li id="right"><a href="Main.jsp"><i class="fa fa-fw fa-home"></i> Home</a></li>
                    </ul>
                </div>
                <!--form to add issuance-->
                <form id="issue_form_id" class="IssueForm" action="AddIssuanceServlet">
                    <label class="main_label_form">Issuance Addition Form</label><!--share CSS-->
                    <%
                        HttpSession session1 = request.getSession();
                        String check = (String) session1.getAttribute("check");
                        if (check == null) {
                            check = "no";
                        }
                        if (check.equals("yes")) {
                    %>
                    <span style="color: red; font-weight: bold;">Sorry, This issuance already exist.</span>
                    <%
                    } else {
                        if (check.equals("add")) {
                    %>
                    <span style="color: green; font-weight: bold;">Congratulations, Your issuance add successfully.</span>
                    <%
                            }
                        }
                        check = null;
                        session1.setAttribute("check", check);
                    %>

                    <label class="label_form"><span style="color: red; font-size: 25px;">*</span>Document ID</label><!--share CSS-->
                    <select class="select_form" name="issue_doc_ID_select" required>
                        <option value="">SELECT OPTION</option>
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
                    </select><!--share CSS-->

                    <label class="label_form"><span style="color: red; font-size: 25px;">*</span>Issuance index</label><!--share CSS-->
                    <input class="text_form" type="text" name="issue_index" id="issindex" placeholder="Enter Issuance Index" required><!--share CSS-->

                    <label class="label_form"><span style="color: red; font-size: 25px;">*</span>Foreseen send date</label><!--share CSS-->
                    <input class="date_form" type="date" name="issue_foreseen_send" id="issforeseen" placeholder="Enter Foreseen Send Date" required><!--share CSS-->

                    <label class="label_form">Real send date</label><!--share CSS-->
                    <input class="date_form" type="date" name="issue_real_send" id="issreal" placeholder="Enter Real Send Date"><!--share CSS-->

                    <label class="label_form">Status</label>
                    <select class="select_form" name="issue_status_select">
                        <option id="selecteddec" value="">SELECT OPTION</option>
                        <option value="APP">APP</option>
                        <option value="APAN">APAN</option>
                        <option value="RRS">RRS</option>
                    </select><!--share CSS-->

                    <label class="label_form">Production start date</label><!--share CSS-->
                    <input class="date_form" type="date" name="issue_production_start" id="issstart"><!--share CSS-->

                    <label class="label_form">Production end date</label><!--share CSS-->
                    <input class="date_form" type="date" name="issue_production_end" id="issend"><!--share CSS-->

                    <label class="label_form">Progress</label><!--share CSS-->
                    <select class="select_form" name="issue_progress_select">
                        <option id="selectedprog" value="">SELECT OPTION</option>
                        <option value="In Progress">In Progress</option>
                        <option value="Technical Issue">Technical Issue</option>
                        <option value="Finished">Finished</option>
                    </select><!--share CSS-->

                    <label class="label_form">Resource</label><!--share CSS-->
                    <select class="select_form" name="issue_resource_select">
                        <option  id="selectedres" value="">SELECT OPTION</option>
                        <%
                            statement = connection.createStatement();
                            String resourcesSQL = "SELECT resource.first_name, resource.last_name FROM resource;";
                            resultSet = statement.executeQuery(resourcesSQL);
                            while (resultSet.next()) {
                        %>
                        <option value="<%= resultSet.getString("first_name") + " " + resultSet.getString("last_name")%>"><%= resultSet.getString("first_name") + " " + resultSet.getString("last_name")%></option>
                        <%
                            }
                        %>
                    </select><!--share CSS-->

                    <label class="label_form">Company</label><!--share CSS-->
                    <select class="select_form" name="company_select">
                        <option  id="selectedcom" value="">SELECT OPTION</option>
                        <%
                            statement = connection.createStatement();
                            String companySQL = "SELECT company.company_name FROM company;";
                            resultSet = statement.executeQuery(companySQL);
                            while (resultSet.next()) {
                        %>
                        <option value="<%= resultSet.getString("company_name")%>"><%= resultSet.getString("company_name")%></option>
                        <%
                            }
                        %>
                    </select><!--share CSS-->

                    <label class="label_form">Estimated workload</label>
                    <input class="text_form" type="text" name="issue_est_workload" id="issestimate" placeholder="Enter Estimated workload">

                    <label class="label_form"><span style="color: red; font-size: 25px;">*</span>Choose file of this issuance</label>
                    <label class="label_file_form" for="issfile" id="filelabel"><i class="fa fa-cloud-upload"></i> Upload file</label>
                    <label class="namelabel" id="fileid"></label>
                    <input class="file_form" type="file" name="issue_file" id="issfile" required="required">

                    <label class="label_form">Choose letter of this issuance</label>
                    <label class="label_file_form" for="issletter" id="letterlabel"><i class="fa fa-cloud-upload"></i> Upload letter</label>
                    <label class="namelabel" id="letterid"></label>
                    <input class="file_form" type="file" name="issue_letter" id="issletter" onchange="openradio(this.value)">

                    <label class="label_form" style="">Is this letter 'IN' or 'OUT' ?</label>
                    <div style="float: left; overflow: hidden; margin-left: 200px;">
                        <input id="in" class="radioletter" type="radio" name="letterradio" disabled="true" value="in" style="display: inline-block; float: left;"/>&nbsp;<span style="display: inline-block;  float: left;">IN</span>
                        <input id="out" class="radioletter" type="radio" name="letterradio" disabled="true" value="out" style="display: inline-block; float: left; clear: left;"/>&nbsp;<span style="display: inline-block;  float: left;">OUT</span>
                    </div>

                    <label class="label_form" style="">Is this revision last for outside ?</label>
                    <div style="float: left; overflow: hidden; margin-left: 30px;">
                        <!--<input type="checkbox" value="L" name="lastver" class="lastver" style="margin-right: 15px; display: inline-block;"/><span class="lastver" style="">Last Revision</span><br>-->
                        <input id="o_n_index_checkbox" onclick="disclastspanfun()" type="checkbox" value="R" name="lastver" class="lastver" style="margin-right: 15px; display: inline-block;"/><span class="lastver" style="">O/N Index</span>
                        <span id="disclastspan" style="overflow: hidden; margin-left: 30px; color: red;"></span>
                    </div>
                    <div style="clear: both;"></div>

                    <div class="tooltip">
                        <button type="submit" class="form_but" onClick="--------------------" style="margin-right: 3%;">Stack issuance</button>
                        <button type="button" class="form_but" onClick="ClearField()">Adjust default values</button>
                        <!--<input type="button" class="form_but" onClick="ClearField()" value="Adjust default values"/>-->
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
            
            document.getElementById("navdivid").width = document.getElementById("bodydivid").offsetWidth;
            document.getElementById("bodydivid").width = document.getElementById("navdivid").width;
            
            function openradio(val){
                if(val != "" && val != null){
//                    document.getElementsByClassName("radioletter").disabled = false;
                    document.getElementById("in").disabled = false;
                    document.getElementById("out").disabled = false;
                    document.getElementById("in").required = true;
                    document.getElementById("out").required = true;
                }
            }
            
            function ClearField() {
                document.getElementById("issfile").value = "";
                document.getElementById("issindex").value = "";
                document.getElementById("issforeseen").value = "";
                document.getElementById("issreal").value = "";
                document.getElementById("selecteddec").selected = true;
                document.getElementById("issstart").value = "";
                document.getElementById("issend").value = "";
                document.getElementById("selectedprog").selected = true;
                document.getElementById("selectedres").selected = true;
                document.getElementById("issestimate").value = "";
                document.getElementById("issfile").value = "";
                document.getElementById("selectedcom").selected = true;
            }

            function disclastspanfun() {
                var check = document.getElementById("o_n_index_checkbox");
                var disc = document.getElementById("disclastspan");
                if (check.checked) {
                    disc.innerHTML = "This issuance is the last revision outside";
                } else {
                    disc.innerHTML = "";
                }
            }

            //write file path in label
            var input = document.getElementById('issfile');
            var infoArea = document.getElementById('fileid');

            input.addEventListener('change', showFileName);

            function showFileName(event) {

                // the change event gives us the input it occurred in 
                var input = event.srcElement;

                // the input has an array of files in the `files` property, each one has a name that you can use. We're just using the name here.
                var fileName = input.files[0].name;

                // use fileName however fits your app best, i.e. add it into a div
                infoArea.textContent = fileName;
            }
            //end section

            //write letter path in label
            var input2 = document.getElementById('issletter');
            var infoArea2 = document.getElementById('letterid');

            input2.addEventListener('change', showFileName2);

            function showFileName2(event) {

                // the change event gives us the input it occurred in 
                var input2 = event.srcElement;

                // the input has an array of files in the `files` property, each one has a name that you can use. We're just using the name here.
                var fileName2 = input2.files[0].name;

                // use fileName however fits your app best, i.e. add it into a div
                infoArea2.textContent = fileName2;
            }
            //end section

            /*
             function ValidatePetSelection()
             {
             var checkboxes = document.getElementsByName("favorite_pet");
             var numberOfCheckedItems = 0;
             for (var i = 0; i < checkboxes.length; i++)
             {
             if (checkboxes[i].checked)
             numberOfCheckedItems++;
             }
             if (numberOfCheckedItems > 2)
             {
             alert("You can't select more than two favorite pets!");
             return false;
             }
             }*/
        </script>
    </body>
</html>
