<%@page import="mx.app.src.mysql.model.UsersModel"%>
<%@page import="mx.app.src.mysql.control.UsersControl"%>
<%@page import="mx.app.src.dao.extend.aes"%>
<%
    String statusResetPassword="";
    UsersModel obj = new UsersModel();
    if(request.getParameter("rp")!=null){
        aes sec = new aes();
        sec.addKey("2015");
        String liga = request.getParameter("rp");
        liga = sec.desencriptar(liga.replace(" ", "+"));
        String[] ligaSplit = liga.split("&&");        
        if(ligaSplit[0].contains("userName") && ligaSplit[1].contains("mail") && ligaSplit[2].contains("count")){
            String[] userName = ligaSplit[0].split("=");
            String[] mail = ligaSplit[1].split("=");
            String[] countChangePassword = ligaSplit[2].split("=");
            obj.setFl_user_name(userName[1]);
            obj.setFl_mail(mail[1]);
            obj.setFl_password_changed_count(Integer.parseInt(countChangePassword[1]));
            if(new UsersControl().userStatusKeyRequestNewPassword(obj.getFl_user_name(), obj.getFl_password_changed_count())){
                statusResetPassword="expired";
            }
        }else{
            response.sendRedirect("");
        }     
    }else{
        response.sendRedirect("");
    }
    if(statusResetPassword.equals("expired")){%>
        <!DOCTYPE html>
        <html lang="en-US">
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                <title>Pagina caducada</title>
                <link rel="stylesheet" href="content/files-css/wp-admin.css" type="text/css" media="all">
                <link rel="stylesheet" href="content/files-css/buttons.css" type="text/css" media="all">
                <link rel="stylesheet" href="content/files-css/colors-fresh.css" type="text/css" media="all">
                <link rel="stylesheet" href="content/files-jq/jqwidgets-ver3.9.1/jqwidgets/styles/jqx.base.css" type="text/css" />
                <link rel="stylesheet" href="content/files-jq/jqwidgets-ver3.9.1/jqwidgets/styles/jqx.darkblue.css" type="text/css" />
                <script type="text/javascript" src="content/files-jq/jqwidgets-ver3.9.1/scripts/jquery-1.11.1.min.js"></script>
                <script type="text/javascript" src="content/files-jq/jqwidgets-ver3.9.1/jqwidgets/jqxcore.js"></script>
                <script type="text/javascript" src="content/files-jq/jqwidgets-ver3.9.1/jqwidgets/jqxloader.js"></script>
                <script type="text/javascript" src="content/files-jq/jqwidgets-ver3.9.1/jqwidgets/jqxbuttons.js"></script>
                <script type="text/javascript">
                    $(document).ready(function () {
                        $("#button").jqxButton({
                            width: 100,
                            theme : "darkblue"
                        });
                    });            
                </script>
            </head>
            <body class="login wp-core-ui">
                <div id="login">
                    <table style="width:100%">
                        <tbody>
                            <tr>
                                <td align="center">
                                    <h1 style="font-size: 45px; color: #004a73;">Caducada</h1>
                                </td>
                                <td align="right">                            
                                    <img width="100" src="content/pictures-system/logo.png" alt="Logo">
                                </td>
                            </tr>
                        </tbody>
                    </table>

                    <form method="post" action="login.jsp">
                        <div style="padding: 26px 24px 10px;">
                            <p class="message reset-pass">El link de esta página a caducado :/</p>
                            <br>
                            <p class="submit" style="text-align: center">
                                <input type="submit" value="Salir" id="button" />
                            </p>
                            <br>
                        </div>
                    </form>
                    <br>            
                    <div class="clear"></div>
                </div>
            </body>
        </html>        
    <%}else{%>
        <!DOCTYPE html>
        <html lang="en-US">
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                <title>Recuperar contraseña</title>
                <script type="text/javascript" data-version="3.9.1" data-where="reset-password" src="content/files-jq/jquery-2.1.4.min.js"></script>
                <script type="text/javascript" data-where="reset-password" src="content/files-js/oc-requiere-script.js"></script>
            </head>
            <body class="login wp-core-ui">
                <div id="login">
                    <table style="width:100%">
                        <tbody>
                            <tr>
                                <td align="center">
                                    <h1 style="font-size: 45px; color: #004a73;">Recuperar</h1>
                                </td>
                                <td align="right">                            
                                    <img width="100" src="content/pictures-system/logo.png" alt="Logo">
                                </td>
                            </tr>
                        </tbody>
                    </table>

                    <form name="resetPasswordForm" id="resetPasswordForm" method="post" action="status-reset-password.html">
                        <div style="display: none; height: 295px" id="windowBlock">
                            <div id="WindowLoad"></div>
                            <div id="loadingPicture"></div>
                        </div>
                        <input name="action" value="changePassword" type="hidden" />
                        <input name="user_name" value="<%out.print(obj.getFl_user_name());%>" type="hidden"/>
                        <div style="padding: 26px 24px 10px;">
                            <p class="message reset-pass">Porfavor ingresa la nueva contraseña</p>
                            <br>
                            <p>
                                <label for="new_password">Nueva contraseña<br>
                                <input name="new_password" id="new_password" class="input" size="20" type="password" placeholder="Nueva contraseña"></label>
                            </p>
                            <p>
                                <label for="same_password">Repetir contraseña<br>
                                <input name="same_password" id="same_password" class="input" value="" size="20" type="password" placeholder="Repetir contraseña"></label>
                            </p>
                            <br>
                            <p class="submit" style="text-align: center">
                                <input type="submit" value="Cambiar" id="buttonReset" />
                            </p>
                            <br>
                        </div>
                    </form>
                    <br>            
                    <div class="clear"></div>
                    <form style="display: none" name="formExit" id="formExit"  method="post" action="login.jsp">
                        <div style="padding: 26px 24px 10px;">
                            <p class="message">La contraseña fue cambiada exitosamente, a hora puedes iniciar sesión con normalidad.</p>
                            <br>
                            <p class="submit" style="text-align: center">
                                <input type="submit" value="Aceptar" id="button" />
                            </p>
                            <br>            
                        </div>
                    </form>
                </div>
            </body>
        </html><%
    }
%>