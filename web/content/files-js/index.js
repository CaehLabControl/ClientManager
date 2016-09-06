/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/*
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


//function disableselect(e){return false;}
//function reEnable(){return true;}
//document.onselectstart=new Function ("return false");
//if (window.sidebar){document.onmousedown=disableselect; document.onclick=reEnable;}
var height = $(window).height()-116;
var width = $(window).width()-2;
// Create jqxTree
var treeIndex = 0;
var item;
var args;
// Create jqxTree
function sourceTree(){
    var source = {
        url:"ItemsMenuService?view",
        datatype: "json",
        datafields: [
            { name: 'id' },
            { name: 'parentid' },
            { name: 'text' },
            { name: 'icon' },
            { name: 'expanded' }
        ],
        type:"POST",
        async: false
    };
    return source;
}
$(document).ready(function (){       
    $("body").width(width+2);
    var dataAdapter = new $.jqx.dataAdapter(sourceTree(), {
        loadComplete: function (records) {
            // get data records.
            // get the length of the records array.
            var length = records.length;
            // loop through the records and display them in a table.   
            data = records;
            for(var i=0; i<length;i++){
                var dataAdapterItems = new $.jqx.dataAdapter(data[i]);
                dataAdapterItems.dataBind();
                var recordsItems = dataAdapterItems.getRecordsHierarchy('id', 'parentid', 'items', [{expanded: false, name: 'text', map: 'label', icon: 'icon'}]);
                $('#jqxTree'+i).jqxTree({
                    theme: theme,  
                    height: height-157, 
                    width: "100%", 
                    source: recordsItems 
                }); 
                
            }
            
        },
        loadError: function (jqXHR, status, error) {
        },
        beforeLoadComplete: function (records) {
            $('[data-rol="tree"]').jqxTree('collapseAll');
        }
    });
    // perform Data Binding.
    dataAdapter.dataBind();
                
    $("#jqxNavigationBar").jqxNavigationBar({  
        width: "100%", 
        expandMode: "toggle",//"singleFitHeight",
        theme : theme,
        expandedIndexes: sessionStorage.getItem("expandedItem") || [0]
    });
    var resize=true;
    $('#jqxNavigationBar').on('expandedItem', function (event){
        var expandedItem = event.args.item; 
        sessionStorage.setItem("expandedItem",expandedItem);        
        if(resize){
            $('[data-rol="tree"]').jqxTree('expandAll');
        }
        $('[data-rol="tree"]').jqxTree('selectItem', null);
        var items = $('#jqxTree'+expandedItem).jqxTree('getItems');
        $('#jqxTree'+expandedItem).jqxTree('selectItem', items[0]);
    });        
    $('[data-rol="tree"]').on('select', function (event) {
        args = event.args;        
        item = $(this).jqxTree('getItem', args.element);
        var label = item.label; 
        sessionStorage.setItem("selectedItemId",item.id);
        sessionStorage.setItem("selectedItemParentId",item.parentId);
        var treeIndex = $(label).attr("data-indextree");
        sessionStorage.setItem("treeIndex",("#jqxTree"+treeIndex));
        $(".external").empty();
        $(".external").remove();
        label=$(label).text();
        eventResize();
        if(label==="Lab3"){
            $("#loadContent").load("content/data-jsp/views-external/monitoring/monitoring.jsp");
        }
        if(label==="Centros de computo"){
            $.ajax({
                async: true,
                type: "POST",
                url: "content/data-jsp/views-external/laboratories/admin-laboratories.jsp",
                dataType: 'html',
                beforeSend: function (xhr) {
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert("Error interno del servidor");
                },
                success: function (data, textStatus, jqXHR) {
                    $("#loadContent").empty();
                    $("#loadContent").html(data);
                }
            });
        }
        else{
            $("#loadContent").html("<div style='margin: 10px;'>" + label + "</div>");
        }
    });
    $('[data-rol="tree"]').jqxTree('expandAll');
    $(sessionStorage.getItem("treeIndex") || "#jqxTree0").jqxTree('selectItem', ($("#"+sessionStorage.getItem("selectedItemId"))[0] || null));
    
    $("#jqxWidgetHeader").jqxPanel({ width: 'auto', height: 90});
    $("#jqxWidgetBody").jqxPanel({ width: 'auto', height: height, autoUpdate:true});
    $("#jqxSplitterPrincipal").jqxSplitter({
        theme: theme,  
        width: width, 
        height: "100%", 
        panels: [{ size: sessionStorage.getItem("sizeMenuPanel1")||200 }],
        splitBarSize: 2
    }).css("border", "none");
    function eventResize(){
        $('#jqxSplitterPrincipal').off("resize");
        $('#jqxSplitterPrincipal').on('resize', function (event) { 
            var principalPanels = $('#jqxSplitterPrincipal').jqxSplitter('panels');
            // get first panel.
            var panelPrincipal1 = principalPanels[0];
            // get second panel.
            var panelPrincipal2 = principalPanels[1];
            sessionStorage.setItem("sizeMenuPanel1", panelPrincipal1.size);
        });
    }
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
        theme : theme
    });                    
    $("#jqxMenu").css('visibility', 'visible');
    $(".jqx-popover-content").css('padding','0px');
    $("#jqxWindowAbout").jqxWindow({
        theme: theme, 
//      okButton: $('#okAccess'),
        cancelButton: $('#closeAbout'),
        height: 250,
        width: 380,
        autoOpen: false,
        resizable: false,
        isModal: true,
        position:"center",
        initContent: function (){
            $('#closeAbout').jqxButton({
                theme:theme,
                width: '80px',
                disabled: false
            });
        }
    });   
    
    $('#jqxMenu').on('itemclick', function (event){
        var element = event.args;
        if($(event.target).text()==="Ayuda"){
            window.open("http://www.w3schools.com", "_blank", "toolbar=no, scrollbars=yes, resizable=no, top=100, left=0, width=400, height=500");
        }
        if($(event.target).text()==="Acerca de..."){
            $("#jqxWindowAbout").jqxWindow("open");
        }
        if($(event.target).text()==="Salir"){
            $.ajax({
                async: true,
                type: "POST",
                url: "UsersService",
                data: {
                    "login" : "out"
                },
                dataType: 'json',
                beforeSend: function (xhr) {
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert("Error interno del servidor");
                },
                success: function (data, textStatus, jqXHR) {
                    if(eval(data.status)){
                        window.location="login.jsp";
                    }
                }
            });
        }
    });   
    
});
function initFuntionsManagerLaboratories(){
            var index = 0;
            var indexRow = 0;
            var rowData = null;
            if (undefined == index) index = 0;
            $('#jqxTabsLaboratory').jqxTabs({
                theme: theme,
                selectedItem: index, 
                width: 'auto', 
                height: height-61.5,
                position: 'top',
                showCloseButtons: true
            });
            $('#jqxTabsLaboratory').jqxTabs('hideCloseButtonAt', 0);
            $('#jqxTabsLaboratory').off('tabclick');
            $('#jqxTabsLaboratory').on('tabclick', function (event){ 
                var clickedItem = event.args.item; 
                if(clickedItem==0){
                    $('#jqxTabsLaboratory').jqxTabs('removeAt', 1);
                }
            }); 
            $('#jqxTabsLaboratory').off('add');
            $('#jqxTabsLaboratory').on('add', function (event) {
                $.ajax({
                    async: true,
                    type: "POST",
                    url: "content/data-jsp/views-external/laboratories/computers/admin-computers.jsp",
                    dataType: 'html',
                    beforeSend: function (xhr) {
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        alert("Error interno del servidor");
                    },
                    success: function (data, textStatus, jqXHR) {
                        $("#tabLaboratory").html("");
                        $("#tabLaboratory").html(data);
                    }
                });
            });
            $('#jqxTabsLaboratory').off('removed');
            $('#jqxTabsLaboratory').on('removed', function (event) {
                $("#tabLaboratory").remove();
                sessionStorage.removeItem("pk_laboratory");
            });
            var contextMenu = $("#jqxContextMenuLaboratories").jqxMenu({ 
                width: 130, 
                height: 'auto', 
                autoOpenPopup: false, 
                mode: 'popup',
                theme: theme
            });
            var contextMenuItems = $("#jqxContextMenuItemsLaboratory").jqxMenu({ 
                width: 130, 
                height: 'auto', 
                autoOpenPopup: false, 
                mode: 'popup',
                theme: theme
            });
            function openLaboratory(){
                var titleLastTab = "<img style='width: 18px;' src='content/pictures-system/icon-menu/laboratory.png'/> "+rowData.fl_name;
                $('#jqxTabsLaboratory').jqxTabs('addLast', titleLastTab, '<div style="border: 0px solid;" id="tabLaboratory"></div>');
                $('#jqxTabsLaboratory').jqxTabs('hideCloseButtonAt', 0);
                sessionStorage.setItem("pk_laboratory", rowData.pk_laboratory);
            }
            $("#jqxContextMenuItemsLaboratory, #jqxContextMenuLaboratories").off("itemclick");
            $("#jqxContextMenuItemsLaboratory, #jqxContextMenuLaboratories").on("itemclick", function (event){
                var target = $(event.target).text();
                if($(event.target).text()==="Abrir"){
                    openLaboratory();
                }
                if($(event.target).text()==="Actualizar"){                
                    contextMenu.jqxMenu("close");
                    contextMenuItems.jqxMenu("close");
                    $("#jqxGridItemsLaboratory").jqxGrid("clearselection");
                    $("#detailElement").hide();
                    $("#statusElements").show();
                }
                if($(event.target).text()==="Editar"){
                    $("#formItem").removeClass("formAddItem");
                    $("#formItem").addClass("formUpdateItem");
                    $("#imgFormItem").attr("src","content/pictures-system/icon-context-menu/edit.png");
                    $("#titleFormItem").text("Editar elemento...");
                    $("[name='fl_name']").val(rowData.fl_name);
                    $("[name='fl_description']").val(rowData.fl_description);
                    $("[name='pk_laboratory']").val(rowData.pk_laboratory);
                    $("#jqxWindowItemLaboratory").jqxWindow("open");
                }
                if($(event.target).text()==="Eliminar"){
                    $("#jqxWindowWarningLaboratory").jqxWindow("open");
                }
                if($(event.target).text()==="Nuevo"){
                    $("#formItem").removeClass("formUpdateItem");
                    $("#formItem").addClass("formAddItem");
                    $("#imgFormItem").attr("src","content/pictures-system/icon-context-menu/add.png");
                    $("#titleFormItem").text("Nuevo elemento...");
                    $("[name='fl_name']").val("");
                    $("[name='fl_description']").val("");
                    $("#jqxWindowItemLaboratory").jqxWindow("open");
                }
                if(target==="Nombre"){
                    localStorage.setItem("pt_order","fl_name");
                    changeOrder();
                }
                if(target==="Fecha de creación"){
                    localStorage.setItem("pt_order","fl_row_create_date");
                    changeOrder();
                }
                if(target==="Fecha de modificación"){
                    localStorage.setItem("pt_order","fl_row_update_date");
                    changeOrder();
                }
                if(target==="Ascendente"){
                    localStorage.setItem("pt_type","fl_asc");
                    changeOrder();
                }
                if(target==="Descendente"){
                    localStorage.setItem("pt_type","fl_desc");
                    changeOrder();
                }
                if($(event.target).text()==="Propiedades"){
                     alert("Propiedades")
                }
            });
            var principalPanels = $('#jqxSplitterPrincipal').jqxSplitter('panels');
            var laboratoriesPanels = $('#jqxSplitterLaboratories').jqxSplitter('panels');
            $("#jqxPanelSubLoad").jqxPanel({ width: (principalPanels[1].element[0].clientWidth)-4, height: height-102, autoUpdate: true});

            $("#jqxSplitterLaboratories").jqxSplitter({
                theme: theme,  
                width: (principalPanels[1].element[0].clientWidth), 
                height: "100%", 
                panels: [{ size: sessionStorage.getItem("sizeLaboratoriesPanel1") || 750 }],
                splitBarSize: 1
            });
            if((principalPanels[0].element[0].clientWidth)<=215){
                $("#jqxPanelSubLoad").jqxPanel({width: (principalPanels[1].element[0].clientWidth)});
                $("#jqxSplitterLaboratories").jqxSplitter({width: (principalPanels[1].element[0].clientWidth)-6}); 
            }
            $('#jqxSplitterPrincipal').off('resize');
            $('#jqxSplitterPrincipal').on('resize', function (event) { 
                principalPanels = $('#jqxSplitterPrincipal').jqxSplitter('panels');

                // get first panel.
                var panelPrincipal1 = principalPanels[0];
                // get second panel.
                var panelPrincipal2 = principalPanels[1];
                if((panelPrincipal1.element[0].clientWidth)<=215){
                    $("#jqxPanelSubLoad").jqxPanel({width: (panelPrincipal2.element[0].clientWidth)});
                    $("#jqxSplitterLaboratories").jqxSplitter({width: (panelPrincipal2.element[0].clientWidth)-6});
                }else{
                    $("#jqxPanelSubLoad").jqxPanel({width: (panelPrincipal2.element[0].clientWidth)-4});
                    $("#jqxSplitterLaboratories").jqxSplitter({width: 1150});
                }
                laboratoriesPanels = $('#jqxSplitterLaboratories').jqxSplitter('panels');
                var palelLaboraroties1 = laboratoriesPanels[0];
                var palelLaboraroties2 = laboratoriesPanels[1];
                $(".header-details").width((palelLaboraroties2.element[0].clientWidth)-2);
                $("#jqxPanelItemsDetails").jqxPanel({width: (palelLaboraroties2.element[0].clientWidth)-2});
            });
            $("#jqxWindowItemLaboratory").jqxWindow({
                theme: theme, 
                //okButton: $('#okItem'),
                cancelButton: $('#closeItem'),
                height: 250,
                width: 350,
                autoOpen: false,
                resizable: false,
                isModal: true,
                position:"center",
                initContent: function (){
                    $('#closeItem').jqxButton({
                        theme:theme,
                        width: '80px',
                        disabled: false
                    });
                    $('#okItem').jqxButton({
                        theme:theme,
                        width: '80px',
                        disabled: false
                    });
                    $("#formItem").off("submit");
                    $("#formItem").on("submit", function (){
                       return false; 
                    });
                    $("#okItem").off("click");
                    $("#okItem").on("click", function (){
                        var param;
                        var datas;
                        if($("#formItem").hasClass("formAddItem")){
                            datas = $("#formItem").serialize();  
                            param="addLaboratory";
                        }
                        if($("#formItem").hasClass("formUpdateItem")){
                            datas = $("#formItem").serialize();
                            param="updateLaboratory";
                        }
                        if($("[name='fl_name']").val().length>0){
                            $.ajax({
                                async: true,
                                type: "POST",
                                url: "LaboratoriesService?"+param,
                                data: datas,
                                dataType: 'json',
                                beforeSend: function (xhr) {
                                },
                                error: function (jqXHR, textStatus, errorThrown) {
                                    alert("Error interno del servidor");
                                },
                                success: function (data, textStatus, jqXHR) {
                                    $("#jqxWindowItemLaboratory").jqxWindow('close');
                                    if(data.response==="true"){
                                        changeOrder();
                                    }else if(data.response==="false"){
                                        alert("Elemento no agregado");
                                    }else{
                                        window.location="login.jsp";
                                    }
                                }
                            });
                        }else{
                            $("[name='fl_name']").focusin();
                        }
                    });
                }
            });
            $("#jqxWindowWarningLaboratory").jqxWindow({
                theme: theme, 
                okButton: $('#okWarningLaboratory'),
                cancelButton: $('#closeWarningLaboratory'),
                height: 150,
                width: 350,
                autoOpen: false,
                resizable: false,
                isModal: true,
                position:"center",
                initContent: function (){
                    $('#closeWarningLaboratory').jqxButton({
                        theme:theme,
                        width: '80px',
                        disabled: false
                    });
                    $('#okWarningLaboratory').jqxButton({
                        theme:theme,
                        width: '80px',
                        disabled: false
                    });
                    $("#okWarningLaboratory").off("click");
                    $("#okWarningLaboratory").on("click", function (){
                        var datarecord = rowData;
                        $.ajax({
                            async: true,
                            type: "POST",
                            url: "LaboratoriesService?deleteLaboratory",
                            data: {
                                "pk_laboratory":datarecord.pk_laboratory
                            },
                            dataType: 'json',
                            beforeSend: function (xhr) {
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                alert("Error interno del servidor");
                            },
                            success: function (data, textStatus, jqXHR) {
                                if(data.response==="true"){
                                    $("#jqxWindowWarningLaboratory").jqxWindow("close");
                                    changeOrder();
                                }else if(data.response==="false"){
                                    alert("Elemento no borrado");
                                }
                            }
                        });
                    });
                }
            });
            $('#jqxSplitterLaboratories').off('collapsed');
            $('#jqxSplitterLaboratories').on('collapsed', function (event) {       
                $('#jqxSplitterLaboratories').jqxSplitter('expand');
            });
            $('#jqxSplitterLaboratories').off('resize');
            $('#jqxSplitterLaboratories').on('resize', function (event) {  
                var laboratoriesPanels = event.args.panels;
                // get first panel.
                var laboratoriesPanel1 = laboratoriesPanels[0];
                var laboratoriesPanel2 = laboratoriesPanels[1];
                $("#jqxGridItemsLaboratory").jqxGrid({width: laboratoriesPanel1.size-30});
                // get second panel.
                sessionStorage.setItem("sizeLaboratoriesPanel1", laboratoriesPanel1.size);
                console.log(laboratoriesPanels);
                $("#jqxPanelItemsDetails").jqxPanel({width: laboratoriesPanel2.size || 200});
                $(".header-details").width(laboratoriesPanel2.size);
            });
            var laboratoriesPanels = $('#jqxSplitterLaboratories').jqxSplitter('panels');
            var laboratoriesPanel2 = laboratoriesPanels[1];
            $("#jqxPanelItemsDetails").jqxPanel({
                theme: theme, 
                autoUpdate:true,
                width: (laboratoriesPanel2.element[0].clientWidth), 
                height: (laboratoriesPanel2.element[0].clientHeight-40)
            });
            $(".header-details").width((laboratoriesPanel2.element[0].clientWidth));
            $("#jqxStatusBar").jqxPanel({ theme: theme, width: 'auto', height: 18});
            // open the context menu when the user presses the mouse right button.


            // disable the default browser's context menu.
            $("#jqxTabsLaboratory").off('contextmenu');
            $("#jqxTabsLaboratory").on('contextmenu', function (event) {
                if(rowData==null){
                    var scrollTop = $(window).scrollTop();
                    var scrollLeft = $(window).scrollLeft();
                    var clientYdinamic=0;
                    var clientXdinamic=0;
                    if(contextMenu.height()+10>=($(window).height()-event.clientY)){
                        clientYdinamic=-contextMenu.height();
                    }
                    contextMenu.jqxMenu('open', parseInt(event.clientX) + clientXdinamic  + scrollLeft, parseInt(event.clientY) + clientYdinamic + scrollTop);
                }
                return false;
            });
            $("#panelItemsLaboratories").off('contextmenu');
            $("#panelItemsLaboratories").on('contextmenu', function (event) {
    //            if(rowData==null){
    //                var scrollTop = $(window).scrollTop();
    //                var scrollLeft = $(window).scrollLeft();
    //                var clientYdinamic=0;
    //                var clientXdinamic=0;
    //                if(contextMenu.height()+10>=($(window).height()-event.clientY)){
    //                    clientYdinamic=-contextMenu.height();
    //                }
    //                contextMenu.jqxMenu('open', parseInt(event.clientX) + clientXdinamic  + scrollLeft, parseInt(event.clientY) + clientYdinamic + scrollTop);
    //            }else{
    //                var element = $("#row"+indexRow+"jqxGridItemsLaboratory");
    //                var position = element.position();
    //                var clientYdinamic=0;
    //                var clientXdinamic=0;
    //                alert(contextMenuItems.height()+10)
    //                alert(($(window).height()-event.clientY+position.top))
    //                if(contextMenuItems.height()+10>=($(window).height()-event.clientY-position.top)){
    //                    alert()
    //                    clientYdinamic=-contextMenuItems.height();
    //                }
    //                
    //                console.log(position.top)
    //                var scrollTop = $(window).scrollTop()+position.top+9;
    //                var scrollLeft = $(window).scrollLeft();
    //                contextMenu.jqxMenu("close");
    //                contextMenuItems.jqxMenu('open', parseInt(event.clientX) + clientXdinamic + scrollLeft, parseInt(event.clientY) + clientYdinamic + scrollTop);
    //                return false;
    //            }
                return false;
            });
            function isRightClick(event) {
                var rightclick;
                if (!event) var event = window.event;
                if (event.which) rightclick = (event.which == 3);
                else if (event.button) rightclick = (event.button == 2);
                return rightclick;
            }
            function loadSource(order, type){
                var source =
                {
                    datatype: "json",
                    datafields: [
                        { name: 'pk_laboratory', type: 'int' },
                        { name: 'pk_user', type: 'int' },
                        { name: 'fl_name', type: 'string' },
                        { name: 'fl_description', type: 'string' },
                        { name: 'fl_cant_computers', type: 'string' },
                        { name: 'fl_row_create_date', type: 'string' },
                        { name: 'fl_row_update_date', type: 'string' }
                    ],
                    root: "response",
                    id: 'pk_laboratory',                
                    type: "POST",
                    url: "LaboratoriesService",
                    data : {
                        "selectLaboratoriesByUser":"",
                        "pt_order": order || "",
                        "pt_type": type || ""
                    },
                    async: false
                };
                return source;
            }
            var updatePanel = function (index) {
                var datarecord = rowData;
                if(datarecord!=="undefined"){
                    var table=$("\
                    <table style='width: "+340+"px'>\n\
                        <tbody>\n\
                            <tr>\n\
                                <td colspan='2' style='font-size: 24px;'><b>"+datarecord.fl_name+"</b></td>\n\
                            </tr>\n\
                            <tr>\n\
                                <td colspan='2'>Centro de computo</td>\n\
                            </tr>\n\
                            <tr>\n\
                                <td colspan='2' style='padding-top: 20px;'>\n\
                                    <img src='content/pictures-system/icon-menu/laboratory.png'/>\n\
                                </td>\n\
                            </tr>\n\
                            <tr>\n\
                                <td>Fecha de creación:</td>\n\
                                <td>"+datarecord.fl_row_create_date+"</td>\n\
                            </tr>\n\
                            <tr>\n\
                                <td>Fecha de modificación:</td>\n\
                                <td>"+datarecord.fl_row_update_date+"</td>\n\
                            </tr>\n\
                            <tr>\n\
                                <td>Total de equipos:</td>\n\
                                <td>"+datarecord.fl_cant_computers+"</td>\n\
                            </tr>\n\
                        <tbody>\n\
                    </table>\n\
                    <b style='font-size: 20px;'>Descripción</b><br>\n\
                    <div style='width: "+340+"px'>"+datarecord.fl_description+"</div>\n\
                    ");
                    var container = $('<div style="margin: 5px;"></div>');
                    container.append(table);
                    $("#detailElement").html(container.html());
                    $('#jqxPanelItemsDetails').jqxPanel('append', $("#detailElement")[0]);
                }else{
                    console.log("undefined");
                } 
            };

            function changeOrder(){  
                var src = "content/pictures-system/icon-context-menu/select.png";
                $("li[data-order]").each(function (){
                    if($(this).attr("id")===(localStorage.getItem("pt_order")||"fl_name")){
                        $(this).children("img").attr("src",src);
                        $(this).removeAttr("style");
                    }else{
                        $(this).children("img").attr("src","");
                        $(this).css("padding-left","32px");
                    }
                });
                $("li[data-type]").each(function (){
                    if($(this).attr("id")===(localStorage.getItem("pt_type")||"fl_asc")){
                        $(this).children("img").attr("src",src);
                        $(this).removeAttr("style");
                    }else{
                        $(this).children("img").attr("src","");
                        $(this).css("padding-left","32px");
                    }
                });
                var dataAdapter = new $.jqx.dataAdapter(loadSource(localStorage.getItem("pt_order"),localStorage.getItem("pt_type")),{
                    loadComplete: function (records) {
                        // get data records.
                        // get the length of the records array.
                        var length = records.response.length;
                        // loop through the records and display them in a table.
                        $(".numberElements").text(length); 
                        console.log("loadComplete");
                    },
                    loadError: function (jqXHR, status, error) {
                    },
                    beforeLoadComplete: function (records) {
                    }
                });
                var imagerenderer = function (row, datafield, value) {
                    if(datafield==="fl_name"){
                        var imgurl = 'content/pictures-system/icon-menu/laboratory.png';
                        var img = '<img height="50" width="40" src="' + imgurl + '"/>';
                        var table = '<table class="itemContextMenu" style="min-width: 130px;"><tr><td style="width: 40px;" rowspan="2">' + img + '</td><td></td></tr><tr><td>' + value + '</td></tr></table>';
                        return table;
                    }
                };
                var panels = $('#jqxSplitterLaboratories').jqxSplitter('panels');
                $("#jqxGridItemsLaboratory").jqxGrid({
                    width: panels[0].element[0].clientWidth-30,
                    height: panels[0].element[0].offsetHeight-23,
                    rowsheight: 80,
                    theme: theme,
                    pageable: false,
                    showemptyrow: false,
                    columnsresize: true,
                    source: dataAdapter,
                    ready:function (){
                        $("#jqxGridItemsLaboratory").css("border","none");
                    },
                    sortable: false,
                    columns: [{
                        text: 'Nombre',
                        datafield: 'fl_name',
                        cellsrenderer: imagerenderer
                    },{
                        text: 'Fecha de creación',
                        datafield: 'fl_row_create_date',
                        width: 160
                    }]
                });
                $('#jqxGridItemsLaboratory').off('rowselect');
                $('#jqxGridItemsLaboratory').on('rowselect', function (event) {
                    $("#statusElements").hide();
                    $("#detailElement").show();
                    contextMenuItems.jqxMenu("close");
                    contextMenu.jqxMenu("close");
                    indexRow = event.args.rowindex;
                    rowData = event.args.row;
                    updatePanel(indexRow);
                    $("#detailElement").show();
                    $("#statusElements").hide();
                });
                $("#jqxGridItemsLaboratory").jqxGrid("clearselection");
                $("#detailElement").hide();
                $("#statusElements").show();
            }
            changeOrder();
            $("#panelItemsLaboratories").off("mousedown");
            $("#panelItemsLaboratories").on("mousedown", function (event){
                var rightClick = isRightClick(event) || $.jqx.mobile.isTouchDevice();  
                var target = $(event.target);
                if (rightClick) {
                    var scrollTop = $(window).scrollTop();
                    var scrollLeft = $(window).scrollLeft();
                    if(target.parent().attr("id")!==undefined){                
                        if(target.parent().children().children().length==0 && target.parent().attr("role")==="row"){                    
                            contextMenuItems.jqxMenu("close");
                            var clientYdinamic=0;
                            var clientXdinamic=0;
                            if(contextMenu.height()+10>=($(window).height()-event.clientY)){
                                clientYdinamic=-contextMenu.height();
                            }
                            contextMenu.jqxMenu('open', parseInt(event.clientX) + clientXdinamic  + scrollLeft, parseInt(event.clientY) + clientYdinamic + scrollTop);
                            $("#jqxGridItemsLaboratory").jqxGrid("clearselection");
                            $("#statusElements").show();
                            $("#detailElement").hide();
                            contextMenuItems.jqxMenu("close");
                            contextMenu.jqxMenu("close");
                            return false;       
                        }else if(target.parent().attr("role")!=="row"){
                            contextMenuItems.jqxMenu("close");
                            var clientYdinamic=0;
                            var clientXdinamic=0;
                            if(contextMenu.height()+10>=($(window).height()-event.clientY)){
                                clientYdinamic=-contextMenu.height();
                            }
                            contextMenu.jqxMenu('open', parseInt(event.clientX) + clientXdinamic  + scrollLeft, parseInt(event.clientY) + clientYdinamic + scrollTop);
                            $("#jqxGridItemsLaboratory").jqxGrid("clearselection");
                            $("#statusElements").show();
                            $("#detailElement").hide();
                            contextMenuItems.jqxMenu("close");
                            contextMenu.jqxMenu("close");
                            return false; 
                        }
                    }else{
                        contextMenu.jqxMenu("close");
                        contextMenuItems.jqxMenu("close");
                    }
                }else{
                    if(target.parent().attr("id")!==undefined){
                        if(target.parent().children().children().length==0 && target.parent().attr("role")==="row"){  
                            $("#jqxGridItemsLaboratory").jqxGrid("clearselection");
                            rowData=null;
                            $("#detailElement").hide();
                            $("#statusElements").show();
                        }else if(target.parent().attr("role")!=="row"){
                            $("#jqxGridItemsLaboratory").jqxGrid("clearselection");
                            rowData=null;
                            $("#detailElement").hide();
                            $("#statusElements").show();
                        }
                    }
                }
            });
            $('#jqxGridItemsLaboratory').off('rowclick');
            $('#jqxGridItemsLaboratory').on('rowclick', function (event) {
                if (event.args.rightclick) {
                    $("#jqxGridItemsLaboratory").jqxGrid('selectrow', event.args.rowindex);
                    var clientYdinamic=0;
                    var clientXdinamic=0;
                    if(contextMenuItems.height()+10>=($(window).height()-event.args.originalEvent.clientY)){
                        clientYdinamic=-contextMenuItems.height();
                    }
                    var scrollTop = $(window).scrollTop();
                    var scrollLeft = $(window).scrollLeft();
                    contextMenu.jqxMenu("close");
                    contextMenuItems.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + clientXdinamic + scrollLeft, parseInt(event.args.originalEvent.clientY) + clientYdinamic + scrollTop);
                    return false;
                }
            });
            $('#jqxGridItemsLaboratory').off('rowdoubleclick');
            $('#jqxGridItemsLaboratory').on('rowdoubleclick', function (event) {
                openLaboratory();
            });
        }




