
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
        <title>Add resource</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="CSS_folder/AddResource.css" rel="stylesheet" type="text/css"/>
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
                <header>Colas Rail Egypt Documentation Management System<br/><span style="color: #18FC06;">ADD NEW RESOURCE</span></header>
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
                    <li><a href="TechnicalIssue.html">Technical issue list</a></li>
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
                <!--form to add resource-->
                <form id="res_form_id" class="ResForm" action="AddResourceServlet">
                    <label class="main_label_form">Resource Addition Form</label><!--share CSS-->

                    <%
                        HttpSession session1 = request.getSession();
                        String check = (String) session1.getAttribute("check");
                        if (check == null) {
                            check = "no";
                        }
                        if (check.equals("yes")) {
                    %>
                    <span style="color: red; font-weight: bold;">Sorry, This Resource already exist.</span>
                    <%
                    } else {
                        if (check.equals("add")) {
                    %>
                    <span style="color: green; font-weight: bold;">Congratulations, Your Resource add successfully.</span>
                    <%
                            }
                        }
                        check = null;
                        session1.setAttribute("check", check);
                    %>

                    <label class="label_form"><span style="color: red; font-size: 25px;">*</span>First Name</label>
                    <input class="text_form" type="text" name="res_first_name" id="fname" placeholder="Enter First name" required>

                    <label class="label_form"><span style="color: red; font-size: 25px;">*</span>Last Name</label>
                    <input class="text_form" type="text" name="res_last_name" id="lname" placeholder="Enter Last name" required>

                    <label class="label_form"><span style="color: red; font-size: 25px;">*</span>Function</label>
                    <select class="select_form" name="res_function_select" required>
                        <%
                            Connection connection = ServerConnection.ConnectionMethod();
                            Statement statement = connection.createStatement();
                            String functionSQL = "SELECT function.function_title FROM function;";
                            ResultSet resultSet = statement.executeQuery(functionSQL);
                            while (resultSet.next()) {
                        %>
                        <option><%= resultSet.getString("function_title")%></option>
                        <%
                            }
                        %>
                    </select>

                    <label class="label_form"><span style="color: red; font-size: 25px;">*</span>Status</label>
                    <select class="select_form" name="res_status_selecet" required>
                        <%
                            statement = connection.createStatement();
                            String statusSQL = "SELECT status.status_title FROM status;";
                            resultSet = statement.executeQuery(statusSQL);
                            while (resultSet.next()) {
                        %>
                        <option><%= resultSet.getString("status_title")%></option>
                        <%
                            }
                        %>
                    </select>

                    <label class="label_form"><span style="color: red; font-size: 25px;">*</span>please enter the full name</label>
                    <input class="text_form" type="text" name="res_full_name" id="fullnameid" placeholder="Enter Full Name" required pattern="\S+\s+\S+\s+\S+\s+\S+">
                    <span id="nmn"></span>
                    <div class="tooltip">
                        <button type="submit" class="form_but" style="margin-right: 3%;">Stack resource</button>
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
                document.getElementById("fname").value = "";
                document.getElementById("lname").value = "";
                document.getElementById("fullnameid").value = "";
//                document.getElementById("selectedfunction").selected = true;
//                document.getElementById("selectedstatus").selected = true;
            }

//            function namestore() {
//                var fname = document.getElementById("fname");
//                var lname = document.getElementById("lname");
//                var fullname = document.getElementById("fullnameid");
//                fullname.value = fname.value + " " + lname.value;
//            }


            // Get reference to textbox
            var input = document.getElementById("fullnameid");
            // Add event handler for event that can be cancelled and prevent excessive data
            // from ever getting into the textbox
            input.addEventListener("keypress", function (evt) {
                // Get value of textbox and split into array where there is one or more continous spaces
                var words = this.value.split(/\s+/);
                // Get # of words in array
                var numWords = words.length;
                var maxWords = 4;
                // If we are at the limit and the key pressed wasn't BACKSPACE or DELETE,
                // don't allow any more input
                if (numWords > maxWords) {
                    evt.preventDefault(); // Cancel event
                }
            });

            function namestore() {

            }
        </script>
    </body>
</html>
