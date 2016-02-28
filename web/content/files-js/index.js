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
$(document).ready(function (){
    $('#jqxMenu').on('itemclick', function (event){
        var element = event.args;
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




