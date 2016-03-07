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
        if (undefined == index) index = 0;
        $('#jqxTabs').jqxTabs({
            theme: theme,
            selectedItem: index, 
            width: 'auto', 
            height: height-32,
            position: 'top'
        });

        var contextMenu = $("#jqxContextMenuLaboratories").jqxMenu({ 
            width: 130, 
            height: 'auto', 
            autoOpenPopup: false, 
            mode: 'popup',
            theme: "arctic"
        });
        var contextMenuItems = $("#jqxContextMenuItems").jqxMenu({ 
            width: 130, 
            height: 'auto', 
            autoOpenPopup: false, 
            mode: 'popup',
            theme: "arctic"
        });

        $("#jqxContextMenuItems, #jqxContextMenuLaboratories").on("itemclick",function (event){
            var target = $(event.target).text();
            if($(event.target).text()==="Nuevo"){
                $("#jqxWindowItem").jqxWindow("open");
            }
            if($(event.target).text()==="Eliminar"){
                $("#jqxWindowWarning").jqxWindow("open");
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
        });
        $("#jqxSplitterLaboratories").jqxSplitter({
            theme:theme,  
            width: "auto", 
            height: height-85, 
            panels: [{ size: 750 },{ size: 600 }],
            splitBarSize: 1
        });
        $("#jqxWindowItem").jqxWindow({
            theme: theme, 
            okButton: $('#okItem'),
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
                $("#okItem").click(function (){
                   var datas = $("#formAddItem").serialize();
                   $.ajax({
                        async: true,
                        type: "POST",
                        url: "laboratoriesServices?addLaboratory",
                        data: datas,
                        dataType: 'json',
                        beforeSend: function (xhr) {
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            alert("Error interno del servidor");
                        },
                        success: function (data, textStatus, jqXHR) {
                            if(data.response==="true"){
                                changeOrder();
                            }else if(data.response==="false"){
                                alert("Elemento no agregado");
                            }else{
                                window.location="login.jsp";
                            }
                        }
                    });
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
                $("#okWarning").click(function (){
                    var datarecord = data[indexRow];
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
                                changeOrder();
                                //$("#listitem"+indexRow+"jqxListboxItems").remove();
                            }else if(data.response==="false"){
                                alert("Elemento no borrado");
                            }
                        }
                    });
                });
            }
        });
        $('#jqxSplitterLaboratories').on('collapsed', function (event) {       
            $('#jqxSplitterLaboratories').jqxSplitter('expand');
        });
        $('#jqxSplitterLaboratories').on('resize', function (event) {   
            var panels = event.args.panels;
            // get first panel.
            var panel1 = panels[0];
            $('#jqxListboxItems').jqxListBox({ width: panel1.size-30});
            // get second panel.
            var panel2 = panels[1];
            var panels = $('#jqxSplitterLaboratories').jqxSplitter('panels');
            $("#detailElement").css({
                "maxWidth": panels[1].element[0].clientWidth-20 || 200, 
                "maxHeight": panels[1].element[0].offsetHeight-20 || 461,
                "minWidth": panels[1].element[0].clientWidth-20 || 200, 
                "minHeight": panels[1].element[0].offsetHeight-20 || 461,
                "overflow":"auto"
            });
        });
        //

        var panels = $('#jqxSplitterLaboratories').jqxSplitter('panels');
        $("#panelItemsDetails").jqxPanel({
            theme: "arctic", 
            width: panels[1].element[0].clientWidth || 200, 
            height: panels[1].element[0].offsetHeight || 461,
            sizeMode:'fixed'
        });

        $("#jqxStatusBar").jqxPanel({ theme: theme, width: 'auto', height: 18});
        // open the context menu when the user presses the mouse right button.


        // disable the default browser's context menu.
        $("#panelItemsLaboratories").on('contextmenu', function (e) {
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
            var panels = $('#jqxSplitterLaboratories').jqxSplitter('panels');
            var datarecord = data[index];
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

                $("#detailElement").css({
                    "maxWidth": panels[1].element[0].clientWidth-20 || 200, 
                    "maxHeight": panels[1].element[0].offsetHeight-20 || 461,
                    "minWidth": panels[1].element[0].clientWidth-20 || 200, 
                    "minHeight": panels[1].element[0].offsetHeight-20 || 461,
                    "overflow":"auto"
                });
            }else{
                console.log("undefined");
            }                
        };


        var data=new Array();
        function changeOrder(){  
            data=new Array();
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
                    data = dataAdapter.records;
                    console.log(data);
                    console.log("loadComplete");
                },
                loadError: function (jqXHR, status, error) {
                },
                beforeLoadComplete: function (records) {
                }
            });
            dataAdapter.dataBind();

            $('#jqxListboxItems').jqxListBox({ 
                source: data
            });
            $('#jqxListboxItems').off('unselect');
            $('#jqxListboxItems').off('select');
            $('#jqxListboxItems').on('select', function (event) {
                $("#statusElements").hide();
                $("#detailElement").show();
                contextMenuItems.jqxMenu("close");
                contextMenu.jqxMenu("close");
                indexRow = event.args.index;
                updatePanel(event.args.index);
            });
            $('#jqxListboxItems').on('unselect', function (event) {
                $("#detailElement").hide();
                $("#statusElements").show();
            });
        }
        changeOrder();
        $('#jqxListboxItems').jqxListBox({ 
                source: data, 
                theme:"arctic",
                displayMember: "fl_name", 
                valueMember: "pk_laboratory", 
                itemHeight: 70, 
                height: '100%', 
                width: panels[0].size-30,
                renderer: function (index, label, value) {

                    var datarecord = data[index];
                    if( datarecord !== undefined){
                        var imgurl = 'content/pictures-system/icon-menu/laboratory.png';
                        var img = '<img height="50" width="40" src="' + imgurl + '"/>';
                        var table = '<table class="itemContextMenu" style="min-width: 130px;"><tr><td style="width: 40px;" rowspan="2">' + img + '</td><td></td></tr><tr><td>' + datarecord.fl_name + '</td></tr></table>';
                        return table;
                    }else{
                        alert()
                        return label;
                    }
                }
            });
        $('#jqxListboxItems').on('mousedown', function (event) {
            var rightClick = isRightClick(event) || $.jqx.mobile.isTouchDevice();  
            if (rightClick) {
                if(!$(event.target).is("div")){
                    var scrollTop = $(window).scrollTop();
                    var scrollLeft = $(window).scrollLeft();
                    contextMenu.jqxMenu("close");
                    contextMenuItems.jqxMenu('open', parseInt(event.clientX) + 5 + scrollLeft, parseInt(event.clientY) + 5 + scrollTop);
                    return false;
                }else{
                    $("#jqxListboxItems").jqxListBox('clearSelection'); 
                    var scrollTop = $(window).scrollTop();
                    var scrollLeft = $(window).scrollLeft();
                    contextMenuItems.jqxMenu("close");
                    contextMenu.jqxMenu('open', parseInt(event.clientX) + 5 + scrollLeft, parseInt(event.clientY) + 5 + scrollTop);
                    return false;
                }
            }else{
                $("#detailElement").hide();
                $("#statusElements").show();
                $("#jqxListboxItems").jqxListBox('clearSelection'); 
            }
        });
    });
</script>
<div id='content' class="external">
    
    <div id='jqxTabs' class="external">
        <ul>
            <li style="margin-left: 30px;">Centros de computo</li>
        </ul>
        <div id="contentSubLoad" style="">
            <div id="jqxWindowItem">
                <div>
                    <img style="width: 20px;" src="content/pictures-system/icon-context-menu/add.png" alt="add"/> 
                    <span style="top: 9px; position: absolute; left: 30px;">Nuevo elemento...</span>
                </div>
                <div style="padding: 10px">
                    <form id="formAddItem" style="padding-top: 5px; border-top: 1px solid rgb(0, 74, 115);">
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
            <div id="jqxSplitterLaboratories" style="border: none;">
                <div id="panelItemsLaboratories" style="">
                    <div style="border: none; padding-left: 30px;" id="jqxListboxItems"></div>
                    <div id='jqxContextMenuItems'>
                        <style>
                            .jqx-menu li, .jqx-popup li{
                                //padding-left: 20px;
                            }
                        </style>
                        <ul>
                            <li><img style='float: left; margin-right: 5px; width: 18px' src='content/pictures-system/icon-context-menu/update.png'/>Actualizar</li>
                            <li type='separator'></li>
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
                            .jqx-menu li, .jqx-popup li{
                                //padding-left: 20px;
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
                <div id="panelItemsDetails">
                    <div style="padding: 10px; display: none" id="detailElement"></div>                    
                    <table style="padding:  10px"  id="statusElements">
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
            <div id='jqxStatusBar'>
                <div style="padding-left: 15px; float: left; color: rgb(0, 74, 115);"><span class="numberElements">0</span> elementos</div>
            </div>
        </div>
    </div>
</div>