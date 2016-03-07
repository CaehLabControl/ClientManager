<%-- 
    Document   : newjsp
    Created on : 27/02/2016, 10:47:23 AM
    Author     : CARLOS ANTONIO
--%>
<%
    String versionjqwidgets="jqwidgets-ver3.9.1";
    if(session.getAttribute("fl_user_name") == null){%>
        <!DOCTYPE html>
        <html lang="en-US">
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                <title>Login</title>
                <script type="text/javascript" data-version="3.9.1" data-where="login" src="content/files-jq/jquery-2.1.4.min.js"></script>
                <script type="text/javascript" data-where="login" src="content/files-js/oc-requiere-script.js"></script>
            </head>
            <body class="login wp-core-ui">
                <div id="login">
                    <table style="width:100%">
                        <tbody>
                            <tr>
                                <td align="center">
                                    <h1 style="font-size: 65px; color: #004a73;">Login</h1>
                                </td>
                                <td align="right">                            
                                    <img width="100" src="content/pictures-system/logo.png" alt="Logo">
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <form name="loginForm" id="loginForm"  method="post" action="index.jsp">
                        <div style="display: none" id="windowBlock">
                            <div id="WindowLoad"></div>
                            <div id="loadingPicture"></div>
                        </div>    
                        <div style="padding: 26px 24px 10px;">
                            <input type="hidden" name="login" value="in" />
                            <p>
                                <label for="user_name">Usuario<br>
                                <input name="user_name" id="user_name" class="input" size="20" type="text" placeholder="Nombre de usuario"></label>
                            </p>
                            <p>
                                <label for="user_password">Contraseña<br>
                                <input name="user_password" id="user_password" class="input" value="" size="20" type="password" placeholder="Contraseña"></label>
                            </p>
                            <p class="forgetmenot">
                                <label for="rememberme"><input name="rememberme" id="rememberme" value="forever" type="checkbox"> Mantenerme en sesión</label>
                            </p>
                            <br><br>
                            <p class="submit" style="text-align: center">
                                <input type="submit" value="Ingresar" id="buttonLogin" />
                            </p>
                            <br>
                            <div style="height: 20px">
                                <p style="float: left">
                                    <label><a href="register.html">Registrar</a></label>
                                </p>
                                <p style="float: right">
                                    <label><a href="request-password.jsp">Olvide mi contraseña</a><br></label>
                                </p>
                            </div>
                        </div>
                    </form>                    
                    <div class="clear" style="float: left; display: none; color: red; margin-left: 10px">Los datos ingresados no son correctos</div>
                    <div style="margin-left: 10px; float: right; color: rgb(0, 74, 115);">Versión 1.0.0</div>
                </div>
            </body>
        </html><%
    }else{
        response.sendRedirect("");
    }
%>