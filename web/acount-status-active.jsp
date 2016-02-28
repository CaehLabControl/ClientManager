<%-- 
    Document   : newjsp
    Created on : 27/02/2016, 10:47:23 AM
    Author     : CARLOS ANTONIO
--%>
<%@page import="control.aes"%>
<%
    String versionjqwidgets="jqwidgets-ver3.9.1";
    if(request.getParameter("ac")!=null){
        aes sec = new aes();
        sec.addKey("2015");
        String liga = request.getParameter("ac");
        liga = sec.desencriptar(liga.replace(" ", "+"));
        if(!liga.contains("userName")){
            response.sendRedirect("");
        }
    }else{
        response.sendRedirect("");
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang='en-US'>
    <head>
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
        <title>Activar cuenta</title>
        <link rel='stylesheet' href='content/files-css/wp-admin.css' type='text/css' media='all'>
        <link rel='stylesheet' href='content/files-css/buttons.css' type='text/css' media='all'>
        <link rel='stylesheet' href='content/files-css/colors-fresh.css' type='text/css' media='all'>
        <link rel='stylesheet' href='content/files-jq/<%out.print(versionjqwidgets);%>/jqwidgets/styles/jqx.base.css' type='text/css' />
        <link rel='stylesheet' href='content/files-jq/<%out.print(versionjqwidgets);%>/jqwidgets/styles/jqx.darkblue.css' type='text/css' />
        <script type='text/javascript' src='content/files-jq/<%out.print(versionjqwidgets);%>/scripts/jquery-1.11.1.min.js'></script>
        <script type='text/javascript' src='content/files-jq/<%out.print(versionjqwidgets);%>/jqwidgets/jqxcore.js'></script>
        <script type='text/javascript' src='content/files-jq/<%out.print(versionjqwidgets);%>/jqwidgets/jqxloader.js'></script>
        <script type='text/javascript' src='content/files-jq/<%out.print(versionjqwidgets);%>/jqwidgets/jqxbuttons.js'></script>
        <script type='text/javascript'>
            $(document).ready(function () {
                //Lose the page back
                window.location.hash="";
                window.location.hash=""; //chrome
                window.onhashchange=function(){window.location.hash="";};
                $('#button').jqxButton({
                    width: 100,
                    theme : 'darkblue'
                });
            });            
        </script>
    </head>
    <body class='login wp-core-ui'>
        <div id='login'>
            <table style='width:100%'>
                <tbody>
                    <tr>
                        <td align='center'>
                            <h1 style='font-size: 45px; color: #004a73;'>Activar</h1>
                        </td>
                        <td align='right'>                            
                            <img width='100' src='content/pictures-system/logo.png' alt='Logo'>
                        </td>
                    </tr>
                </tbody>
            </table>
            <form  method='post' action='login.jsp'>
                <div style="padding: 26px 24px 10px;">
                    <p class='message'>Para ingresar al sistema por primera ves es necesario validar tu cuenta via email, para ello ingresa a tu correo y activa tu cuenta...</p>
                    <br>
                    <p class='submit' style='text-align: center'>
                        <input type='submit' value='Aceptar' id='button' />
                    </p>
                </div>
            </form>
            <div class='clear'></div>
        </div>
    </body>
</html>