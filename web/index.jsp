<%-- 
    Document   : newjsp
    Created on : 27/02/2016, 10:47:23 AM
    Author     : CARLOS ANTONIO
--%>
<%
    if(session.getAttribute("fl_user_name") != null){%>
        <!DOCTYPE html>
        <html lang="en">
            <head>
                <title id="Description">Client Lab Manager</title>
                <script type="text/javascript"  data-where="index" src="content/files-jq/jquery-2.1.4.min.js"></script>
                <script type="text/javascript" data-where="index" src="content/files-js/oc-requiere-script.js"></script>
                <style type="text/css">
                    body{
                        padding: 0px;
                        margin: 0px;
                        -webkit-user-select: none;
                        -moz-user-select: none;
                        -ms-user-select: none;
                        user-select: none; 
                    }
                </style>
            </head>
            <body>
                <div id="jqxWindowAbout">
                    <div>
                        <img style="width: 20px;" src="content/pictures-system/icon-popoper/about.png" alt="ad"/> 
                        <span style="top: 9px; position: absolute; left: 30px;">Acerca de...</span>
                    </div>
                    <div style="padding: 10px">
                        <img width="45" src="content/pictures-system/logo.png" alt="Logo">
                        <span style="font-size: 28px; color: rgb(0, 74, 115); text-decoration: underline overline; display: inline-grid;">Sizlab</span>
                        <b style="display: block; margin-left: 50px;">Versión 1.0.0</b>
                        <span style=" margin-left: 50px;">Ultima actualización 05/03/2016</span>
                        <br>
                        <span style="display: block; margin-left: 50px;">Licencia <a target="_black" href="https://en.wikipedia.org/wiki/End-user_license_agreement">EULA</a></span>
                        
                        <br>
                        <a href="#" style="display: block; margin-left: 50px; text-decoration: underline">Créditos bajo sizlab team</a>
                        <button style="width: 80px; bottom: 20px; position: absolute; left: 145px;" id="closeAbout">Cerrar</button>
                    </div>
                </div>
                <div id='jqxWidgetHeader' style=" font-size: 13px; font-family: Verdana;">
                    <img width="90" src="content/pictures-system/logo.png" alt="Logo" style="float: left; margin-left: 10px">
                    <span style="float: left; padding-left: 15px; font-size: 70px; color: rgb(0, 74, 115); text-decoration: underline overline; margin-top: 5px">Sizlab</span>
                    <!--Content-->
                    <div style='white-space: nowrap;'>
                        <div style="float: right; margin-top: 50px;">
                            <div id="header">
                                <div style="margin-right: 20px; color: rgb(0, 74, 115);" id="buttonArrow">Hola! Bienvenido<%out.print(" > "+session.getAttribute("fl_user_name"));%></div>
                            </div>
                            <div id="popover" style="display: none">
                                <div id='jqxMenu'>
                                    <ul>
                                        <li><img width="20" style='float: left; margin-right: 5px;' src='content/pictures-system/icon-popoper/home.png' /><span>Inicio</span></li>
                                        <li type='separator'></li>
                                        <li><img width="20" style='float: left; margin-right: 5px;' src='content/pictures-system/icon-popoper/user-acount.png' /><span>Ajustes</span></li>
                                        <li type='separator'></li>
                                        <li><img width="20" style='float: left; margin-right: 5px;' src='content/pictures-system/icon-popoper/help.png' /><span>Ayuda</span></li>
                                        <li><img width="20" style='float: left; margin-right: 5px;' src='content/pictures-system/icon-popoper/about.png' /><span>Acerca de...</span></li>
                                        <li type='separator'></li>
                                        <li><img width="20" style='float: left; margin-right: 5px;' src='content/pictures-system/icon-popoper/log-out.png' /><span>Salir</span></li>
                                    </ul>
                                </div>
                            </div> 
                        </div>
                    </div>
                </div>
                <div id="jqxWidgetBody">
                    <div id="jqxSplitterPrincipal" style="background: #00a2e8">
                        <div id="ContentMenu">
                            <div id='jqxExpanderMenu'>
                                <div>Menu</div>
                                <div>
                                    <div id="jqxNavigationBar">
                                        <div>Control</div>
                                        <div>
                                            <div style="border: none;" data-rol="tree" id='jqxTree0'></div>
                                        </div>
                                        <div>Acciones</div>
                                        <div>
                                            <div style="border: none;" data-rol="tree" id='jqxTree1'></div>
                                        </div>
                                        <div>General</div>
                                        <div>
                                            <div style="border: none;" data-rol="tree" id='jqxTree2'></div>
                                        </div>
                                    </div> 
                                </div>
                            </div>   
                        </div>
                        <div id="ContentPanel">
                            <div id='jqxExpanderContent'>
                                <div id="taskBar">
                                    <span>Tarea</span>                    
                                </div>
                                <div id="loadContent"></div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div id='jqxWidgetFooter'>
                    <div style="padding-left: 15px; float: left; color: rgb(0, 74, 115);">Todos los derechos reservados 2015</div>
                    <div style="margin-left: 10px; float: right; color: rgb(0, 74, 115);">Versión 1.0.0</div>
                </div>
            </body>
        </html><%
    }else{
        response.sendRedirect("login.jsp");
    }
%>