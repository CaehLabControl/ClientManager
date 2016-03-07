<div id='content' class="external">
    <script type="text/javascript" class="external">
        $(document).ready(function () {
            var index = 0;
            if (undefined == index) index = 0;
            $('#jqxTabs').jqxTabs({
                theme: "darkblue",
                selectedItem: index, 
                width: 'auto', 
                height: height-32,
                position: 'top'
            });
            // on to the select event.
            $("#jqxTabs").on('selected', function (event) {
                // save the index in cookie.
                //$.jqx.cookie.cookie("jqxTabs_jqxWidget", event.args.item);
            });
            $("#jqxWindowAccess").jqxWindow({
                theme:"darkblue", 
                okButton: $('#okAccess'),
                cancelButton: $('#cancelAccess'),
                height: 200,
                width: 350,
                autoOpen: false,
                isModal: true
            });
            $(".btnOk").click(function (){
                $("#jqxWindowAccess").jqxWindow("open");
                $("#user").focusin();
            });
            $("#okAccess").click(function (){
                console.log("Click on this");
                if(true){
                    if(true){
                        //if(socket.readyState==1){
                            $.ajax({
                                url: "content/data-jsp/views-external/monitoring/computers.jsp",
                                beforeSend: function (xhr) {
                                    $(".btnOk").hide();
                                    $(".btnOk").parent().removeAttr("id");
                                    $("#loading").show();
                                },
                                success: function (data, textStatus, jqXHR) {
                                    $("#contentSubLoad").html(data);              
                                },
                                error: function (jqXHR, textStatus, errorThrown) {
                                    alert("Error interno del servidor");   
                                }
                            });
                        //}
                    }
                }
            });
            $("#formAccess").submit(function (){
                $("#okAccess").click();
                return false;
            });
        });
    </script>
    <style class="external">
        #box-lock{
            background-image: url(content/pictures-system/Unlock.png);
            width: 450px;
            height: 450px;
            background-position: center;
            background-repeat: no-repeat;
            background-size: 90%;            
        }
        .btnOk{
            background-image: -webkit-linear-gradient(top, #fff, #838683);
            background-image: -moz-linear-gradient(top, #fff, #838683);
            background-image: -ms-linear-gradient(top, #fff, #838683);
            background-image: -o-linear-gradient(top, #fff, #838683);
            background-image: linear-gradient(to bottom, #fff, #838683);
            -webkit-border-radius: 28;
            -moz-border-radius: 28;
            border-radius: 46px;
        }

        .btnOk:hover {
            background: #838683;
            background-image: -webkit-linear-gradient(top, #838683, #fff);
            background-image: -moz-linear-gradient(top, #838683, #fff);
            background-image: -ms-linear-gradient(top, #838683, #fff);
            background-image: -o-linear-gradient(top, #838683, #fff);
            background-image: linear-gradient(to bottom, #838683, #fff);
        }
    </style>
    <div id='jqxWindowAccess' class="external">
        <div>Credenciales de acceso</div>
        <div>
            <h3 style="text-align: right; margin-top: 0px; margin-bottom: 7px; padding-right: 15px;">Acceso autorizado</h3>
            <img style="position: absolute; top: 55px;" src="content/pictures-system/Login-Manager.png" alt=""/>
            <form id="formAccess" style="float: right; margin-right: 15px; padding-top: 5px; border-top: 1px solid rgb(0, 74, 115); padding-left: 40px;">
                <label>Usuario</label><br>
                <input type="text" style="width: 160px;" placeholder="Usuario" id="user"/>
                <br>
                <label>Contraseña</label><br>
                <input type="password" placeholder="Contraseña" id="password" style="margin-bottom: 4px; width: 160px;"><br>
                <input id="okAccess" type="button" value="Autorizar"/>
                <input id="cancelAccess" type="button" value="Cancelar"/>
            </form>
        </div>
    </div>
    <div id='jqxTabs' class="external">
        <ul>
            <li style="margin-left: 30px;">Lab3</li>
        </ul>
        <div id="contentSubLoad">
            <div id="box-lock" style="margin-left: 30%;">
                <img class="btnOk" src="content/pictures-system/ok.png" alt="" style="width: 75px; margin-left: 197px; margin-top: 259px; cursor: pointer"/>
                <img id="loading" style="display: none; padding-top: 198px; padding-left: 134px;" src="content/pictures-system/default.svg">
            </div>
        </div>
    </div>
</div>