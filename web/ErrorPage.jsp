<%@page import="classes_package.SetGetData"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Error Page</title>
        <style>
            .HeaderDiv{
                width: 100%;
                height: 70px;;
                background-color: #00508B;
                overflow: hidden;
                display:block;
                /*align-items: center;*/
                box-shadow: 0px 0px 15px 0px black;
                border-radius: 15px 15px 15px 15px;
            }

            .HeaderDiv img{
                position: absolute;
                width: 10%;
                height: 75px;
                float: left;
            }

            .HeaderDiv header{
                color: white;
                /*background-color: chocolate;*/
                display: inline-block;
                width: 50%;
                height: 30px;
                margin-top: 15px;
                margin-left: 25%;
                text-align: center;
                font-family: "Times New Roman";
                font-size: 20px;
                font-weight: bold;
            }
            #message{
                width: 100%;
                height: auto;
                /*background-color: #7583AA;*/
                overflow: hidden;
                margin-top: 50px;
                border-radius: 15px 15px 15px 15px;
                border: solid 1px blue;
                padding: 50px;
                box-sizing: border-box;
                text-align: center;
            }
            ::selection{
                background-color: #aaaaaa;
                color: black;
            }
            h1{
                font-family: "Times New Roman";
            }
            p{
                font-family: "Times New Roman";
            }
            span{
                font-weight: bold;
            }
            a{
                text-decoration: none;
                font-family: "Times New Roman";
                font-weight: bold;
                color: black;
                border-radius: 15px 15px 15px 15px;
                border: dashed 1px blue;
                padding: 5px;
            }
            a:hover{
                cursor: pointer;
                color: red;
                border: solid 1px red;
                background-color: black;
                transition-duration: 0.1s;
            }
        </style><%System.out.println(exception.getMessage());%>
    </head>
    <body>
        <div class="HeaderDiv">
            <img src="images_folder/colaslogo2.png" alt="Colas logo"/>
            <header>Documentation Management System</header>
        </div>
        <div id="message">
            <h1>There an error occurred, be carful about your steps in system</h1>
            
            <p><span>Error message is :</span> <%= exception.getMessage() %></p>
            <a href="index.jsp">Go to login page</a>
        </div>
    </body>
</html>