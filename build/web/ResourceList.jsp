
<%@page import="classes_package.SetGetData"%>
<%@page import="org.openqa.selenium.By"%>
<%@page import="org.openqa.selenium.firefox.FirefoxDriver"%>
<%@page import="org.openqa.selenium.WebDriver"%>
<%@page import="org.openqa.selenium.support.ui.Select"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="classes_package.ServerConnection"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="/ErrorPage.jsp" %>
<%
    Connection connection = ServerConnection.ConnectionMethod();
    Statement statement = null;
    ResultSet resultSet = null;
%>
<%!
    String FIRSTNAME, LASTNAME, FUNCTION, STATUS, FULLNAME;
//    String LOCALNUMBER, EXPATNUMBER, OTHERNUMBER;
%>
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Resource list</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="CSS_folder/ResourceList.css">
        <script>
            function ListRows() {
                var rowsnumber = document.getElementById("tableid").rows.length;
                document.getElementById("resourcenumber").innerHTML = rowsnumber - 2;
            }

            function FillNumber(local, expat, other) {
                document.getElementById("localnumber").innerHTML = local;
                document.getElementById("expatnumber").innerHTML = expat;
                document.getElementById("othernumber").innerHTML = other;
            }
//            function FillNumber(local){
//                document.getElementById("localnumber").innerHTML = local;
//            }
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
                <img src="images_folder/colaslogo2.png" alt="Colas logo"/>
                <header>Colas Rail Egypt Documentation Management System<br/><span style="color: #18FC06;">RESOURCE LIST</span></header>
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
                <div class="CountDiv">
                    <p class="CountInfo">
                    <div class="inCountDiv">
                        Total number of Resource : <span id="resourcenumber" class="numbers"></span><br/><br/>
                        Total number of <span class="specialcount"><b>local</b></span> Resource : <span id="localnumber" class="numbers"></span>
                    </div>
                    <div class="inCountDiv">
                        Total number of <span class="specialcount"><b>expat</b></span> Resource : <span id="expatnumber" class="numbers"></span><br/><br/>
                        Total number of <span class="specialcount"><b>other</b></span> Resource : <span id="othernumber" class="numbers"></span>
                    </div>
                    </p>
                </div>
                <table id="tableid">
                    <tr>
                        <th colspan="2" style="width: 25%; border-bottom: solid 1px black;">Name</th>
                        <th rowspan="2" style="width: 25%;" class="border">Function</th>
                        <th rowspan="2" style="width: 15%;" class="border">Status</th>
                        <th rowspan="2" style="width: 25%;" class="border">Full name</th>
                        <th rowspan="2" style="width: 10%; background-color: cadetblue;" class="border">Update</th>
                    </tr>
                    <tr>
                        <th>Last name</th>
                        <th class="border">First name</th>
                    </tr>
                    <%
                        statement = connection.createStatement();
                        String selectResource = "SELECT resource.resources_ID, resource.first_name, resource.last_name, function.function_title, status.status_title, resource.full_name FROM (resource INNER JOIN function ON resource.function_ID = function.function_ID) INNER JOIN status ON resource.status_ID = status.status_ID;";
//                        String countLocal = "SELECT COUNT(*) FROM resource WHERE resource.status_ID = 1";
//                        String countExpat = "SELECT COUNT(*) FROM resource WHERE resource.status_ID = 2";
//                        String countOther = "SELECT COUNT(*) FROM resource WHERE resource.status_ID = 3";
                        int LOCALNUMBER = 0, EXPATNUMBER = 0, OTHERNUMBER = 0;
                        resultSet = statement.executeQuery(selectResource);

                        while (resultSet.next()) {
                            FIRSTNAME = resultSet.getString("first_name");
                            LASTNAME = resultSet.getString("last_name");
                            FUNCTION = resultSet.getString("function_title");
                            STATUS = resultSet.getString("status_title");
                            FULLNAME = resultSet.getString("full_name");
                    %>
                    <tr>
                        <td style="width: 12.5%;"><%= LASTNAME%></td>
                        <td style="width: 12.5%;" class="border"><%= FIRSTNAME%></td>
                        <td style="width: 25%;" class="border"><%= FUNCTION%></td>
                        <td style="width: 15%;" class="border">
                            <%
                                if (STATUS.equals("local")) {
                                    LOCALNUMBER++;
                                } else if (STATUS.equals("expat")) {
                                    EXPATNUMBER++;
                                } else {
                                    OTHERNUMBER++;
                                }
                            %>
                            <%=STATUS%>
                        </td>
                        <td style="width: 25%;" class="border"><%= FULLNAME%></td>
                        <td style="width: 10%;" class="border"><form action="EditResourceListData.jsp"><button class="private" type="submit" value="<%=resultSet.getInt("resources_ID")%>" name="resid" id="idfordisable">Update</form></button></td>
                    </tr>
                    <%
                        }
                    %>
                    <tr>
                        <td style="width: 12.5%;"></td>
                        <td style="width: 12.5%;" class="border"></td>
                        <td style="width: 25%;" class="border"></td>
                        <td style="width: 15%;" class="border"></td>
                        <td style="width: 25%;" class="border"></td>
                        <td style="width: 10%;" class="border"><a href="AddResource.jsp"><img style="width: 25px; height: 25px;" src="images_folder/Add-icon.png" alt="Add Icon" title="Add Resource"/></a></td>
                    </tr>
                </table>
                <script>
                    ListRows();
                    FillNumber(<%= LOCALNUMBER%>, <%= EXPATNUMBER%>, <%= OTHERNUMBER%>);
                </script>
            </div>
            <!--footer div-->
<!--            <div class="FooterDiv">
                <footer>All Data are appeared. Thanks for your patience</footer>
            </div>-->
        </div>
    </body>
</html>

