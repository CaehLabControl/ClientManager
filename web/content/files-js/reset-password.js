/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function (){
    var formResetPassword = {
        init : function (form){  
            var rulesAll = [
                {
                    input: '#new_password',
                    message: 'La contraseña debe de tener un minimo de 5 caracteres y un máximo de 15',
                    action: 'blur, keyup',
                    rule: 'length=5,15'
                },
                {
                    input: '#new_password',
                    message: 'Este campo es necesario',
                    action: 'blur, keyup',
                    rule: 'required'
                },
                { 
                    input: '#same_password', 
                    message: 'Las contraseñas no coinsiden', 
                    action: 'keyup, focus', 
                    rule: function (input, commit) {
                        if (input.val() === $('#new_password').val()) {
                            return true;
                        }
                        return false;
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
                            $("#buttonReset").jqxButton({disabled: true});
                            $("#buttonReset").val("Cambiando...");
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            alert("Error interno del servidor");
                            $("#windowBlock").fadeOut();
                        },
                        success: function (data, textStatus, jqXHR) {
                            setTimeout(function (){
                                $("#windowBlock").fadeOut();
                                $("#buttonReset").jqxButton({disabled: false});
                                $("#buttonReset").val("Cambiar");
                                if(data.status==="Success"){
                                    $(form).hide();
                                    $("#formExit").show();
                                }
                            },500);
                        }
                    });
                } 
            }); 
            $("#buttonReset").jqxButton({
                width: 100,
                theme : theme
            });  
            $("#button").jqxButton({
                width: 100,
                theme : theme
            });  
            this.initPassword();
            this.validate(form);
        },
        initPassword : function (){
            $("#same_password").jqxPasswordInput({
                width: 178, 
                height: 30,  
                theme: theme,
                showStrength: false
            });
            $("#new_password").jqxPasswordInput({
                width: 178, 
                height: 30,  
                theme: theme,
                showStrength: true, 
                showStrengthPosition: "right",
                // The passwordStrength enables you to override the built-in strength calculation.
                passwordStrength: function (password, characters, defaultStrength) {
                    var length = password.length;
                    var letters = characters.letters;
                    var numbers = characters.numbers;
                    var specialKeys = characters.specialKeys;
                    var strengthCoefficient = letters + numbers + 2 * specialKeys + letters * numbers * specialKeys;
                    var strengthValue;
                    if (length < 4) {
                        strengthValue = "Corta";
                    } else if (strengthCoefficient < 10) {
                        strengthValue = "Regular";
                    } else if (strengthCoefficient < 20) {
                        strengthValue = "Mala";
                    } else if (strengthCoefficient < 30) {
                        strengthValue = "Buena";
                    } else {
                        strengthValue = "Larga";
                    };
                    return strengthValue;
                },
                // The strengthTypeRenderer enables you to override the built-in rendering of the Strength tooltip.
                strengthTypeRenderer: function (password, characters, defaultStrength) {
                    var length = password.length;
                    var letters = characters.letters;
                    var numbers = characters.numbers;
                    var specialKeys = characters.specialKeys;
                    var strengthCoefficient = letters + numbers + 2 * specialKeys + letters * numbers / 2 + length;
                    var strengthValue;
                    var color;
                    if (length < 8) {
                        strengthValue = "Corta";
                        color = "rgb(170, 0, 51)";
                    } else if (strengthCoefficient < 20) {
                        strengthValue = "Regular";
                        color = "rgb(170, 0, 51)";
                    } else if (strengthCoefficient < 30) {
                        strengthValue = "Mala";
                        color = "rgb(255, 204, 51)";
                    } else if (strengthCoefficient < 40) {
                        strengthValue = "Buena";
                        color = "rgb(45, 152, 243)";
                    } else {
                        strengthValue = "Larga";
                        color = "rgb(118, 194, 97)";
                    };
                    return "<div style='font-style: italic; font-weight: bold; color: #fff;'>" + strengthValue + "</div>";
                }
            });
        },
        validate : function (form){
            form.on("submit", function (){
                $(this).jqxValidator('validate');
                return  false;
            });
        }        
    }; 
    
    var form = $("#resetPasswordForm");
    formResetPassword.init(form);    
});