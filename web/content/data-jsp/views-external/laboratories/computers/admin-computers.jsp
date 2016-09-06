<%-- 
    Document   : admin-laboratories
    Created on : 5/03/2016, 10:26:27 AM
    Author     : CARLOS ANTONIO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script type="text/javascript" class="external">
    $(document).ready(function () {
        var index = 0;
        var indexRow = 0;
        var rowData = null;
        if (undefined == index) index = 0;
        var contextMenuComputers = $("#jqxContextMenuComputers").jqxMenu({ 
            width: 130, 
            height: 'auto', 
            autoOpenPopup: false, 
            mode: 'popup',
            theme: theme
        });
        var contextMenuComputersItems = $("#jqxContextMenuItemsComputers").jqxMenu({ 
            width: 130, 
            height: 'auto', 
            autoOpenPopup: false, 
            mode: 'popup',
            theme: theme
        });
        $("#jqxContextMenuItemsComputers, #jqxContextMenuComputers").off("itemclick");
        $("#jqxContextMenuItemsComputers, #jqxContextMenuComputers").on("itemclick", function (event){
            var target = $(event.target).text();
            if($(event.target).text()==="Actualizar"){                
                contextMenuComputers.jqxMenu("close");
                contextMenuComputersItems.jqxMenu("close");
                $("#jqxGridItemsComputers").jqxGrid("clearselection");
                $("#detailElementComputers").hide();
                $("#statusElementsComputers").show();
            }
            if($(event.target).text()==="Editar"){
                $("#formItemComputers").removeClass("formAddItem");
                $("#formItemComputers").addClass("formUpdateItem");
                $("#imgFormItemComputers").attr("src","content/pictures-system/icon-context-menu/edit.png");
                $("#titleFormItemComputers").text("Editar elemento...");
                $("[name='fl_name_computer']").val(rowData.fl_name_computer);
                $("[name='fl_description_computer']").val(rowData.fl_description_computer);
                $("[name='pk_computer']").val(rowData.pk_computer);
                $("#jqxWindowItemComputers").jqxWindow("open");
            }
            if($(event.target).text()==="Eliminar"){
                $("#jqxWindowWarningComputers").jqxWindow("open");
            }
            if($(event.target).text()==="Nuevo"){
                $("#formItemComputers").removeClass("formUpdateItem");
                $("#formItemComputers").addClass("formAddItem");
                $("#imgFormItemComputers").attr("src","content/pictures-system/icon-context-menu/add.png");
                $("#titleFormItemComputers").text("Nuevo elemento...");
                $("[name='fl_name_computer']").val("");
                $("[name='fl_description_computer']").val("");
                $("#jqxWindowItemComputers").jqxWindow("open");
            }
            if(target==="Nombre"){
                localStorage.setItem("pt_order","fl_name_computer");
                changeOrder();
            }
            if(target==="Fecha de creación"){
                localStorage.setItem("pt_order","fl_row_create_date_computer");
                changeOrder();
            }
            if(target==="Fecha de modificación"){
                localStorage.setItem("pt_order","fl_row_update_date_computer");
                changeOrder();
            }
            if(target==="Ascendente"){
                localStorage.setItem("pt_type","fl_asc_computer");
                changeOrder();
            }
            if(target==="Descendente"){
                localStorage.setItem("pt_type","fl_desc_computer");
                changeOrder();
            }
            if($(event.target).text()==="Propiedades"){
                 alert("Propiedades")
            }
        });
        var principalPanels = $('#jqxSplitterPrincipal').jqxSplitter('panels');
        var laboratoriesPanels = $('#jqxSplitterComputers').jqxSplitter('panels');
        $("#panelSubLoadComputers").jqxPanel({ width: (principalPanels[1].element[0].clientWidth)-4, height: height-102, autoUpdate: true});
        
        $("#jqxSplitterComputers").jqxSplitter({
            theme: theme,  
            width: (principalPanels[1].element[0].clientWidth), 
            height: "100%", 
            panels: [{ size: sessionStorage.getItem("sizeLaboratoriesPanel1") || 750 }],
            splitBarSize: 1
        });
//        if((principalPanels[0].element[0].clientWidth)<=215){
//            $("#panelSubLoadComputers").jqxPanel({width: (principalPanels[1].element[0].clientWidth)});
//            $("#jqxSplitterComputers").jqxSplitter({width: (principalPanels[1].element[0].clientWidth)-6}); 
//        }
//        $('#jqxSplitterPrincipal').off('resize');
//        $('#jqxSplitterPrincipal').on('resize', function (event) { 
//            principalPanels = $('#jqxSplitterPrincipal').jqxSplitter('panels');
//            
//            // get first panel.
//            var panelPrincipal1 = principalPanels[0];
//            // get second panel.
//            var panelPrincipal2 = principalPanels[1];
//            if((panelPrincipal1.element[0].clientWidth)<=215){
//                $("#panelSubLoadComputers").jqxPanel({width: (panelPrincipal2.element[0].clientWidth)});
//                $("#jqxSplitterComputers").jqxSplitter({width: (panelPrincipal2.element[0].clientWidth)-6});
//            }else{
//                $("#panelSubLoadComputers").jqxPanel({width: (panelPrincipal2.element[0].clientWidth)-4});
//                $("#jqxSplitterComputers").jqxSplitter({width: 1150});
//            }
//            laboratoriesPanels = $('#jqxSplitterComputers').jqxSplitter('panels');
//            var palelLaboraroties1 = laboratoriesPanels[0];
//            var palelLaboraroties2 = laboratoriesPanels[1];
//            $(".header-details-computers").width((palelLaboraroties2.element[0].clientWidth)-2);
//            $("#panelItemsDetailsComputers").jqxPanel({width: (palelLaboraroties2.element[0].clientWidth)-2});
//        });
        $("#jqxWindowItemComputers").jqxWindow({
            theme: theme, 
            //okButton: $('#okItemComputers'),
            cancelButton: $('#closeItemComputers'),
            height: 250,
            width: 350,
            autoOpen: false,
            resizable: false,
            isModal: true,
            position:"center",
            initContent: function (){
                $('#closeItemComputers').jqxButton({
                    theme:theme,
                    width: '80px',
                    disabled: false
                });
                $('#okItemComputers').jqxButton({
                    theme:theme,
                    width: '80px',
                    disabled: false
                });
                $("#formItemComputers").off("submit");
                $("#formItemComputers").on("submit", function (){
                   return false; 
                });
                $("#okItemComputers").off("click");
                $("#okItemComputers").on("click", function (){
                    var param;
                    var datas;
                    if($("#formItemComputers").hasClass("formAddItem")){
                        datas = $("#formItemComputers").serialize();  
                        param="addLaboratory";
                    }
                    if($("#formItemComputers").hasClass("formUpdateItem")){
                        datas = $("#formItemComputers").serialize();
                        param="updateLaboratory";
                    }
                    if($("[name='fl_name_computer']").val().length>0){
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
                                $("#jqxWindowItemComputers").jqxWindow('close');
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
                        $("[name='fl_name_computer']").focusin();
                    }
                });
            }
        });
        $("#jqxWindowWarningComputers").jqxWindow({
            theme: theme, 
            okButton: $('#okWarningComputers'),
            cancelButton: $('#closeWarningComputers'),
            height: 150,
            width: 350,
            autoOpen: false,
            resizable: false,
            isModal: true,
            position:"center",
            initContent: function (){
                $('#closeWarningComputers').jqxButton({
                    theme:theme,
                    width: '80px',
                    disabled: false
                });
                $('#okWarningComputers').jqxButton({
                    theme:theme,
                    width: '80px',
                    disabled: false
                });
                $("#okWarningComputers").off("click");
                $("#okWarningComputers").on("click", function (){
                    var datarecord = rowData;
                    $.ajax({
                        async: true,
                        type: "POST",
                        url: "LaboratoriesService?deleteLaboratory",
                        data: {
                            "pk_computer":datarecord.pk_computer
                        },
                        dataType: 'json',
                        beforeSend: function (xhr) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) {
                            if(data.response==="true"){
                                $("#jqxWindowWarningComputers").jqxWindow("close");
                                changeOrder();
                            }else if(data.response==="false"){
                                alert("Elemento no borrado");
                            }
                        }
                    });
                });
            }
        });
//        $('#jqxSplitterComputers').off('collapsed');
//        $('#jqxSplitterComputers').on('collapsed', function (event) {       
//            $('#jqxSplitterComputers').jqxSplitter('expand');
//        });
//        $('#jqxSplitterComputers').off('resize');
//        $('#jqxSplitterComputers').on('resize', function (event) {  
//            var laboratoriesPanels = event.args.panels;
//            // get first panel.
//            var laboratoriesPanel1 = laboratoriesPanels[0];
//            var laboratoriesPanel2 = laboratoriesPanels[1];
//            $("#jqxGridItemsComputers").jqxGrid({width: laboratoriesPanel1.size-30});
//            // get second panel.
//            sessionStorage.setItem("sizeLaboratoriesPanel1", laboratoriesPanel1.size);
//            console.log(laboratoriesPanels);
//            $("#panelItemsDetailsComputers").jqxPanel({width: laboratoriesPanel2.size || 200});
//            $(".header-details-computers").width(laboratoriesPanel2.size);
//        });
        var laboratoriesPanels = $('#jqxSplitterComputers').jqxSplitter('panels');
        var laboratoriesPanel2 = laboratoriesPanels[1];
        $("#panelItemsDetailsComputers").jqxPanel({
            theme: theme, 
            autoUpdate:true,
            width: (laboratoriesPanel2.element[0].clientWidth), 
            height: (laboratoriesPanel2.element[0].clientHeight-40)
        });
        $(".header-details-computers").width((laboratoriesPanel2.element[0].clientWidth));
        // open the context menu when the user presses the mouse right button.


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
                    { name: 'pk_computer', type: 'int' },
                    { name: 'pk_user', type: 'int' },
                    { name: 'fl_name_computer', type: 'string' },
                    { name: 'fl_description_computer', type: 'string' },
                    { name: 'fl_cant_computers', type: 'string' },
                    { name: 'fl_row_create_date_computer', type: 'string' },
                    { name: 'fl_row_update_date_computer', type: 'string' }
                ],
                root: "response",
                id: 'pk_computer',                
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
                            <td colspan='2' style='font-size: 24px;'><b>"+datarecord.fl_name_computer+"</b></td>\n\
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
                            <td>"+datarecord.fl_row_create_date_computer+"</td>\n\
                        </tr>\n\
                        <tr>\n\
                            <td>Fecha de modificación:</td>\n\
                            <td>"+datarecord.fl_row_update_date_computer+"</td>\n\
                        </tr>\n\
                        <tr>\n\
                            <td>Total de equipos:</td>\n\
                            <td>"+datarecord.fl_cant_computers+"</td>\n\
                        </tr>\n\
                    <tbody>\n\
                </table>\n\
                <b style='font-size: 20px;'>Descripción</b><br>\n\
                <div style='width: "+340+"px'>"+datarecord.fl_description_computer+"</div>\n\
                ");
                var container = $('<div style="margin: 5px;"></div>');
                container.append(table);
                $("#detailElementComputers").html(container.html());
                $('#panelItemsDetailsComputers').jqxPanel('append', $("#detailElementComputers")[0]);
            }else{
                console.log("undefined");
            } 
        };

        function changeOrder(){  
            var src = "content/pictures-system/icon-context-menu/select.png";
            $("li[data-order]").each(function (){
                if($(this).attr("id")===(localStorage.getItem("pt_order")||"fl_name_computer")){
                    $(this).children("img").attr("src",src);
                    $(this).removeAttr("style");
                }else{
                    $(this).children("img").attr("src","");
                    $(this).css("padding-left","32px");
                }
            });
            $("li[data-type]").each(function (){
                if($(this).attr("id")===(localStorage.getItem("pt_type")||"fl_asc_computer")){
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
                if(datafield==="fl_name_computer"){
                    var imgurl = 'content/pictures-system/client.png';
                    var img = '<img height="50" width="40" src="' + imgurl + '"/>';
                    var table = '<table class="itemContextMenuComputer" style="min-width: 130px;"><tr><td style="width: 40px;" rowspan="2">' + img + '</td><td></td></tr><tr><td>' + value + '</td></tr></table>';
                    return table;
                }
            };
            var panels = $('#jqxSplitterComputers').jqxSplitter('panels');
            $("#jqxGridItemsComputers").jqxGrid({
                width: panels[0].element[0].clientWidth-30,
                height: panels[0].element[0].offsetHeight-23,
                rowsheight: 80,
                theme: theme,
                pageable: false,
                showemptyrow: false,
                columnsresize: true,
                source: dataAdapter,
                ready:function (){
                    $("#jqxGridItemsComputers").css("border","none");
                },
                sortable: false,
                columns: [{
                    text: 'Nombre',
                    datafield: 'fl_name_computer',
                    cellsrenderer: imagerenderer
                },{
                    text: 'Fecha de creación',
                    datafield: 'fl_row_create_date_computer',
                    width: 160
                }]
            });
            $('#jqxGridItemsComputers').off('rowselect');
            $('#jqxGridItemsComputers').on('rowselect', function (event) {
                $("#statusElementsComputers").hide();
                $("#detailElementComputers").show();
                contextMenuComputersItems.jqxMenu("close");
                contextMenuComputers.jqxMenu("close");
                indexRow = event.args.rowindex;
                rowData = event.args.row;
                updatePanel(indexRow);
                $("#detailElementComputers").show();
                $("#statusElementsComputers").hide();
            });
            $("#jqxGridItemsComputers").jqxGrid("clearselection");
            $("#detailElementComputers").hide();
            $("#statusElementsComputers").show();
        }
        changeOrder();
        $("#panelItemsComputers").off("mousedown");
        $("#panelItemsComputers").on("mousedown", function (event){
            var rightClick = isRightClick(event) || $.jqx.mobile.isTouchDevice();  
            var target = $(event.target);
            if (rightClick) {
                var scrollTop = $(window).scrollTop();
                var scrollLeft = $(window).scrollLeft();
                if(target.parent().attr("id")!==undefined){                
                    if(target.parent().children().children().length==0 && target.parent().attr("role")==="row"){                    
                        contextMenuComputersItems.jqxMenu("close");
                        var clientYdinamic=0;
                        var clientXdinamic=0;
                        if(contextMenuComputers.height()+10>=($(window).height()-event.clientY)){
                            clientYdinamic=-contextMenuComputers.height();
                        }
                        contextMenuComputers.jqxMenu('open', parseInt(event.clientX) + clientXdinamic  + scrollLeft, parseInt(event.clientY) + clientYdinamic + scrollTop);
                        $("#jqxGridItemsComputers").jqxGrid("clearselection");
                        $("#statusElementsComputers").show();
                        $("#detailElementComputers").hide();
                        contextMenuComputersItems.jqxMenu("close");
                        contextMenuComputers.jqxMenu("close");
                        return false;       
                    }else if(target.parent().attr("role")!=="row"){
                        contextMenuComputersItems.jqxMenu("close");
                        var clientYdinamic=0;
                        var clientXdinamic=0;
                        if(contextMenuComputers.height()+10>=($(window).height()-event.clientY)){
                            clientYdinamic=-contextMenuComputers.height();
                        }
                        contextMenuComputers.jqxMenu('open', parseInt(event.clientX) + clientXdinamic  + scrollLeft, parseInt(event.clientY) + clientYdinamic + scrollTop);
                        $("#jqxGridItemsComputers").jqxGrid("clearselection");
                        $("#statusElementsComputers").show();
                        $("#detailElementComputers").hide();
                        contextMenuComputersItems.jqxMenu("close");
                        contextMenuComputers.jqxMenu("close");
                        return false; 
                    }
                }else{
                    contextMenuComputers.jqxMenu("close");
                    contextMenuComputersItems.jqxMenu("close");
                }
            }else{
                if(target.parent().attr("id")!==undefined){
                    if(target.parent().children().children().length==0 && target.parent().attr("role")==="row"){  
                        $("#jqxGridItemsComputers").jqxGrid("clearselection");
                        rowData=null;
                        $("#detailElementComputers").hide();
                        $("#statusElementsComputers").show();
                    }else if(target.parent().attr("role")!=="row"){
                        $("#jqxGridItemsComputers").jqxGrid("clearselection");
                        rowData=null;
                        $("#detailElementComputers").hide();
                        $("#statusElementsComputers").show();
                    }
                }
            }
        });
        $('#jqxGridItemsComputers').off('rowclick');
        $('#jqxGridItemsComputers').on('rowclick', function (event) {
            if (event.args.rightclick) {
                $("#jqxGridItemsComputers").jqxGrid('selectrow', event.args.rowindex);
                var clientYdinamic=0;
                var clientXdinamic=0;
                if(contextMenuComputersItems.height()+10>=($(window).height()-event.args.originalEvent.clientY)){
                    clientYdinamic=-contextMenuComputersItems.height();
                }
                var scrollTop = $(window).scrollTop();
                var scrollLeft = $(window).scrollLeft();
                contextMenuComputers.jqxMenu("close");
                contextMenuComputersItems.jqxMenu('open', parseInt(event.args.originalEvent.clientX) + clientXdinamic + scrollLeft, parseInt(event.args.originalEvent.clientY) + clientYdinamic + scrollTop);
                return false;
            }
        });
    });
</script>

<div id="panelSubLoadComputers" style="overflow: hidden;">
    <div id="jqxWindowItemComputers">
        <div>
            <img id="imgFormItemComputers" style="width: 20px;" src="content/pictures-system/icon-context-menu/add.png" alt="add"/> 
            <span id="titleFormItemComputers" style="top: 9px; position: absolute; left: 30px;">Nuevo elemento...</span>
        </div>
        <div style="padding: 10px">
            <form id="formItemComputers" action="#" style="padding-top: 5px; border-top: 1px solid rgb(0, 74, 115);">
                <input value="" type="hidden" name="pk_computer">
                <label>Nombre</label><br>
                <input type="text" maxlength="30" style="width: 180px;" name="fl_name_computer" placeholder="Nombre"/>
                <br>
                <label>Descripción</label><br>
                <textarea rows="4" cols="38" name="fl_description_computer" style="resize: none; font-family: Verdana,Arial,sans-serif; font-size: 13px;" placeholder="Descripción..."></textarea><br>
            </form>
            <button style="width: 80px; bottom: 20px; position: absolute; left: 145px;" id="okItemComputers">Ok</button>
            <button style="width: 80px; bottom: 20px; position: absolute; left: 230px;" id="closeItemComputers">Cerrar</button>
        </div>
    </div>
    <div id="jqxWindowWarningComputers">
        <div>
            <img style="width: 20px;" src="content/pictures-system/error.png" alt="error"/> 
            <span style="top: 9px; position: absolute; left: 30px;">Eliminar elemento...</span>
        </div>
        <div style="padding: 10px">
            <span class="msg">Estas seguro de eliminar este elemento</span>
            <button style="width: 80px; bottom: 20px; position: absolute; left: 145px;" id="okWarningComputers">Ok</button>
            <button style="width: 80px; bottom: 20px; position: absolute; left: 230px;" id="closeWarningComputers">Cerrar</button>
        </div>
    </div>
    <div id="jqxSplitterComputers" style="border: none; border: 1px solid; background: #007ACC">
        <div style="">
            <div id="panelItemsComputers">
                <div style="border: none; padding-left: 30px;" id="contentGridItemsComputers">
                    <div id="jqxGridItemsComputers"></div>
                </div>                    
                <div id='jqxContextMenuItemsComputers'>
                    <style>
                        .jqx-menu li, .jqx-popup li{
                            /*padding-left: 20px;*/
                        }
                    </style>
                    <ul>
                        <li><img style='float: left; margin-right: 5px; width: 18px' src='content/pictures-system/icon-context-menu/update.png'/>Actualizar</li>
                        <li type='separator'></li>
                        <li><img style='float: left; margin-right: 5px; width: 18px' src='content/pictures-system/icon-context-menu/edit.png'/>Editar</li>
                        <li><img style='float: left; margin-right: 5px; width: 18px' src='content/pictures-system/icon-context-menu/delete.png'/>Eliminar</li>
                        <li><img style='float: left; margin-right: 5px; width: 18px' src='content/pictures-system/icon-context-menu/add.png'/>Nuevo</li>
                        <li type='separator'></li>
                        <li>
                            <img style='float: left; margin-right: 5px; width: 18px' src='content/pictures-system/icon-context-menu/order.png'/>Ordenar
                            <ul>
                                <li id="fl_name_computer" data-order="order-name-computer"><img style='float: left; margin-right: 5px; width: 18px' src='' alt=""/>Nombre</li>
                                <li id="fl_row_create_date_computer" data-order="order-add-date-computer"><img style='float: left; margin-right: 5px; width: 18px' src='' alt=""/>Fecha de creación</li>
                                <li id="fl_row_update_date_computer" data-order="order-update-date-computer"><img style='float: left; margin-right: 5px; width: 18px' src='' alt=""/>Fecha de modificación</li>
                                <li type='separator'></li>
                                <li id="fl_asc_computer" data-type="type-asc-computer"><img style='float: left; margin-right: 5px; width: 18px' src='' alt=""/>Ascendente</li>
                                <li id="fl_desc_computer" data-type="type-desc-computer"><img style='float: left; margin-right: 5px; width: 18px' src='' alt=""/>Descendente</li>
                            </ul>
                        </li>
                        <li type='separator'></li>
                        <li><img style='float: left; margin-right: 5px; width: 18px' src='content/pictures-system/icon-context-menu/properties.png'/>Propiedades</li>                            
                    </ul>
                </div>   
                <div id='jqxContextMenuComputers'>
                    <style>
                        #jqxGridItemsComputers div{
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
                                <li id="fl_name_computer" data-order="order-name-computer"><img style='float: left; margin-right: 5px; width: 18px' src='' alt=""/>Nombre</li>
                                <li id="fl_row_create_date_computer" data-order="order-add-date-computer"><img style='float: left; margin-right: 5px; width: 18px' src='' alt=""/>Fecha de creación</li>
                                <li id="fl_row_update_date_computer" data-order="order-update-date-computer"><img style='float: left; margin-right: 5px; width: 18px' src='' alt=""/>Fecha de modificación</li>
                                <li type='separator'></li>
                                <li id="fl_asc_computer" data-type="type-asc-computer"><img style='float: left; margin-right: 5px; width: 18px' src='' alt=""/>Ascendente</li>
                                <li id="fl_desc_computer" data-type="type-desc-computer"><img style='float: left; margin-right: 5px; width: 18px' src='' alt=""/>Descendente</li>
                            </ul>
                        </li>                          
                    </ul>
                </div>   
            </div>
        </div>
        <div style="">
            <div class="header-details-computers jqx-widget-header jqx-widget-header-light jqx-fill-state-pressed jqx-fill-state-pressed-light jqx-expander-header-expanded jqx-expander-header-expanded-light jqx-expander-header jqx-expander-header-light jqx-expander-header-disabled jqx-expander-header-disabled-light">Detalles</div>
            <div id="panelItemsDetailsComputers">
                <div>
                    <div style="padding: 10px; display: none" id="detailElementComputers"></div>                    
                    <table style="padding:  10px; width: 340px"  id="statusElementsComputers">
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