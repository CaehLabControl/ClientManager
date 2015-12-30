<!DOCTYPE html>
<html lang="en">
<head>
    <title id="Description">Client Lab Manager</title>
    <link rel="stylesheet" href="content/files-jq/jqwidgets-ver3.9.1/jqwidgets/styles/jqx.base.css" type="text/css" />
    <link rel="stylesheet" href="content/files-jq/jqwidgets-ver3.9.1/jqwidgets/styles/jqx.darkblue.css" type="text/css" />
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
    <script type="text/javascript" src="content/files-jq/jqwidgets-ver3.9.1/jqwidgets/jqxcore.js"></script>
    <script type="text/javascript" src="content/files-jq/jqwidgets-ver3.9.1/jqwidgets/jqxbuttons.js"></script>
    <script type="text/javascript" src="content/files-jq/jqwidgets-ver3.9.1/jqwidgets/jqxscrollbar.js"></script>
    <script type="text/javascript" src="content/files-jq/jqwidgets-ver3.9.1/jqwidgets/jqxpanel.js"></script>
    <script type="text/javascript" src="content/files-jq/jqwidgets-ver3.9.1/jqwidgets/jqxtree.js"></script>
    <script type="text/javascript" src="content/files-jq/jqwidgets-ver3.9.1/jqwidgets/jqxexpander.js"></script>
    <script type="text/javascript" src="content/files-jq/jqwidgets-ver3.9.1/jqwidgets/jqxsplitter.js"></script>
    <script type="text/javascript" src="content/files-jq/jqwidgets-ver3.9.1/jqwidgets/jqxtabs.js"></script>
    <script type="text/javascript" src="content/files-jq/jqwidgets-ver3.9.1/jqwidgets/jqxscrollbar.js"></script>
    <script type="text/javascript" src="content/files-jq/jqwidgets-ver3.9.1/jqwidgets/jqxmenu.js"></script>
    <script type="text/javascript" src="content/files-jq/jqwidgets-ver3.9.1/jqwidgets/jqxdata.js"></script>
    <script type="text/javascript" src="content/files-jq/jqwidgets-ver3.9.1/jqwidgets/jqxgrid.js"></script>
    <script type="text/javascript" src="content/files-jq/jqwidgets-ver3.9.1/jqwidgets/jqxgrid.columnsresize.js"></script> 
    <script type="text/javascript" src="content/files-jq/jqwidgets-ver3.9.1/jqwidgets/jqxlistbox.js"></script>
    <script type="text/javascript" src="content/files-jq/jqwidgets-ver3.9.1/jqwidgets/jqxdropdownlist.js"></script>
    <script type="text/javascript" src="content/files-jq/jqwidgets-ver3.9.1/jqwidgets/jqxdragdrop.js"></script>
    <script type="text/javascript" src="content/files-jq/jqwidgets-ver3.9.1/jqwidgets/jqxwindow.js"></script>
    <script class="external">
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
        }
    </script>
    <script>
        function disableselect(e){return false;}
        function reEnable(){return true;}
        document.onselectstart=new Function ("return false");
        if (window.sidebar){document.onmousedown=disableselect; document.onclick=reEnable;}
    </script>
    <script type="text/javascript">
        var height = $(window).height()-116;
        $(document).ready(function () {
            // Create jqxTree
            var source = [
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
                },
                {
                    icon: "content/pictures-system/icon-menu/distributor-report.png", label: "Reportes", expanded: false, items: [
                        { icon: "content/pictures-system/icon-menu/student.png", label: "Alumnos" },
                        { icon: "content/pictures-system/icon-menu/teachers.png", label: "Profesores" },
                        { icon: "content/pictures-system/icon-menu/inventory.png", label: "Inventaio" },
                        { icon: "content/pictures-system/icon-menu/maintenance.png", label: "Mantenimiento" }
                    ]
                },
                { 
                    icon: "content/pictures-system/icon-menu/settings.png", label: "Configuración" 
                },
                { 
                    icon: "content/pictures-system/icon-menu/note.png", label: "Notas" 
                }
            ];
            // Create jqxTree
            $('#jqxTree').jqxTree({
                theme:"darkblue",  
                height: '100%', 
                width: '100%', 
                source: source, 
            });
            $("#jqxWidgetHeader").jqxPanel({ 
                width: 'auto', 
                height: 90
            });
            $("#splitter").jqxSplitter({
                theme:"darkblue",  
                width: "auto", 
                height: height, 
                panels: [{ size: 200 }] 
            });
            $("#jqxExpanderMenu").jqxExpander({
                theme:"darkblue", 
                width: 'auto', 
                height: height, 
                showArrow: false,
                toggleMode: "none"
            });
            $("#jqxExpanderContent").jqxExpander({
                theme:"darkblue", 
                width: 'auto', 
                height: height, 
                showArrow: false,
                toggleMode: "none"
            });
            $('#jqxTree').on('select', function (event) {
                var args = event.args;
                var item = $('#jqxTree').jqxTree('getItem', args.element);
                var label = item.label; 
                if(label==="Lab3"){
                    $(".external").remove();
                    $("#loadContent").load("content/data-jsp/views-external/monitoring/monitoring.jsp");
                }else{
                    $("#loadContent").html("<div style='margin: 10px;'>" + label + "</div>");
                }
                
            });
            $("#jqxWidgetFooter").jqxPanel({ width: 'auto', height: 20});
            $(window).resize(function (){
                height = $(window).height()-116;
                $("#splitter").jqxSplitter({height: height});
                $("#jqxExpanderMenu").jqxExpander({height: height});
                $("#jqxExpanderContent").jqxExpander({height: height});
            });
        });
    </script>
</head>
<body class='default'>
    <div id='jqxWidgetHeader' style=" font-size: 13px; font-family: Verdana;">
        <span style="float: left; padding-left: 15px; font-size: 70px; color: rgb(0, 74, 115);">Control Laboratorio</span>
        <div style='padding-left: 15px;'>
            <img src="content/pictures-system/server.png" style="width: 90px; float: right">
        </div>
        <!--Content-->
        <div style='white-space: nowrap;'>
        </div>
    </div>
    <div id="splitter">
        <div>
            <div id='jqxExpanderMenu'>
                <div>Menu</div>
                <div>
                    <div style="border: none;" id='jqxTree'></div>
                </div>
            </div>   
        </div>
        <div id="ContentPanel">
            <div id='jqxExpanderContent'>
                <div>Acciones</div>
                <div id="loadContent"></div>
            </div>
        </div>
    </div>
    <div id='jqxWidgetFooter'>
        <div style="padding-left: 15px">Todos los derechos recervados 2015</div>
    </div>
</body>
</html>