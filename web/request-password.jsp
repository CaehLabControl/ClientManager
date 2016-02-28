<%
    String versionjqwidgets="jqwidgets-ver3.9.1";
%>
<!DOCTYPE html>
<html lang="en-US">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Solicitar contraseña</title>
        <script type="text/javascript" data-version="3.9.1" data-where="request-password" src="content/files-jq/jquery-2.1.4.min.js"></script>
        <script type="text/javascript" data-where="request-password" src="content/files-js/oc-requiere-script.js"></script>
    </head>
    <body class="login wp-core-ui">
        <div id="login">
            <table style="width:100%">
                <tbody>
                    <tr>
                        <td align="center">
                            <h1 style="font-size: 55px; color: #004a73;">Solicitar</h1>
                        </td>
                        <td align="right">                            
                            <img width="100" src="content/pictures-system/logo.png" alt="Logo">
                        </td>
                    </tr>
                </tbody>
            </table>
            
            <form name="requestPasswordForm" id="requestPasswordForm"  method="post" action="reset-password.html">
                <div style="display: none; height: 282px" id="windowBlock">
                    <div id="WindowLoad"></div>
                    <div id="loadingPicture"></div>
                </div>  
                <input type="hidden" name="action" value="requestPassword"/>
                <div style="padding: 26px 24px 10px;">
                    <p class="message">Por favor ingresa el correo o el usuario antes registrado.</p>
                    <br>
                    <p>
                        <label for="user_name">Nombre de usuario o Correo<br>
                        <input name="user_name" id="user_name" class="input" size="20" type="text" placeholder="Usuario o Correo"></label>
                    </p>
                    <p class="submit" style="text-align: center">
                        <input type="submit" value="Solicitar nueva contraseña" id="buttonRequestPassword" />
                    </p>
                    <br>
                    <p style="text-align: left">
                        <label><a href="login.jsp">Iniciar sesión</a><br></label>
                    </p>
                    <br>
                </div>
            </form>
            <br>            
            <div class="clear"></div>
            <form style="display: none" id="indicationsResetPassword"  method='post' action='login.jsp'>
                <div style="padding: 26px 24px 10px;">
                    <p class='message'>Has solicitado cambiar tu contraseña para continuar ingresa a tu correo y sigue las instrucciones...</p>
                    <br>
                    <p class='submit' style='text-align: center'>
                        <input type='submit' value='Aceptar' id='button' />
                    </p>
                </div>
            </form>
        </div>
    </body>
</html>