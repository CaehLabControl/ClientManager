<%-- 
    Document   : itemsPanelMenu
    Created on : 31/05/2015, 11:07:58 AM
    Author     : Carlos
--%>

<%@page import="control.sectionControl"%>
<%@page import="model.sectionModel"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<script type="text/javascript">
$(document).ready(function () {
    // prepare the data
    var source =
    {
        url:"../serviceSectionsMenu?view=byPk",
        data:{
            "pkParent":<%out.print(request.getParameter("pkParent"));%>,
            "userRol":<%out.print(session.getAttribute("userRol"));%>
        },
        datatype: "json",
        datafields: [
            { name: 'id' },
            { name: 'parentid' },
            { name: 'text' }
        ],
        id: 'id',
        async: false
    };
    // create data adapter.
    var dataAdapter = new $.jqx.dataAdapter(source);
    // perform Data Binding.
    dataAdapter.dataBind();
    // get the menu items. The first parameter is the item's id. The second parameter is the parent item's id. The 'items' parameter represents 
    // the sub items collection name. Each jqxTree item has a 'label' property, but in the JSON data, we have a 'text' field. The last parameter 
    // specifies the mapping between the 'text' and 'label' fields.  
    var records = dataAdapter.getRecordsHierarchy('id', 'parentid', 'items', [{ name: 'text', map: 'label'}]);
    $('#jqxMenu').jqxMenu({
        theme:theme, 
        source: records, 
        enableHover: true,
        mode:"vertical",  
        width: '250px' 
    });
    var dir;
    var itemClickedId;
    var itemClickedText;
    var itemParentId;
    var itemChildrenId;
    var dirCookie = $.cookie('dir');
    var itemOld = $.cookie('itemNew');
    function loadClickItemMenu(){
        $(".itemsMenu2").parent().on("click",function (){   
            $("div").off("valueChanged");
            dir = $(this).children("span").attr("dir");
            dir = dir.split(',');
            if(dir[1]!=="undefined"){
                //itemParentId = $(this).parent().parent().parent().attr("id");
                itemChildrenId = $(this).attr("id");
                itemClickedId=$(this).attr("id");
                $.cookie('dir',dir[1]);
                $.cookie('itemNew',$(this).children("span").text());  
                $.cookie('itemParentId',itemClickedId);
                $.cookie('itemClickedId',itemClickedId);
                $('#jqxTree').jqxTree('selectItem', $("#"+itemClickedId)[0]);
            }
            if($.cookie('itemNew')!==itemOld){
                $.cookie('tabActive',0);
                itemOld=$.cookie('itemNew');
                if(dir[1]!=="undefined"){
                    //alert(dir[1]);
                    $.cookie('dir',dir[1]);
                    location="/admin";
//                    $.ajax({
//                        url:"../content/data-jsp/views-external/"+dir[1]+"?lockPage=false",
//                        async: true,
//                        beforeSend: function (xhr) {
//                            if(dir[0]!=="undefined"){
//                                $("#load-page-external").jqxWindow('open');
//                            }
//                        },
//                        success: function (data, textStatus, jqXHR) {
//                            $("#ContentPanel").html(data);
//                            if(dir[0]!=="undefined"){
//                                setTimeout(function (){
//                                    $(".hidenTab").show();
//                                    $("#load-page-external").jqxWindow('close');
//                                },'1000');
//                            }
//                            $(".itemsMenu2").parent().off("click");
//                        },
//                        error: function (jqXHR, textStatus, errorThrown) {
//
//                        }
//                    });
                }
            }
            itemChildrenId=undefined;
            itemClickedId=undefined;
            itemParentId=undefined;
        });        
    }
    loadClickItemMenu();
    //$('#jqxTree').jqxTree('selectItem', $("#1")[0]);
});
</script>
<div style="padding: 20px">
    <%
        ArrayList<sectionModel> list=new sectionControl().SelectItem(Integer.parseInt(request.getParameter("pkParent")));
        for(int i=0;i<list.size();i++){
            %>
            <h3 style="color: #586951; margin-bottom: 5px;">
                <%out.print(list.get(i).getFL_NAME_SECTION());%>
            </h3>
            <div style="margin-top: 20px; margin-right: 5px;">
                <div class="alert alert-success alert-dismissible" role="alert">
                    <div id="infoSystem"><%out.print(list.get(i).getFL_DESCRIPTION());%></div>
                </div>
            </div>
            <%
        }
    %>
    <div id='jqxWidget' style='width: 110px;'>
        <div id='jqxMenu'></div>
    </div>
</div>