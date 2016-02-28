<%-- 
    Document   : newjsp
    Created on : 27/02/2016, 10:47:23 AM
    Author     : CARLOS ANTONIO
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.userModel"%>
<%@page import="control.userControl"%>
<%@page import="control.aes"%>
<%
    String versionjqwidgets="jqwidgets-ver3.9.1";
    String statusAcount=null;
    if(request.getParameter("ac")!=null){
        aes sec = new aes();
        sec.addKey("2015");
        String liga = request.getParameter("ac");
        liga = sec.desencriptar(liga.replace(" ", "+"));
        if(!liga.contains("userName")){
            response.sendRedirect("");
        }
        String[] ligaSplit = liga.split("&&");
        userModel obj = new userModel();
        if(ligaSplit[0].contains("userName")){
            String[] userName=ligaSplit[0].split("=");
            obj.setFl_user_name(userName[1]);
        }  
        if(ligaSplit[2].contains("password")){
            String[] password=ligaSplit[2].split("=");
            obj.setFl_password(password[1]);
        }  
        ArrayList<userModel> list=new userControl().userLogin(obj);
        for (userModel list1 : list) {
            if (list1.getFl_status_acount().equals("1")) {
                statusAcount="actived";
            }else{
                statusAcount = new userControl().activateAcountUser(obj);
            }
        }
    }else{
        response.sendRedirect("");
    }
    if(statusAcount.equals("Cuenta Activada")){%>
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
                                    <h1 style='font-size: 45px; color: #004a73;'>Estado</h1>
                                </td>
                                <td align='right'>                            
                                    <img width='100' src='content/pictures-system/logo.png' alt='Logo'>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <form name='loginform' id='loginform'  method='post' action='login.jsp'>
                        <div style="padding: 26px 24px 10px;">
                            <p class='message'>Tu cuenta fue activada exitosamente inicia sesión para interactuar con Sizlab.</p>
                            <br>
                            <p class='submit' style='text-align: center'>
                                <input type='submit' value='Aceptar' id='button' />
                            </p>
                        </div>
                    </form>
                    <div class='clear'></div>
                </div>
            </body>
        </html><%
    }else{response.sendRedirect("");%>
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
                                    <h1 style='font-size: 45px; color: #004a73;'>Estado</h1>
                                </td>
                                <td align='right'>                            
                                    <img width='100' src='content/pictures-system/logo.png' alt='Logo'>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <form name='loginform' id='loginform'  method='post' action='login.jsp'>
                        <div style="padding: 26px 24px 10px;">
                            <p class='message'>Esta cuenta ya fué activada anteriormente.</p>
                            <br>
                            <p class='submit' style='text-align: center'>
                                <input type='submit' value='Aceptar' id='button' />
                            </p>
                        </div>
                    </form>
                    <div class='clear'></div>
                </div>
            </body>
        </html><%
    }
%>