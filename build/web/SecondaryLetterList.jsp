<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="classes_package.ServerConnection"%>
<%!
    int numberofletter = 0;
%>
<%
    Connection connection = ServerConnection.ConnectionMethod();
    Statement statement = null;
    ResultSet resultSet = null;
    String secondaryletterlistSQL = "", documentidforsecondaryletterSQL = "";
    String documentIDstring = "", ID1 = "", ID2 = "", ID3 = "", ID4 = "", ID5 = "", ID6 = "", ISSUANCE_INDEX = "", LETTER_TITLE = "", LETTER_FOR_TITLE = "", LETTER_KIND = "";
    String[] documentIDarray = new String[6];
%>
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Technical issue list</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="CSS_folder/LetterList.css">
        <script>
            function ListRows() {
                var rowsnumber = document.getElementById("tableid").rows.length;
                document.getElementById("letternumber").innerHTML = rowsnumber - 2;
            }
        </script>
    </head>

    <body>
        <div class="MainDiv">
            <!--header div-->
            <div class="HeaderDiv">
                <img src="images_folder/colaslogo2.png" alt="Colas Rail logo">
                <header>Colas Rail Documentation Management System<br><span>Letter list</span></header>
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
                    <p class="ResNum">Number of letters : <span id="letternumber"></span></p>
                </div>
                <table id="tableid">
                    <tr>
                        <th colspan="7" style="width: 50%;" class="border">Document ID</th>
                        <th rowspan="2" style="width: 15%;" class="border">Letter title</th>
                        <th rowspan="2" style="width: 15%;">Letter for title</th>
                        <th rowspan="2" style="width: 20%;">Letter status</th>
                    </tr>
                    <tr>
                        <th class="border">Rubric</th>
                        <th>Group</th>
                        <th>Issuer</th>
                        <th>Lot</th>
                        <th>Ref</th>
                        <th>Number</th>
                        <th>Index</th>
                    </tr>
                    <%
                        String issID = request.getParameter("issuanceID");
                        int ISSID;
                        if (issID == null || issID == "") {
                            ISSID = 0;
                        } else {
                            ISSID = Integer.parseInt(issID);
                        }
                        documentidforsecondaryletterSQL = "SELECT document.document_ID, issuance.iss_index, secondaryletter.s_letter_title, secondaryletter.s_letter_for_title, secondaryletter.s_letter_kind FROM (issuance  INNER JOIN document ON issuance.doc_ID = document.doc_ID) INNER JOIN secondaryletter ON issuance.issuance_ID = secondaryletter.s_issuance_id WHERE issuance.issuance_ID = " + ISSID + ";";
                        statement = connection.createStatement();
                        resultSet = statement.executeQuery(documentidforsecondaryletterSQL);
                        while (resultSet.next()) {
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

                            ISSUANCE_INDEX = resultSet.getString("iss_index");

                            LETTER_TITLE = resultSet.getString("s_letter_title");

                            LETTER_FOR_TITLE = resultSet.getString("s_letter_for_title");

                            LETTER_KIND = resultSet.getString("s_letter_kind");
                            
                            numberofletter++;
                    %>
                    <tr>
                        <td class="border"><%= ID1%></td>
                        <td><%= ID2%></td>
                        <td><%= ID3%></td>
                        <td><%= ID4%></td>
                        <td><%= ID5%></td>
                        <td><%= ID6%></td>
                        <td><%= ISSUANCE_INDEX%></td>
                        <td class="border"><a href="files/<%= LETTER_TITLE%>.pdf" target="_blank"><%= LETTER_TITLE%></a></td>
                        <td><a href="files/<%= LETTER_FOR_TITLE%>.pdf" target="_blank"><%= LETTER_FOR_TITLE%></a></td>
                        <td><%= LETTER_KIND%></td>
                    </tr>
                    <% }%>
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
