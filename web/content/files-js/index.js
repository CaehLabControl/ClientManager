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
        url:"menuServices?view",
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
                url: "userServices",
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




