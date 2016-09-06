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
$(document).ready(function (){
    var formLogin = {
        init : function (form){  
            var rulesAll = [
                {
                    input: '#user_name',
                    message: 'Este campo es necesario',
                    action: 'blur',
                    rule: 'required'
                },
                {
                    input: '#user_password',
                    message: 'Este campo es necesario',
                    action: 'blur',
                    rule: 'required'
                }
            ];
            form.jqxValidator({
                hintType: 'label',
                rules: rulesAll,
                onError: function (event) {
                },
                onSuccess: function () {                    
                    $.ajax({
                        async: true,
                        type: "POST",
                        url: "UsersService",
                        data: form.serialize(),
                        dataType: 'json',
                        beforeSend: function (xhr) {
                            $("#windowBlock").fadeIn();
                            $("#buttonLogin").jqxButton({disabled: true});
                            $("#buttonLogin").val("Ingresando...");
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            alert("Error interno del servidor");
                            $("#windowBlock").fadeOut();
                        },
                        success: function (data, textStatus, jqXHR) {
                            $(".clear").hide();
                            setTimeout(function (){
                                $("#windowBlock").fadeOut();
                                $("#buttonLogin").jqxButton({disabled: false});
                                $("#buttonLogin").val("Ingresar");
                                if(data.status==="exist" && data.fl_status_acount==="0"){
                                    window.location="acount-status-active.jsp?"+data.link;
                                }else if(data.status==="notExist"){
                                    $(".clear").show();
                                }else{
                                    window.location="index.jsp";
                                }
                            },1000);
                            setTimeout(function (){
                                $(".clear").hide();
                            },5000);
                        }
                    });
                } 
            }); 
            $("#buttonLogin").jqxButton({
                width: 200,
                theme : theme
            });  
            this.initPassword();
            this.validate(form);
        },
        initPassword : function (){
            $("#user_password").jqxPasswordInput({
                theme: theme,
                showStrength: false
            });
        },
        validate : function (form){
            form.on("submit", function (){
                $(this).jqxValidator('validate');
                return  false;
            });
        }        
    }; 
    
    var form = $("#loginForm");
    formLogin.init(form);    
});



