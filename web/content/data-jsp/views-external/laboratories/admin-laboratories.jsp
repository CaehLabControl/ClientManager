<%-- 
    Document   : admin-laboratories
    Created on : 5/03/2016, 10:26:27 AM
    Author     : CARLOS ANTONIO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script type="text/javascript" class="external">
    $(document).ready(function () {
        initFuntionsManagerLaboratories();
        
    });
</script>
<div id='content' class="external">
    
    <div id='jqxTabsLaboratory' class="external">
        <ul>
            <li style="margin-left: 30px;">
                <img style="width: 18px;" src="content/pictures-system/icon-menu/laboratory-add.png" alt="add"/>
                Centros de computo
            </li>
        </ul>
        <div id="jqxPanelSubLoad" style="overflow: hidden;">
            <div id="jqxWindowItemLaboratory">
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
            <div id="jqxWindowWarningLaboratory">
                <div>
                    <img style="width: 20px;" src="content/pictures-system/error.png" alt="error"/> 
                    <span style="top: 9px; position: absolute; left: 30px;">Eliminar elemento...</span>
                </div>
                <div style="padding: 10px">
                    <span class="msg">Estas seguro de eliminar este elemento</span>
                    <button style="width: 80px; bottom: 20px; position: absolute; left: 145px;" id="okWarningLaboratory">Ok</button>
                    <button style="width: 80px; bottom: 20px; position: absolute; left: 230px;" id="closeWarningLaboratory">Cerrar</button>
                </div>
            </div>
            <div id="jqxSplitterLaboratories" style="border: none; border: 1px solid; background: #007ACC">
                <div style="">
                    <div id="panelItemsLaboratories">
                        <div style="border: none; padding-left: 30px;" id="contentGridItems">
                            <div id="jqxGridItemsLaboratory"></div>
                        </div>                    
                        <div id='jqxContextMenuItemsLaboratory'>
                            <style>
                                .jqx-menu li, .jqx-popup li{
                                    /*padding-left: 20px;*/
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
                                #jqxGridItemsLaboratory div{
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
                    <div id="jqxPanelItemsDetails">
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