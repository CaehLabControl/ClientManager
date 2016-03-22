<%-- 
    Document   : admin-laboratories
    Created on : 5/03/2016, 10:26:27 AM
    Author     : CARLOS ANTONIO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<meta http-equiv="Pragma" content="no-cache">
<script type="text/javascript" class="external">
    $(document).ready(function () {
        var index = 0;
        var indexRow = 0;
        var rowData = null;
        if (undefined == index) index = 0;
        $('#jqxTabs').jqxTabs({
            theme: theme,
            selectedItem: index, 
            width: 'auto', 
            height: height-61.5,
            position: 'top',
            showCloseButtons: true
        });
        $('#jqxTabs').jqxTabs('hideCloseButtonAt', 0);
        $('#jqxTabs').off('tabclick');
        $('#jqxTabs').on('tabclick', function (event){ 
            var clickedItem = event.args.item; 
            if(clickedItem==0){
                $('#jqxTabs').jqxTabs('removeAt', 1);
            }
        }); 
        $('#jqxTabs').off('add');
        $('#jqxTabs').on('add', function (event) {
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
                    $("#tabLaboratory").empty();
                    $("#tabLaboratory").html(data);
                }
            });
        });
        $('#jqxTabs').off('removed');
        $('#jqxTabs').on('removed', function (event) {
            sessionStorage.removeItem("pk_laboratory");
        });
        var contextMenu = $("#jqxContextMenuLaboratories").jqxMenu({ 
            width: 130, 
            height: 'auto', 
            autoOpenPopup: false, 
            mode: 'popup',
            theme: theme
        });
        var contextMenuItems = $("#jqxContextMenuItems").jqxMenu({ 
            width: 130, 
            height: 'auto', 
            autoOpenPopup: false, 
            mode: 'popup',
            theme: theme
        });
        $("#jqxContextMenuItems, #jqxContextMenuLaboratories").off("itemclick");
        $("#jqxContextMenuItems, #jqxContextMenuLaboratories").on("itemclick", function (event){
            var target = $(event.target).text();
            if($(event.target).text()==="Abrir"){
                var titleLastTab = "<img style='width: 18px;' src='content/pictures-system/icon-menu/laboratory.png'/> "+rowData.fl_name;
                $('#jqxTabs').jqxTabs('addLast', titleLastTab, '<div style="border: 0px solid;" id="tabLaboratory"></div>');
                $('#jqxTabs').jqxTabs('hideCloseButtonAt', 0);
                sessionStorage.setItem("pk_laboratory",rowData.pk_laboratory);
            }
            if($(event.target).text()==="Actualizar"){                
                contextMenu.jqxMenu("close");
                contextMenuItems.jqxMenu("close");
                $("#jqxGridItems").jqxGrid("clearselection");
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
                $("#jqxWindowItem").jqxWindow("open");
            }
            if($(event.target).text()==="Eliminar"){
                $("#jqxWindowWarning").jqxWindow("open");
            }
            if($(event.target).text()==="Nuevo"){
                $("#formItem").removeClass("formUpdateItem");
                $("#formItem").addClass("formAddItem");
                $("#imgFormItem").attr("src","content/pictures-system/icon-context-menu/add.png");
                $("#titleFormItem").text("Nuevo elemento...");
                $("[name='fl_name']").val("");
                $("[name='fl_description']").val("");
                $("#jqxWindowItem").jqxWindow("open");
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
        $("#panelSubLoad").jqxPanel({ width: (principalPanels[1].element[0].clientWidth)-4, height: height-102, autoUpdate: true});
        
        $("#jqxSplitterLaboratories").jqxSplitter({
            theme: theme,  
            width: (principalPanels[1].element[0].clientWidth), 
            height: "100%", 
            panels: [{ size: sessionStorage.getItem("sizeLaboratoriesPanel1") || 750 }],
            splitBarSize: 1
        });
        if((principalPanels[0].element[0].clientWidth)<=215){
            $("#panelSubLoad").jqxPanel({width: (principalPanels[1].element[0].clientWidth)});
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
                $("#panelSubLoad").jqxPanel({width: (panelPrincipal2.element[0].clientWidth)});
                $("#jqxSplitterLaboratories").jqxSplitter({width: (panelPrincipal2.element[0].clientWidth)-6});
            }else{
                $("#panelSubLoad").jqxPanel({width: (panelPrincipal2.element[0].clientWidth)-4});
                $("#jqxSplitterLaboratories").jqxSplitter({width: 1150});
            }
            laboratoriesPanels = $('#jqxSplitterLaboratories').jqxSplitter('panels');
            var palelLaboraroties1 = laboratoriesPanels[0];
            var palelLaboraroties2 = laboratoriesPanels[1];
            $(".header-details").width((palelLaboraroties2.element[0].clientWidth)-2);
            $("#panelItemsDetails").jqxPanel({width: (palelLaboraroties2.element[0].clientWidth)-2});
        });
        $("#jqxWindowItem").jqxWindow({
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
                            url: "laboratoriesServices?"+param,
                            data: datas,
                            dataType: 'json',
                            beforeSend: function (xhr) {
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                alert("Error interno del servidor");
                            },
                            success: function (data, textStatus, jqXHR) {
                                $("#jqxWindowItem").jqxWindow('close');
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
        $("#jqxWindowWarning").jqxWindow({
            theme: theme, 
            okButton: $('#okWarning'),
            cancelButton: $('#closeWarning'),
            height: 150,
            width: 350,
            autoOpen: false,
            resizable: false,
            isModal: true,
            position:"center",
            initContent: function (){
                $('#closeWarning').jqxButton({
                    theme:theme,
                    width: '80px',
                    disabled: false
                });
                $('#okWarning').jqxButton({
                    theme:theme,
                    width: '80px',
                    disabled: false
                });
                $("#okWarning").off("click");
                $("#okWarning").on("click", function (){
                    var datarecord = rowData;
                    $.ajax({
                        async: true,
                        type: "POST",
                        url: "laboratoriesServices?deleteLaboratory",
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
                                $("#jqxWindowWarning").jqxWindow("close");
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
            $("#jqxGridItems").jqxGrid({width: laboratoriesPanel1.size-30});
            // get second panel.
            sessionStorage.setItem("sizeLaboratoriesPanel1", laboratoriesPanel1.size);
            console.log(laboratoriesPanels);
            $("#panelItemsDetails").jqxPanel({width: laboratoriesPanel2.size || 200});
            $(".header-details").width(laboratoriesPanel2.size);
        });
        var laboratoriesPanels = $('#jqxSplitterLaboratories').jqxSplitter('panels');
        var laboratoriesPanel2 = laboratoriesPanels[1];
        $("#panelItemsDetails").jqxPanel({
            theme: theme, 
            autoUpdate:true,
            width: (laboratoriesPanel2.element[0].clientWidth), 
            height: (laboratoriesPanel2.element[0].clientHeight-40)
        });
        $(".header-details").width((laboratoriesPanel2.element[0].clientWidth));
        $("#jqxStatusBar").jqxPanel({ theme: theme, width: 'auto', height: 18});
        // open the context menu when the user presses the mouse right button.


        // disable the default browser's context menu.
        $("#jqxTabs").off('contextmenu');
        $("#jqxTabs").on('contextmenu', function (event) {
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
//                var element = $("#row"+indexRow+"jqxGridItems");
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
                url: "laboratoriesServices",
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
                $('#panelItemsDetails').jqxPanel('append', $("#detailElement")[0]);
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
            $("#jqxGridItems").jqxGrid({
                width: panels[0].element[0].clientWidth-30,
                height: panels[0].element[0].offsetHeight-23,
                rowsheight: 80,
                theme: theme,
                pageable: false,
                showemptyrow: false,
                columnsresize: true,
                source: dataAdapter,
                ready:function (){
                    $("#jqxGridItems").css("border","none");
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
            $('#jqxGridItems').off('rowselect');
            $('#jqxGridItems').on('rowselect', function (event) {
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
            $("#jqxGridItems").jqxGrid("clearselection");
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
                        $("#jqxGridItems").jqxGrid("clearselection");
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
                        $("#jqxGridItems").jqxGrid("clearselection");
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
                        $("#jqxGridItems").jqxGrid("clearselection");
                        rowData=null;
                        $("#detailElement").hide();
                        $("#statusElements").show();
                    }else if(target.parent().attr("role")!=="row"){
                        $("#jqxGridItems").jqxGrid("clearselection");
                        rowData=null;
                        $("#detailElement").hide();
                        $("#statusElements").show();
                    }
                }
            }
        });
        $('#jqxGridItems').off('rowclick');
        $('#jqxGridItems').on('rowclick', function (event) {
            if (event.args.rightclick) {
                $("#jqxGridItems").jqxGrid('selectrow', event.args.rowindex);
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
        $('#jqxGridItems').off('rowdoubleclick');
        $('#jqxGridItems').on('rowdoubleclick', function (event) {
            $("li:contains('Abrir')").click();
        });
    });
</script>
<div id='content' class="external">
    
    <div id='jqxTabs' class="external">
        <ul>
            <li style="margin-left: 30px;">
                <img style="width: 18px;" src="content/pictures-system/icon-menu/laboratory-add.png" alt="add"/>
                Centros de computo
            </li>
        </ul>
        <div id="panelSubLoad" style="overflow: hidden;">
            <div id="jqxWindowItem">
                <div>
                    <img id="imgFormItem" style="width: 20px;" src="content/pictures-system/icon-context-menu/add.png" alt="add"/> 
                    <span id="titleFormItem" style="top: 9px; position: absolute; left: 30px;">Nuevo elemento...</span>
                </div>
                <div style="padding: 10px">
                    <form id="formItem" action="#" style="padding-top: 5px; border-top: 1px solid rgb(0, 74, 115);">
                        <input value="" type="hidden" name="pk_laboratory">
                        <label>Nombre</label><br>
                        <input type="text" maxlength="30" style="width: 180px;" name="fl_name" placeholder="Nombre"/>
                        <br>
                        <label>Descripción</label><br>
                        <textarea rows="4" cols="38" name="fl_description" style="resize: none; font-family: Verdana,Arial,sans-serif; font-size: 13px;" placeholder="Descripción..."></textarea><br>
                    </form>
                    <button style="width: 80px; bottom: 20px; position: absolute; left: 145px;" id="okItem">Ok</button>
                    <button style="width: 80px; bottom: 20px; position: absolute; left: 230px;" id="closeItem">Cerrar</button>
                </div>
            </div>
            <div id="jqxWindowWarning">
                <div>
                    <img style="width: 20px;" src="content/pictures-system/error.png" alt="error"/> 
                    <span style="top: 9px; position: absolute; left: 30px;">Eliminar elemento...</span>
                </div>
                <div style="padding: 10px">
                    <span class="msg">Estas seguro de eliminar este elemento</span>
                    <button style="width: 80px; bottom: 20px; position: absolute; left: 145px;" id="okWarning">Ok</button>
                    <button style="width: 80px; bottom: 20px; position: absolute; left: 230px;" id="closeWarning">Cerrar</button>
                </div>
            </div>
            <div id="jqxSplitterLaboratories" style="border: none; border: 1px solid; background: #007ACC">
                <div style="">
                    <div id="panelItemsLaboratories">
                        <div style="border: none; padding-left: 30px;" id="contentGridItems">
                            <div id="jqxGridItems"></div>
                        </div>                    
                        <div id='jqxContextMenuItems'>
                            <style>
                                .jqx-menu li, .jqx-popup li{
                                    //padding-left: 20px;
                                }
                            </style>
                            <ul>
                                <li><img style='float: left; margin-right: 5px; width: 18px' src='content/pictures-system/icon-context-menu/open.png'/>Abrir</li>
                                <li><img style='float: left; margin-right: 5px; width: 18px' src='content/pictures-system/icon-context-menu/update.png'/>Actualizar</li>
                                <li type='separator'></li>
                                <li><img style='float: left; margin-right: 5px; width: 18px' src='content/pictures-system/icon-context-menu/edit.png'/>Editar</li>
                                <li><img style='float: left; margin-right: 5px; width: 18px' src='content/pictures-system/icon-context-menu/delete.png'/>Eliminar</li>
                                <li><img style='float: left; margin-right: 5px; width: 18px' src='content/pictures-system/icon-context-menu/add.png'/>Nuevo</li>
                                <li type='separator'></li>
                                <li>
                                    <img style='float: left; margin-right: 5px; width: 18px' src='content/pictures-system/icon-context-menu/order.png'/>Ordenar
                                    <ul>
                                        <li id="fl_name" data-order="order-name"><img style='float: left; margin-right: 5px; width: 18px' src='' alt=""/>Nombre</li>
                                        <li id="fl_row_create_date" data-order="order-add-date"><img style='float: left; margin-right: 5px; width: 18px' src='' alt=""/>Fecha de creación</li>
                                        <li id="fl_row_update_date" data-order="order-update-date"><img style='float: left; margin-right: 5px; width: 18px' src='' alt=""/>Fecha de modificación</li>
                                        <li type='separator'></li>
                                        <li id="fl_asc" data-type="type-asc"><img style='float: left; margin-right: 5px; width: 18px' src='' alt=""/>Ascendente</li>
                                        <li id="fl_desc" data-type="type-desc"><img style='float: left; margin-right: 5px; width: 18px' src='' alt=""/>Descendente</li>
                                    </ul>
                                </li>
                                <li type='separator'></li>
                                <li><img style='float: left; margin-right: 5px; width: 18px' src='content/pictures-system/icon-context-menu/properties.png'/>Propiedades</li>                            
                            </ul>
                        </div>   
                        <div id='jqxContextMenuLaboratories'>
                            <style>
                                #jqxGridItems div{
                                    border: none !important;
                                }
                            </style>
                            <ul>
                                <li><img style='float: left; margin-right: 5px; width: 18px' src='content/pictures-system/icon-context-menu/update.png'/>Actualizar</li>
                                <li><img style='float: left; margin-right: 5px; width: 18px' src='content/pictures-system/icon-context-menu/add.png'/>Nuevo</li>
                                <li type='separator'></li>
                                <li>
                                    <img style='float: left; margin-right: 5px; width: 18px' src='content/pictures-system/icon-context-menu/order.png'/>Ordenar
                                    <ul>
                                        <li id="fl_name" data-order="order-name"><img style='float: left; margin-right: 5px; width: 18px' src='' alt=""/>Nombre</li>
                                        <li id="fl_row_create_date" data-order="order-add-date"><img style='float: left; margin-right: 5px; width: 18px' src='' alt=""/>Fecha de creación</li>
                                        <li id="fl_row_update_date" data-order="order-update-date"><img style='float: left; margin-right: 5px; width: 18px' src='' alt=""/>Fecha de modificación</li>
                                        <li type='separator'></li>
                                        <li id="fl_asc" data-type="type-asc"><img style='float: left; margin-right: 5px; width: 18px' src='' alt=""/>Ascendente</li>
                                        <li id="fl_desc" data-type="type-desc"><img style='float: left; margin-right: 5px; width: 18px' src='' alt=""/>Descendente</li>
                                    </ul>
                                </li>                          
                            </ul>
                        </div>   
                    </div>
                </div>
                <div style="">
                    <div class="header-details jqx-widget-header jqx-widget-header-light jqx-fill-state-pressed jqx-fill-state-pressed-light jqx-expander-header-expanded jqx-expander-header-expanded-light jqx-expander-header jqx-expander-header-light jqx-expander-header-disabled jqx-expander-header-disabled-light">Detalles</div>
                    <div id="panelItemsDetails">
                        <div>
                            <div style="padding: 10px; display: none" id="detailElement"></div>                    
                            <table style="padding:  10px; width: 340px"  id="statusElements">
                                <tbody>
                                    <tr>
                                        <td colspan="2">
                                            <span class="numberElements">0</span> elementos
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="padding-top: 20px;">
                                            <img src="content/pictures-system/icon-menu/laboratory.png"/>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>   
        </div>
    </div>
    <div id='jqxStatusBar'>
        <div style="padding-left: 15px; float: left; color: rgb(0, 74, 115);"><span class="numberElements">0</span> elementos</div>
    </div>
</div>