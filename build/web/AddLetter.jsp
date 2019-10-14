<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add letter</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="CSS_folder/AddLetter.css" rel="stylesheet" type="text/css"/>
    </head>

    <body>
        <div class="MainDiv">
            <!--header div-->
            <div class="HeaderDiv">
                <img src="images_folder/colaslogo2.png" alt="Colas logo">
                <header>Colas Rail Documentation Management System</header>
            </div>
            <!--vertical navigation div-->
            <div class="NavDiv">
                <ul>
                    <li><a href="DeliverableList.jsp">Deliverable list</a></li>
                    <li><a href="ResourceList.jsp">Resource list</a></li>
                    <li><a href="WorkloadList.html">Work load list</a></li>
                    <li><a href="TimesheetList.html">Time Sheet list</a></li>
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
                <!--form to add document-->
                <form id="let_form_id" class="LetForm" action="#">
                    <label class="main_label_form">Letter Addition Form</label><!--share CSS-->

                    <label class="label_form">Letter title</label>
                    <input class="text_form" type="text" name="let_title" id="lettitle" placeholder="Enter Letter Title" required>

                    <label class="label_form">Issuance of letter</label>
                    <select class="select_form" name="let_iss" form="let_form_id" id="letiss">
                        <option id="selectedi">- - select one option - -</option>
                        <option>A</option>
                        <option>B</option>
                        <option>C</option>
                        <option>D</option>
                    </select>
                    
                    <label class="label_form">Letter kind</label>
                    <select class="select_form" name="let_kind" form="let_form_id" id="letkind">
                        <option id="selectedk">- - select one option - -</option>
                        <option>Sent</option>
                        <option>Recieved</option>
                    </select>
                    
                    <label class="label_form">Import your letter</label>
                    <input type="file" class="file_form" name="leter_self" id="letter"/>
                    
                    <label class="label_form">Are this letter main ?</label>
                    <input type="radio" name="let_radio" id="letradio1" class="radio_form" value="send"/><span>&nbsp;&nbsp;Main send</span>
                    <input type="radio" name="let_radio" id="letradio2" class="radio_form" value="receive"/><span>&nbsp;&nbsp;Main receive</span>
                    
                    <div style="clear: both;"></div>

                    <div class="tooltip">
                        <button type="submit" class="form_but" onClick="---------- -" style="margin-right: 3%;">Stack document</button>
                        <button type="button" class="form_but" onClick="ClearField()">Adjust default values</button>
                        <!--<span class="tooltiptext">Before stacking your document be ensure about your data.</span>-->
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
                document.getElementById("lettitle").value = "";
                document.getElementById("selectedi").selected = true;
                document.getElementById("selectedk").selected = true;
//                document.getElementsByClassName("selected").selected = true;
            }
        </script>
    </body>
</html>
