<%-- 
    Document   : newjsp
    Created on : 27/02/2016, 10:47:23 AM
    Author     : CARLOS ANTONIO
--%>
<%
    String versionjqwidgets="jqwidgets-ver3.9.1";
    if(session.getAttribute("fl_user_name") != null){%>
        <!DOCTYPE html>
        <html lang="en">
            <head>
                <title id="Description">Client Lab Manager</title>
                <link rel="stylesheet" href="content/files-jq/<%out.print(versionjqwidgets);%>/jqwidgets/styles/jqx.base.css" type="text/css" />
                <link rel="stylesheet" href="content/files-jq/<%out.print(versionjqwidgets);%>/jqwidgets/styles/jqx.darkblue.css" type="text/css" />
                <link rel="stylesheet" href="content/files-jq/<%out.print(versionjqwidgets);%>/jqwidgets/styles/jqx.arctic.css" type="text/css" />
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
                <script type="text/javascript" src="content/files-jq/jquery-2.1.4.min.js"></script>
                <script type="text/javascript" src="content/files-jq/<%out.print(versionjqwidgets);%>/jqwidgets/jqxcore.js"></script>
                <script type="text/javascript" src="content/files-jq/<%out.print(versionjqwidgets);%>/jqwidgets/jqxbuttons.js"></script>
                <script type="text/javascript" src="content/files-jq/<%out.print(versionjqwidgets);%>/jqwidgets/jqxscrollbar.js"></script>
                <script type="text/javascript" src="content/files-jq/<%out.print(versionjqwidgets);%>/jqwidgets/jqxpanel.js"></script>
                <script type="text/javascript" src="content/files-jq/<%out.print(versionjqwidgets);%>/jqwidgets/jqxtree.js"></script>
                <script type="text/javascript" src="content/files-jq/<%out.print(versionjqwidgets);%>/jqwidgets/jqxexpander.js"></script>
                <script type="text/javascript" src="content/files-jq/<%out.print(versionjqwidgets);%>/jqwidgets/jqxsplitter.js"></script>
                <script type="text/javascript" src="content/files-jq/<%out.print(versionjqwidgets);%>/jqwidgets/jqxtabs.js"></script>
                <script type="text/javascript" src="content/files-jq/<%out.print(versionjqwidgets);%>/jqwidgets/jqxscrollbar.js"></script>
                <script type="text/javascript" src="content/files-jq/<%out.print(versionjqwidgets);%>/jqwidgets/jqxmenu.js"></script>
                <script type="text/javascript" src="content/files-jq/<%out.print(versionjqwidgets);%>/jqwidgets/jqxdata.js"></script>
                <script type="text/javascript" src="content/files-jq/<%out.print(versionjqwidgets);%>/jqwidgets/jqxgrid.js"></script>
                <script type="text/javascript" src="content/files-jq/<%out.print(versionjqwidgets);%>/jqwidgets/jqxgrid.columnsresize.js"></script> 
                <script type="text/javascript" src="content/files-jq/<%out.print(versionjqwidgets);%>/jqwidgets/jqxlistbox.js"></script>
                <script type="text/javascript" src="content/files-jq/<%out.print(versionjqwidgets);%>/jqwidgets/jqxdropdownlist.js"></script>
                <script type="text/javascript" src="content/files-jq/<%out.print(versionjqwidgets);%>/jqwidgets/jqxdragdrop.js"></script>
                <script type="text/javascript" src="content/files-jq/<%out.print(versionjqwidgets);%>/jqwidgets/jqxwindow.js"></script>
                <script type="text/javascript" src="content/files-jq/<%out.print(versionjqwidgets);%>/jqwidgets/jqxnavigationbar.js"></script>
                <script type="text/javascript" src="content/files-jq/<%out.print(versionjqwidgets);%>/jqwidgets/jqxpopover.js"></script>
                <script type="text/javascript" src="content/files-js/index.js"></script>
                <script class="external">/*
                    //on http server use document.domain instead od "localhost"
                    //Start the websocket client
                    var socket = new WebSocket("ws://10.10.20.153:8887/");
                    //When the connection is opened, login.
                    socket.onopen = function() { 
                        console.log("Opened socket.");
                        //register the user
                        socket.send("{'action':'addClient', 'rolClient':'manager'}");
                    };
                    //When received a message, parse it and either add/remove user or post message.
                    socket.onmessage = function(a) {
                        //process the message here
                        var message = JSON.parse(a.data);
                        console.log(message);
            //            if (message.addUser) {
            //                alert("El usuario "+message.addUser+" fue agregado");
            //            } else if (message.removeUser) {
            //                alert("El usuario "+message.removeUser+" fue borrado");
            //            } else if (message.message) {
            //                alert(message.message);
            //            }
                    };
                    socket.onclose = function() { 
                        console.log("Connection wasn´t posible"); 
                    };
                    socket.onerror = function() { 
                        alert("El servidor es inaccesible");
                    };
                    function sendMessage(messageData, rolClient){
                        socket.send('{"action":"message", "content": [{"body":"'+messageData+'", "rolClient":"'+rolClient+'"}]}');
                    }*/
                </script>
                <script>
                    function disableselect(e){return false;}
                    function reEnable(){return true;}
                    document.onselectstart=new Function ("return false");
                    if (window.sidebar){document.onmousedown=disableselect; document.onclick=reEnable;}
                </script>
                <script type="text/javascript">
                    var height = $(window).height()-116;
                    var theme = "darkblue";
                    $(document).ready(function () {
                        // Create jqxTree
                        function sourceTree(treeIndex){
                            var source = [];
                            if(treeIndex==0){
                                source = [
                                    {
                                        icon: "content/pictures-system/icon-menu/computer.png", label: "Laboratorios", expanded: true, items: [
                                            { 
                                                icon: "content/pictures-system/icon-menu/monitoring.png", label: "Monitorear", items: [
                                                    { icon: "content/pictures-system/icon-menu/laboratory.png", label: "Lab1" },
                                                    { icon: "content/pictures-system/icon-menu/laboratory.png", label: "Lab2" },
                                                    { icon: "content/pictures-system/icon-menu/laboratory.png", label: "Lab3" }
                                                ]
                                            },
                                            { 
                                                icon: "content/pictures-system/icon-menu/services.png", label: "Servicios" 
                                            }
                                        ]
                                    }
                                ];
                            }
                            if(treeIndex==1){
                                source = [
                                    {
                                        icon: "content/pictures-system/icon-menu/distributor-report.png", label: "Reportes", expanded: true, items: [
                                            { icon: "content/pictures-system/icon-menu/student.png", label: "Alumnos" },
                                            { icon: "content/pictures-system/icon-menu/teachers.png", label: "Profesores" },
                                            { icon: "content/pictures-system/icon-menu/inventory.png", label: "Inventaio" },
                                            { icon: "content/pictures-system/icon-menu/maintenance.png", label: "Mantenimiento" }
                                        ]
                                    }
                                ];
                            }
                            if(treeIndex==2){
                                source = [
                                    { 
                                        icon: "content/pictures-system/icon-menu/admin.png", label: "Administración", expanded: true, items: [
                                            { icon: "content/pictures-system/icon-menu/laboratory-add.png", label: "Laboratorios" },
                                            { icon: "content/pictures-system/icon-menu/computer-add.png", label: "Equipos" }
                                        ]
                                    },
                                    { 
                                        icon: "content/pictures-system/icon-menu/note.png", label: "Notas" 
                                    },
                                    { 
                                        icon: "content/pictures-system/icon-menu/settings.png", label: "Configuraciones" 
                                    },
                                    { 
                                        icon: "content/pictures-system/icon-menu/user-acount.png", label: "Ajustes" 
                                    }
                                ];
                            }
                            return source;
                        }

                        $("#jqxNavigationBar").jqxNavigationBar({  
                            height: height-30, 
                            width: "100%", 
                            expandMode: "singleFitHeight",
                            theme : theme
                        });
                        // Create jqxTree
                        var treeIndex = 0;
                        var item;
                        var args;
                        $('[data-rol="tree"]').each(function (){
                            $('#jqxTree'+treeIndex).jqxTree({
                                theme: theme,  
                                height: 400, 
                                width: "auto", 
                                source: sourceTree(treeIndex) 
                            });                
                            treeIndex = treeIndex+1;
                            if(treeIndex==3)treeIndex=0;
                        });     
                        $('[data-rol="tree"]').on('select', function (event) {
                            args = event.args;
                            item = $(this).jqxTree('getItem', args.element);
                            var label = item.label; 
                            if(label==="Lab3"){
                                $(".external").remove();
                                $("#loadContent").load("content/data-jsp/views-external/monitoring/monitoring.jsp");
                            }else{
                                $("#loadContent").html("<div style='margin: 10px;'>" + label + "</div>");
                            }
                        });
                        $("#jqxWidgetHeader").jqxPanel({ width: 'auto', height: 90});
                        $("#splitter").jqxSplitter({
                            theme:theme,  
                            width: "auto", 
                            height: height, 
                            panels: [{ size: 200 }] 
                        });
                        $("#jqxExpanderMenu").jqxExpander({
                            theme:theme, 
                            width: 'auto', 
                            height: height, 
                            showArrow: false,
                            toggleMode: "none"
                        });
                        $("#jqxExpanderContent").jqxExpander({
                            theme:theme, 
                            width: 'auto', 
                            height: height, 
                            showArrow: false,
                            toggleMode: "none"
                        });
                        $("#jqxWidgetFooter").jqxPanel({ width: 'auto', height: 20});
                        $(window).resize(function (){
                            height = $(window).height()-116;
                            $("#splitter").jqxSplitter({height: height});
                            $("#jqxExpanderMenu").jqxExpander({height: height});
                            $("#jqxExpanderContent").jqxExpander({height: height});
                            $("#jqxNavigationBar").jqxNavigationBar({height: height-30}); 
                        });
                        $("#buttonArrow").jqxButton({ width: "auto", height: 20});
                        $("#popover").jqxPopover({
                            offset: {left: -10, top:0}, 
                            arrowOffsetValue: 50, 
                            title: "Opsiones", 
                            showCloseButton: true, 
                            theme: theme,
                            selector: $("#buttonArrow"),
                            initContent: function(){

                            } 
                        });
                        $("#jqxMenu").jqxMenu({ 
                            width: '160px', 
                            height: 'auto', 
                            mode: 'vertical',
                            theme : 'arctic'
                        });                    
                        $("#jqxMenu").css('visibility', 'visible');
                        $(".jqx-popover-content").css('padding','0px');
                    });
                </script>
            </head>
            <body class='default'>
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
                <div id="splitter">
                    <div>
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
                                <span>Tareas</span>                    
                            </div>
                            <div id="loadContent"></div>
                        </div>
                    </div>
                </div>
                <div id='jqxWidgetFooter'>
                    <div style="padding-left: 15px">Todos los derechos recervados 2015</div>
                </div>
            </body>
        </html><%
    }else{
        response.sendRedirect("login.jsp");
    }
%>