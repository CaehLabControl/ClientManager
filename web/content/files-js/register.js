/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
$(document).ready(function (){
    var formRegister = {
        init : function (form){  
            var rulesAll = [
                {
                    input: '#user_name',
                    message: 'El usuario no esta disponible',
                    action: 'blur, keyup',
                    rule: function (input, commit){   
                        var nameRegex = /^[a-z].|[a-z-._0-9]$/; 
                        if(!nameRegex.test(input.val())){
                            return formRegister.indicator(input);
                        }else{
                            if(""===input.siblings(".error").text() || "El usuario no esta disponible"===input.siblings(".error").text()){
                                return formRegister.indicator(input);                                    
                            }else{
                                jqxPopover.close(input.attr("id"));                            
                            }   
                        }     
                    }  
                },
                {
                    input: '#user_mail',
                    message: 'Este campo es necesario',
                    action: 'blur',
                    rule: 'required'
                },
                {
                    input: '#user_mail',
                    message: 'El correo no tiene un formato valido',
                    action: 'blur, keyup',
                    rule: 'email'
                },
                {
                    input: '#user_mail',
                    message: 'El correo ya se encuentra en uso',
                    action: 'blur, keyup',
                    rule: function (input, commit){
                        var result;
                        $.ajax({
                            async: false,
                            type: "POST",
                            url: "UsersService",
                            data:{
                                "mailValidate" : "",
                                "pt_mail" : input.val()
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
                },
                {
                    input: '#user_password',
                    message: 'La contraseña debe de tener un minimo de 5 caracteres y un máximo de 15',
                    action: 'blur, keyup',
                    rule: 'length=5,15'
                },
                {
                    input: '#user_password',
                    message: 'Este campo es necesario',
                    action: 'blur, keyup',
                    rule: 'required'
                },
                { 
                    input: '#same_password', 
                    message: 'Las contraseñas no coinsiden', 
                    action: 'keyup, focus', 
                    rule: function (input, commit) {
                        if (input.val() === $('#user_password').val()) {
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
                            $("#buttonRegister").jqxButton({disabled: true});
                            $("#buttonRegister").val("Registrando...");
                            $("#adding").fadeIn();
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            alert("Error interno del servidor");
                            $("#windowBlock").fadeOut();
                        },
                        success: function (data, textStatus, jqXHR) {
                            $("#buttonRegister").val("Registrando...");
                            setTimeout(function (){
                                $("#windowBlock").fadeOut();
                                $("#adding").fadeOut();
                                $("#buttonRegister").jqxButton({disabled: false});
                                $("#buttonRegister").val("Registro Ok...");
                            },2000);      
                            window.location="acount-status-active.jsp?"+data.link;
                        }
                    });
                } 
            }); 
            $("#buttonRegister").jqxButton({
                width: 200,
                theme : theme
            });  
            this.initPassword();
            this.validate(form);
        },
        indicator : function (input){
            var 
                require = "",
                regexSpaces = /\s/,
                space = "",
                regexLenght = /^.{5,10}$/,
                lenght = "",
                regexChars = /^[a-zA-ZÁáÀàÉéÈèÍíÌìÓóÒòÚúÙùÑñüÜ0-9!#\$%\^&\*\?~\/]{4,20}$/, 
                chars = "",
                imgWaiting = '<img id="detail-icon-img" src="content/pictures-system/ajax-loader.gif" alt="challenge, clock, sand, time icon" height="20" width="20">',
                check = '<img alt="icon" class="tiled-icon" style="max-width: 20px; max-height: 20px;" src="content/pictures-system/check.png">',
                uncheck = '<img alt="incorrect icon" class="tiled-icon" style="max-width: 20px; max-height: 20px;" src="content/pictures-system/uncheck.png">',
                userNameValidating = '<img id="detail-icon-img" src="content/pictures-system/waiting.png" alt="challenge, clock, sand, time icon" height="20" width="20">',
                userName = userNameValidating;
            var status=true;
            if(input.val().length>=1){
                require = check;
                if(regexLenght.test(input.val())){
                    lenght = check;
                    if(!regexSpaces.test(input.val())){
                        space = check;
                        if(regexChars.test(input.val())){
                            chars = check;
                            formRegister.uniqueUser(input);                            
                            if(input.attr("status")==="userNotAvailable"){
                                userName=imgWaiting;
                                setTimeout(function (){
                                    $("#waiting").html(uncheck);
                                },2000);
                                status=false;
                            }else if(input.attr("status")==="userAvailable"){ 
                                userName=imgWaiting;
                                setTimeout(function (){
                                    jqxPopover.close("user_name");
                                    $("#waiting").html(check);
                                },2000);                           
                            }else{
                                userName=userNameValidating;
                            }
                        }else{
                            setTimeout(function (){
                                input.siblings(".jqx-validator-error-label").hide();
                                input.siblings(".jqx-validator-error-label").text("La estructura del usuario es incorrecta");
                            },0); 
                            chars=uncheck;
                            status=false;
                        }
                    }else{
                        setTimeout(function (){
                            formRegister.indicator(input);
                            input.siblings(".jqx-validator-error-label").text("No puede contener espacios...");
                        },0);
                        space = uncheck;
                        status=false;
                    }
                }else{
                    setTimeout(function (){
                        input.siblings(".jqx-validator-error-label").hide();
                        input.siblings(".jqx-validator-error-label").text("Número de caracteres");
                    },0); 
                    lenght=uncheck;
                    status=false;
                }
            }else{
                setTimeout(function (){
                    input.siblings(".jqx-validator-error-label").hide();
                    input.siblings(".jqx-validator-error-label").text("Este campo es requerido");
                },0); 
                require = uncheck;
                status=false;
            }
            var message = "<table style='font-size: 10px;'>\n\
                        <th colspan=2>Indicador de validación</th>\n\
                            <tr>\n\
                                <td>*Nombre de usuario requerido</td>\n\
                                <td>"+require+"</td></tr>\n\
                            <tr>\n\
                                <td>*Longitud entre 5 a 10 caracteres</td>\n\
                                <td>"+lenght+"</td></tr>\n\
                            <tr>\n\
                                <td>*No puede tener espacios</td>\n\
                                <td>"+space+"</td>\n\
                            </tr>\n\
                            <tr>\n\
                                <td>*Caracteres no permitidos</td>\n\
                                <td>"+chars+"</td></tr>\n\
                            <tr>\n\
                                <td>*Nombre de usuario único</td>\n\
                                <td id='waiting'>"+userName+"</td>\n\
                            </tr>\n\
                        </table>";
            if($("#triggerPopover_"+input.attr("id")).length==0){                                
                jqxPopover.init(input.attr("id"),"Validar primero", message);                          
            }else{
                jqxPopover.open(input.attr("id"), message);                                 
            }
            return status;
        },
        initPassword : function (){
            $("#same_password").jqxPasswordInput({
                width: 178, 
                height: 30,  
                theme: theme,
                showStrength: false
            });
            $("#user_password").jqxPasswordInput({
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
        uniqueUser: function (input){
            $.ajax({
                async: false,
                type: "POST",
                url: "UsersService",
                data:{
                    "userValidate" : "",
                    "pt_user" : input.val()
                },
                dataType: 'json',
                beforeSend: function (xhr) {
                    var imgWaiting = '<img id="detail-icon-img" src="content/pictures-system/ajax-loader.gif" alt="challenge, clock, sand, time icon" height="20" width="20">';
                    input.siblings(".jqx-validator-error-label").text("Validando...");
                    input.attr("status","userValidating");
                    $("#waiting").html(imgWaiting);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert("Error interno del servidor");
                    setTimeout(function (){
                        input.siblings(".jqx-validator-error-label").hide();
                    },0);
                },
                success: function (data, textStatus, jqXHR) {
                    if(eval(data.status)){
                        input.attr("status","userAvailable");
                        setTimeout(function (){
                            input.siblings(".jqx-validator-error-label").text("Usuario disponible...");
                        },2000);
                    }else{
                        input.attr("status","userNotAvailable");
                        setTimeout(function (){
                            input.siblings(".jqx-validator-error-label").text("Usuario no disponible...");
                        },2000);
                    }
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
    var jqxPopover = {
        init: function (selector, title, message){
            var containerPopover = $("<span id='triggerPopover_"+selector+"'></span>").css({"height":"5px","width":"5px","float":"right","margin-top":"13px"});;
            $("#"+selector).parent().parent().before(containerPopover);
            var elementPopover = $("<div id='jqxPopover_"+selector+"'><div class='message_"+selector+"'>"+message+"</div></div>");
            $("body").append(elementPopover);
            $("#jqxPopover_"+selector).jqxPopover({ 
                isModal: false, 
                position: "right", 
                theme : theme,
                width:260,
                autoClose: false,
                offset : {left: 10, top: 20},
                title: title, 
                showCloseButton: true, 
                selector: $("#triggerPopover_"+selector) 
            });         
            $('#jqxPopover_'+selector).jqxPopover('open');
        },
        open: function (selector, message){
            $(".message_"+selector).html(message);
            $('#jqxPopover_'+selector).jqxPopover('open');
        },
        close: function (selector){
            $('#jqxPopover_'+selector).jqxPopover('close');
        }
    };
    var form = $("#registerForm");
    formRegister.init(form);    
});

