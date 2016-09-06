/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function (){
    var formRequestPassword = {
        init : function (form){  
            var rulesAll = [
                {
                    input: '#user_name',
                    message: 'Este campo es necesario',
                    action: 'blur',
                    rule: 'required'
                },
                {
                    input: '#user_name',
                    message: 'El nombre de usuario o correo es incorrecto',
                    action: 'blur',
                    rule: function (input, commit){
                        var result;
                        $.ajax({
                            async: false,
                            type: "POST",
                            url: "UsersService",
                            data:{
                                "mailOrUserName" : "",
                                "pt_user" : input.val()
                            },
                            dataType: 'json',
                            beforeSend: function (xhr) {
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                alert("Error interno del servidor");
                            },
                            success: function (data, textStatus, jqXHR) {
                                result = eval(data.status);
                            }                            
                        });
                        if(result){
                            return  result;
                        }else{
                            return false;
                        }
                    }
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
                            $("#buttonRequestPassword").jqxButton({disabled: true});
                            $("#buttonRequestPassword").val("Solicitando...");
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            alert("Error interno del servidor");
                            $("#windowBlock").fadeOut();
                        },
                        success: function (data, textStatus, jqXHR) {
                            setTimeout(function (){
                                $("#windowBlock").fadeOut();
                                $("#buttonRequestPassword").jqxButton({disabled: false});
                                $("#buttonRequestPassword").val("Solicitar nueva contraseña");
                                if(data.sendMailStatus==="Success"){
                                    $(form).hide();
                                    $("#indicationsResetPassword").show();
                                }
                            },500);
                        }
                    });
                } 
            }); 
            $("#buttonRequestPassword").jqxButton({
                width: 190,
                theme : theme
            });  
            $("#button").jqxButton({
                width: 190,
                theme : theme
            });  
            this.validate(form);
        },
        validate : function (form){
            form.on("submit", function (){
                $(this).jqxValidator('validate');
                return  false;
            });
        }        
    }; 
    
    var form = $("#requestPasswordForm");
    formRequestPassword.init(form);    
});