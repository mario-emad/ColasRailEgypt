
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Welcome to system</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="CSS_folder/Index.css">
        <script>
            function ResetLogin() {
                document.getElementById("userlogin").value = "";
                document.getElementById("passlogin").value = "";
            }
            
            function ResetCreate() {
                document.getElementById("namecreate").value = "";
                document.getElementById("usernamecreate").value = "";
                document.getElementById("passwordcreate").value = "";
                document.getElementById("byusercreate").value = "";
                document.getElementById("bypasscreate").value = "";
            }
        </script>
    </head>
    <body>
        <!--<div>Welcome to our management system</div>-->
        <!--        <a href="MainProject.jsp">Enter to system</a>-->
        <div id="head">Colas Rail Documentation Control System</div>
        <div id="users">
            <form action="EnterSystemServlet" id="loginuser" method="POST">
                <span class="title">Login</span><br/><br/>
                Username <input type="text" name="user" placeholder="Username" class="field" required="required" id="userlogin"/>
                <br/><br/>
                Password <input type="password" name="pass" placeholder="Password" class="field" required="required" id="passlogin"/>
                <input type="button" onclick="ResetLogin()" value="Clear fields" class="clear"/>
                <button type="submit">Enter the system</button>
            </form>

            <form action="CreateUserServlet" id="adduser" method="POST">
                <span class="title">Create new user</span><br/><br/>
                Name <input type="text" name="cname" placeholder="New Name" class="field" required="required" id="namecreate"/>
                <br/><br/>
                Username <input type="text" name="cuser" placeholder="New username" class="field" required="required" id="usernamecreate"/>
                <br/><br/>
                Password <input type="password" name="cpass" placeholder="New password" class="field" required="required" id="passwordcreate"/>
                <br/><br/>
                Username add by <input type="text" name="byuser" placeholder="Creator username" class="field" required="required" id="byusercreate"/>
                <br/><br/>
                Password add by <input type="password" name="bypass" placeholder="Creator password" class="field" required="required" id="bypasscreate"/>
                <input type="button" onclick="ResetCreate()" value="Clear fields" class="clear"/>
                <button type="submit">Create user</button>
            </form>
            <div id="dif">
                <span class="title">Note</span>
                <p><span>Login case :</span> You have insert your data correctly to enter the system</p>
                <p><span>Create case :</span> You have to insert username and password of your account to insert new user and be carful your user name will be saved in our database</p>
            </div>
        </div>
    </body>
</html>
