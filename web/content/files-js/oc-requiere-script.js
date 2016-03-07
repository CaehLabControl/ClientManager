/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
jQuery.getScript = function( src, callback ) {
    jQuery( document.createElement('script') ).attr({
        src: src,
        type: 'text/javascript'
    }).on("error", callback).appendTo('head');
};
jQuery.getCSS = function( href, media, callback ) {
    jQuery( document.createElement('link') ).attr({
        href: href,
        media: media || 'screen',
        type: 'text/css',
        rel: 'stylesheet'
    }).on("error", callback).appendTo('head');
};
var theme = "darkblue";
var requiere = {
    init: function (action){
        var version = $("script").attr("data-version") || "3.9.1";
        window.location.hash="";
        window.location.hash=""; //chrome
        window.onhashchange=function(){window.location.hash="";};
        switch (action){
            case "register" :
                requiere.init();
                $.getScript("content/files-js/register.js"); 
            break;    
            case "login" :
                requiere.init();
                $.getScript("content/files-js/login.js");
            break;
            case "request-password" :
                $.getCSS("content/files-css/colors-fresh.css", "all");
                $.getCSS("content/files-css/buttons.css", "all");
                $.getCSS("content/files-css/wp-admin.css", "all");
                $.getCSS("content/files-jq/jqwidgets-ver"+version+"/jqwidgets/styles/jqx.base.css"); 
                $.getCSS("content/files-jq/jqwidgets-ver"+version+"/jqwidgets/styles/jqx."+theme+".css");
                $.getScript("content/files-jq/jqwidgets-ver"+version+"/jqwidgets/jqxcore.js");
                $.getScript("content/files-jq/jqwidgets-ver"+version+"/jqwidgets/jqxbuttons.js");
                $.getScript("content/files-jq/jqwidgets-ver"+version+"/jqwidgets/jqxvalidator.js");   
                $.getScript("content/files-js/request-password.js");
            break;
            case "reset-password" :  
                requiere.init();
                $.getScript("content/files-js/reset-password.js");
            break;
            case "index":
                $.getCSS("content/files-jq/jqwidgets-ver"+version+"/jqwidgets/styles/jqx.base.css"); 
                $.getCSS("content/files-jq/jqwidgets-ver"+version+"/jqwidgets/styles/jqx."+theme+".css");
                $.getCSS("content/files-jq/jqwidgets-ver"+version+"/jqwidgets/styles/jqx.arctic.css");
                $.getScript("content/files-jq/jqwidgets-ver"+version+"/jqwidgets/jqxcore.js");
                $.getScript("content/files-jq/jqwidgets-ver"+version+"/jqwidgets/jqxbuttons.js");
                $.getScript("content/files-jq/jqwidgets-ver"+version+"/jqwidgets/jqxscrollbar.js");
                $.getScript("content/files-jq/jqwidgets-ver"+version+"/jqwidgets/jqxpanel.js");
                $.getScript("content/files-jq/jqwidgets-ver"+version+"/jqwidgets/jqxtree.js");
                $.getScript("content/files-jq/jqwidgets-ver"+version+"/jqwidgets/jqxexpander.js");
                $.getScript("content/files-jq/jqwidgets-ver"+version+"/jqwidgets/jqxsplitter.js");
                $.getScript("content/files-jq/jqwidgets-ver"+version+"/jqwidgets/jqxtabs.js");
                $.getScript("content/files-jq/jqwidgets-ver"+version+"/jqwidgets/jqxscrollbar.js");
                $.getScript("content/files-jq/jqwidgets-ver"+version+"/jqwidgets/jqxmenu.js");
                $.getScript("content/files-jq/jqwidgets-ver"+version+"/jqwidgets/jqxdata.js");
                $.getScript("content/files-jq/jqwidgets-ver"+version+"/jqwidgets/jqxgrid.js");
                $.getScript("content/files-jq/jqwidgets-ver"+version+"/jqwidgets/jqxgrid.columnsresize.js"); 
                $.getScript("content/files-jq/jqwidgets-ver"+version+"/jqwidgets/jqxlistbox.js");
                $.getScript("content/files-jq/jqwidgets-ver"+version+"/jqwidgets/jqxdropdownlist.js");
                $.getScript("content/files-jq/jqwidgets-ver"+version+"/jqwidgets/jqxdragdrop.js");
                $.getScript("content/files-jq/jqwidgets-ver"+version+"/jqwidgets/jqxwindow.js");
                $.getScript("content/files-jq/jqwidgets-ver"+version+"/jqwidgets/jqxnavigationbar.js");
                $.getScript("content/files-jq/jqwidgets-ver"+version+"/jqwidgets/jqxpopover.js");
                $.getScript("content/files-js/index.js");
            break;
            default:                
                $.getCSS("content/files-css/colors-fresh.css", "all");
                $.getCSS("content/files-css/buttons.css", "all");
                $.getCSS("content/files-css/wp-admin.css", "all");
                $.getCSS("content/files-jq/jqwidgets-ver"+version+"/jqwidgets/styles/jqx.base.css"); 
                $.getCSS("content/files-jq/jqwidgets-ver"+version+"/jqwidgets/styles/jqx."+theme+".css");
                $.getScript("content/files-jq/jqwidgets-ver"+version+"/jqwidgets/jqxcore.js");
                $.getScript("content/files-jq/jqwidgets-ver"+version+"/jqwidgets/jqxloader.js");
                $.getScript("content/files-jq/jqwidgets-ver"+version+"/jqwidgets/jqxbuttons.js");
                $.getScript("content/files-jq/jqwidgets-ver"+version+"/jqwidgets/jqxpopover.js");
                $.getScript("content/files-jq/jqwidgets-ver"+version+"/jqwidgets/jqxtooltip.js");
                $.getScript("content/files-jq/jqwidgets-ver"+version+"/jqwidgets/jqxpasswordinput.js"); 
                $.getScript("content/files-jq/jqwidgets-ver"+version+"/jqwidgets/jqxvalidator.js");   
            break;
        }
    }
};
var action = $("script").attr("data-where");
requiere.init(action);


