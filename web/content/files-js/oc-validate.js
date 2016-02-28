/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
(function($) {
    $.fn.ocValidate = function (parametersUser, fieldsUser){
        /*
            password : [{
        
            }],
            userName : [{
                message : "Holas",
                action : "event",
                rule :
            }]
        */
        parametersDefault = {
            widthSubmit : "auto",
            heightSubmit : "auto"
        };
        fieldsDefault = {            
            userName : {
                required : {
                    message : "Este campo es requerido",
                    action : "submmit",
                    hintRender : function (){
                        
                    }
                },
                length : {
                    message : "El numero minimo de caracteres es de 0 y un mayor de 20",
                    range : "0,20"
                }
            }
        };
        parametersFinal = $.extend(parametersDefault, parametersUser);
        
        fieldsFinal = $.extend(fieldsDefault, fieldsUser);
        var meId = $(this).attr("id");  
        var rulesAll = new Array();    
        
        var hintRender = function (message, input) {   
            var that = this;
            if (that._message) {
                that._message.remove();   
            }
            if($("#triggerPopover_"+input.attr("id")).length==0){
                jqxPopover.init(input.attr("id"),"Validar primero", message);
                jqxPopover.open(input.attr("id"));
            }else{
                jqxPopover.open(input.attr("id"), message);
            }
            that._message = $("<span style='background: red; color: white;'>" + message + "</span>");
            that._message.appendTo(input.parent());
            console.log(that._message);
            return false;
        };
        var declareEvent = function (arg, event){  
            
//            if($("#triggerPopover_"+arg.element.attr("id")).length==0){
//                jqxPopover.init(arg.element.attr("id"),"Validar primero",arg.message);
//            }
//            arg.element.on(event, function (){
//                alert(1);
//                if(arg.parent.jqxValidator('validateInput', "#"+arg.element.attr("id"))){
//                    jqxPopover.close(arg.element.attr("id"));
//                    arg.element.css({"border":"1px solid #3f95c5"});
//                }else{
//                    arg.element.css({"border":"1px solid #fe0606"});
//                    jqxPopover.open(arg.element.attr("id"));
//                }
//            });
        };
        $("#"+meId+" input[type!='submit']").each(function (){
            $(this).css("float","left");
            var data_type=$(this).attr("data-type");            
            if(data_type!=undefined){
                switch(data_type){
                    case "userName" :
                        var childId=$(this).attr("id");
                        if(childId!=undefined){
                            for(indexRule in fieldsFinal){
                                if(indexRule==="userName"){
                                    for(indexAttr in fieldsFinal[indexRule]){
                                        for (index in fieldsFinal[indexRule][indexAttr]){
                                            var rule = {};
                                            for(specificAttr in fieldsFinal[indexRule][indexAttr][index]){                                                     
                                                if(index==="unique"){  
                                                    if(fieldsFinal[indexRule][indexAttr][index].url){
                                                        if(specificAttr==="url"){
                                                            rule["rule"] = function (){  
//                                                                $.ajax({
//                                                                    //Send the paramethers to servelt
//                                                                    type: "POST",
//                                                                    async: false,
//                                                                    dataType:"json",
//                                                                    url: fieldsFinal[indexRule][indexAttr][index][specificAttr],
//                                                                    data:{'value':$("#"+childId).val()},
//                                                                    beforeSend: function (xhr) {
//                                                                    },
//                                                                    error: function (jqXHR, textStatus, errorThrown) {
//                                                                        alert("Error interno del servidor");
//                                                                    },
//                                                                    success: function (data, textStatus, jqXHR) {
//                                                                        alert(data.status)
//                                                                        return data.status;
//                                                                    }
//                                                                }); 

                                                                return false;
                                                                
                                                            };                                                            
                                                        }else{                                                      
                                                            rule[specificAttr] = fieldsFinal[indexRule][indexAttr][index][specificAttr];
                                                        } 
                                                    }else{
                                                        throw new Error("The URL is proved necessary and should return true or false");
                                                    }                                                                                                       
                                                }else if(index==="length"){
                                                    if(specificAttr==="range"){
                                                        rule["rule"] = index+"="+fieldsFinal[indexRule][indexAttr][index][specificAttr];                                                        
                                                    }else{
                                                        rule[specificAttr] = fieldsFinal[indexRule][indexAttr][index][specificAttr];
                                                    }                                                        
                                                }else{
                                                    rule["rule"] = index;    
                                                    rule[specificAttr] = fieldsFinal[indexRule][indexAttr][index][specificAttr];                                                    
                                                }                                                
                                                rule["hintRender"] = hintRender;
                                                rule["input"] = "#"+childId;                                                  
                                            }
                                            rulesAll.push(rule);                                           
                                        } 
                                    }                                   
                                }
                            }                   
                            $("#triggerPopover").off("click");
                        }else{
                            throw new Error("Not found id element to validate please specific the attr");
                        }                        
                    break;
                    default :
                        console.log("Text");
                    break;
                }
            }else{
                //throw new Error("Not found data-type please specific");
            }        
        });
//        rulesAll = [{ input: '#user_name', message: 'Hola', action: 'blur', rule: function () {
//            return false;
//        }}];
        $("#"+meId).jqxValidator({
            hintType: 'label',
            rules: rulesAll,
            onError: function (event) {
                //$("#"+meId).jqxValidator('validateInput', '#passwordInput');
            }
        });        
        var settings = {
            init: function (){
                $("#"+meId+" input[type='submit']").jqxButton({
                    width: parametersFinal.widthSubmit,
                    height: parametersFinal.heightSubmit,
                    theme : theme
                });
            },
            applyValidation: function (){
                $("#"+meId).on("submit", function (){
                    $(this).jqxValidator('validate');                    
                    return false;
                });                
            }
        };   
        settings.init();
        settings.applyValidation();
    }; 
})(jQuery);;
var jqxPopover = {
    init: function (selector, title, message){
        var containerPopover = $("<span id='triggerPopover_"+selector+"'></span>").css({"height":"5px","width":"5px","position":"absolute","margin-top":"13px"});;
        $("#"+selector).parent().parent().append(containerPopover);
        var elementPopover = $("<div id='jqxPopover_"+selector+"'><div class='message_"+selector+"'>"+message+"</div></div>");
        $("body").append(elementPopover);
        $("#jqxPopover_"+selector).jqxPopover({ 
            isModal: false, 
            position: "right", 
            theme : theme,
            width:200,
            autoClose: false,
            title: title, 
            showCloseButton: true, 
            selector: $("#triggerPopover_"+selector) 
        });            
    },
    open: function (selector, message){
        $(".message_"+selector).html(message);
        $('#jqxPopover_'+selector).jqxPopover('open');
    },
    close: function (selector){
        $('#jqxPopover_'+selector).jqxPopover('close');
    }
};
$(document).ready(function (){
    $("#registerForm").ocValidate({},{
        userName : {
            rules : {
                required : {
                    message : "Este campo es requerido",
                    action : "blur"
                },
                length : {
                    message : "El numero minimo de caracteres es de 3 y un mayor de 6",
                    range : "3,6",
                    action : "keyup, blur"
                }
            }
        }
//        password : {
//            rules : {
//                required : {
//                    message : "Este campo es requerido",
//                    action : "submmit",
//                    hintRender : function (){
//                        
//                    }
//                },
//                length : {
//                    message : "El numero minimo de caracteres es de 0 y un mayor de 20",
//                    range : "0,20"
//                }
//            }
//        }
    });
});    
    