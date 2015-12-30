<!DOCTYPE html>
<html lang="en">
<head>
<meta name="keywords" content="jqxDragDrop" />
<meta name="description" content="jqx"/>
   <style type="text/css">
        .draggable-demo-cart
        {
            border: 2px dashed #aaa;
            padding: 5px;
            width: 232px;
            margin: auto;
        }
        .draggable-demo-shop 
        {
            border: 1px solid #666;
            width: auto;
            padding: 5px;
        }
        .draggable-demo-catalog
        {
            position: relative;
            width: 75%;
            border: 1px solid #bbb;
            height: 457px;
            float: left;
        }
        .draggable-demo-team-image
        {
            width: 150px;
        }
        .draggable-demo-team
        {
            padding: 5px;
            width: 70px;
            height: 110px;
            background-color: #fff;
            position: absolute;
            margin: 5px;
            border: 1px solid #304269;
            cursor: pointer;
        }
        .draggable-demo-team img
        {
            width: 70px;
            margin-top: 8px;
            border-top-width: 0px;
            outline-width: 15px;
        }
        .draggable-demo-team-header
        {
            border: 1px solid #888;
            height: 20px;
            border-bottom-width: 0px;
            font-size: 13px;
            position: relative;
            text-align: center;
        }
        .draggable-demo-team-header-label
        {
            margin-top: 3px;
        }
        .draggable-demo-team-status
        {
            position: absolute;
            top: 100px;
            left: 6px;
            width: 70px;
            text-align: center;
            font-family: Verdana;
            font-size: 11px;
            display: none;
            height: 16px;
            border-top: 1px solid #888;
            border-bottom: 1px solid #fff;
            background-color: #20ec20;
            color: #fff;
        }
        .draggable-demo-title
        {
            font-size: 23px;
            font-family: Verdana;
            text-align: center;
            padding: 7px;
            margin: 5px;
            font-weight: bold;
            border: 1px solid #aaa;
        }
        .draggable-demo-cart-wrapper
        {
            float: right;
            border: 1px solid #aaa;
            height: 457px;
            width: 260px;
        }
        .draggable-demo-total
        {
            font-size: 17px;
            font-family: Verdana;
            margin: 6px;
            margin-top: 7px;            
            padding: 7px;
        }
    </style>
    <script type="text/javascript">
        var cart = (function ($) {
            theme = $.jqx.theme;
            var productsOffset = 5,
                teams = [
                    {
                        name: 'Equipo 1',
                        pic: 'content/pictures-system/client.png',
                        status: 'Disponible',
                        id: '0',
                        ip: ''
                    },
                    {
                        name: 'Equipo 2',
                        pic: 'content/pictures-system/client.png',
                        status: 'Disponible',
                        id: '1',
                        ip: ''
                    },
                    {
                        name: 'Equipo 3',
                        pic: 'content/pictures-system/client.png',
                        status: 'Disponible',
                        id: '2',
                        ip: ''
                    },
                    {
                        name: 'Equipo 4',
                        pic: 'content/pictures-system/client.png',
                        status: 'Disponible',
                        id: '3',
                        ip: ''
                    },
                    {
                        name: 'Equipo 5',
                        pic: 'content/pictures-system/client.png',
                        status: 'Disponible',
                        id: '4',
                        ip: ''
                    },
                    {
                        name: 'Equipo 6',
                        pic: 'content/pictures-system/client.png',
                        status: 'Disponible',
                        id: '5',
                        ip: ''
                    },
                    {
                        name: 'Equipo 7',
                        pic: 'content/pictures-system/client.png',
                        status: 'Disponible',
                        id: '6',
                        ip: ''
                    },
                    {
                        name: 'Equipo 8',
                        pic: 'content/pictures-system/client.png',
                        status: 'Disponible',
                        id: '7',
                        ip: ''
                    },
                    {
                        name: 'Equipo 9',
                        pic: 'content/pictures-system/client.png',
                        status: 'Disponible',
                        id: '8',
                        ip: ''
                    },
                    {
                        name: 'Equipo 10',
                        pic: 'content/pictures-system/client.png',
                        status: 'Disponible',
                        id: '9',
                        ip: ''
                    },
                    {
                        name: 'Equipo 11',
                        pic: 'content/pictures-system/client.png',
                        status: 'Disponible',
                        id: '10',
                        ip: ''
                    },
                    {
                        name: 'Equipo 12',
                        pic: 'content/pictures-system/client.png',
                        status: 'Disponible',
                        id: '11',
                        ip: ''
                    },
                    {
                        name: 'Equipo 13',
                        pic: 'content/pictures-system/client.png',
                        status: 'Disponible',
                        id: '12',
                        ip: ''
                    },
                    {
                        name: 'Equipo 14',
                        pic: 'content/pictures-system/client.png',
                        status: 'Disponible',
                        id: '13',
                        ip: ''
                    },
                    {
                        name: 'Equipo 15',
                        pic: 'content/pictures-system/client.png',
                        status: 'Disponible',
                        id: '14',
                        ip: ''
                    },
                    {
                        name: 'Equipo 16',
                        pic: 'content/pictures-system/client.png',
                        status: 'Disponible',
                        id: '15',
                        ip: ''
                    },
                    {
                        name: 'Equipo 17',
                        pic: 'content/pictures-system/client.png',
                        status: 'Disponible',
                        id: '16',
                        ip: ''
                    },
                    {
                        name: 'Equipo 18',
                        pic: 'content/pictures-system/client.png',
                        status: 'Disponible',
                        id: '17',
                        ip: ''
                    }
                ], theme, onCart = false, cartItems = [], totalPrice = 0;
            function render() {
                teamsRendering();
                gridRendering();
            };
            function addClasses() {
                //$('.draggable-demo-catalog').addClass('jqx-scrollbar-state-normal-' + theme);
                $('.draggable-demo-title').addClass('jqx-expander-header-' + theme);
                $('.draggable-demo-title').addClass('jqx-expander-header-expanded-' + theme);
                $('.draggable-demo-total').addClass('jqx-expander-header-' + theme).addClass('jqx-expander-header-expanded-' + theme);
                if (theme === 'shinyblack') {
                    $('.draggable-demo-shop').css('background-color', '#555');
                    $('.draggable-demo-team').css('background-color', '#999');
                }
            };
            function teamsRendering() {
                var catalog = $('#catalog'),
                    imageContainer = $('</div>'),
                    image, team, left = 0, top = 0, counter = 0;
                for (var name in teams) {
                    team = teams[name];
                    image = createProduct(team);
                    image.appendTo(catalog);
                    if (counter !== 0 && counter % 9 === 0) {
                        top += 130; // image.outerHeight() + teamsOffset;
                        left = 0;
                    }
                    image.css({
                        left: left,
                        top: top
                    });
                    left += 90; // image.outerWidth() + teamsOffset;
                    counter += 1;
                }
                $('.draggable-demo-team').jqxDragDrop({ dropTarget: $('#cart'), revert: true });
            };
            function createProduct(team) {
                return $('<div class="draggable-demo-team jqx-rc-all" data-target="'+team.id+'">' +
                        '<div class="jqx-rc-t draggable-demo-team-header jqx-widget-header-' + theme + ' jqx-fill-state-normal-' + theme + '">' +
                        '<div class="draggable-demo-team-header-label"> ' + team.name + '</div></div>' +
                        '<div class="jqx-fill-state-normal draggable-demo-team-status"><strong>' + team.status + '</strong></div>' +
                        '<img src="' + team.pic + '" alt='
                        + team.name + '" class="jqx-rc-b" />' +
                        '</div>');
            };
            function gridRendering() {
                $("#jqxgrid").jqxGrid(
                {
                    height: 335,
                    width: 230,
                    showemptyrow: false,
                    theme: "darkblue",
                    keyboardnavigation: false,
                    selectionmode: 'none',
                    columns: [
                      { text: 'Equipo', dataField: 'name', width: 150 },
                      { text: 'Quitar', dataField: 'remove' }
                    ]
                });
                $("#jqxgrid").bind('cellclick', function (event) {
                    var index = event.args.rowindex;
                    if (event.args.datafield == 'remove') {
                        var item = cartItems[index];
                        if (item.count > 1) {
//                            item.count -= 1;
//                            updateGridRow(index, item);
                        }
                        else {
                            cartItems.splice(index, 1);
                            removeGridRow(index);
                        }
                        updatePrice(-1);
                    }
                });
            };
            function init() {
                theme = "darkblue";
                render();
                addClasses();
                addEventListeners();
            };
            function addItem(item) {
                var index = getItemIndex(item.name);
                if (index >= 0) {
//                    cartItems[index].count += 1;
//                    updateGridRow(index, cartItems[index]);
                } else {
                    var id = cartItems.length,
                        item = {
                            name: item.name,
                            count: 1,
                            status: item.status,
                            index: id,
                            remove: '<div style="text-align: center; cursor: pointer; width: 53px;"' +
                         'id="draggable-demo-row-' + id + '">X</div>'
                        };
                    cartItems.push(item);
                    addGridRow(item);
                    updatePrice(1);
                }                
            };
            function updatePrice(status) {
                totalPrice += status;
                $('#total').html(' ' + totalPrice);
            };
            function addGridRow(row) {
                $("#jqxgrid").jqxGrid('addrow', null, row);
            };
            function updateGridRow(id, row) {
                var rowID = $("#jqxgrid").jqxGrid('getrowid', id);
                $("#jqxgrid").jqxGrid('updaterow', rowID, row);
            };
            function removeGridRow(id) {
                var rowID = $("#jqxgrid").jqxGrid('getrowid', id);
                $("#jqxgrid").jqxGrid('deleterow', rowID);
            };
            function getItemIndex(name) {
                for (var i = 0; i < cartItems.length; i += 1) {
                    if (cartItems[i].name === name) {
                        return i;
                    }
                }
                return -1;
            };
            function toArray(obj) {
                var item, array = [], counter = 1;
                for (var key in obj) {
                    item = {};
                    item = {
                        name: key,
                        status: obj[key].status,
                        count: obj[key].count,
                        number: counter
                    }
                    array.push(item);
                    counter += 1;
                }
                return array;
            };
            function addEventListeners() {
                $('.draggable-demo-team').mouseenter(function () {
                    $(this).children('.draggable-demo-team-status').fadeTo(100, 0.9);
                });
                $('.draggable-demo-team').mouseleave(function () {
                    $(this).children('.draggable-demo-team-status').fadeTo(100, 0);
                });
                $('.draggable-demo-team').bind("click", function () {
                    $(this).jqxDragDrop({disabled:true});
                    sendMessage($(this).attr("data-target"), "slave");
                });
                $('.draggable-demo-team').bind('dropTargetEnter', function (event) {
                    
                    $(event.args.target).css('border', '2px solid #000');
                    onCart = true;
                    $(this).jqxDragDrop('dropAction', 'none');
                });
                $('.draggable-demo-team').bind('dropTargetLeave', function (event) {
                    $(event.args.target).css('border', '2px solid #aaa');
                    onCart = false;
                    $(this).jqxDragDrop('dropAction', 'default');
                });
                $('.draggable-demo-team').bind('dragEnd', function (event) {
                    $('#cart').css('border', '2px dashed #aaa');
                    if (onCart) {
                        $("#jqxWindowUseTeam").jqxWindow("open");
                        addItem({ status: event.args.status, name: event.args.name });
                        onCart = false;                        
                    }
                });
                $('.draggable-demo-team').bind('dragStart', function (event) {
                    
                    var tshirt = $(this).find('.draggable-demo-team-header').text(),
                        status = $(this).find('.draggable-demo-team-status').text().replace('Disponible', '');
                    $('#cart').css('border', '2px solid #aaa');
                    status = parseInt(status, 10);
                    $(this).jqxDragDrop('data', {
                        status: status,
                        name: tshirt
                    });
                });
                $("#okUse").click(function (event){
                    $(this).attr("data-use", false);
                });
            };
            return {
                init: init
            }
        } ($));
        $(document).ready(function () {
            cart.init();
            $("#jqxWindowUseTeam").jqxWindow({
                theme:"darkblue", 
                okButton: $('#okUse'),
                cancelButton: $('#cancelUse'),
                height: 200,
                width: 350,
                autoOpen: false,
                isModal: true
            });       
        });
    </script>
</head>
<body class='default'>
    <div id='jqxWindowUseTeam'>
        <div>Notificación</div>
        <div>
            <h3 style="text-align: right; margin-top: 0px; margin-bottom: 7px; padding-right: 15px;">Usar este equipo como...</h3>
            <img style="position: absolute; top: 85px; width: 115px;" src="content/pictures-system/client.png" alt=""/>
            <div id="rolGroup" style="text-align: right; margin-right: 12px;">
                <label><input type="radio" name="useRol">Alumno</label>
                <label><input type="radio" name="useRol">Profesor</label>
                <label><input type="radio" name="useRol">Invitado</label>
            </div>
            <form style="float: right; margin-right: 15px; padding-top: 5px; border-top: 1px solid rgb(0, 74, 115); padding-left: 60px;">
                <label><b>Código de acceso</b></label><br>
                <input type="text" style="width: 160px; margin-bottom: 20px; height: 26px; font-size: 18px; margin-top: 8px;" placeholder="Código"/>
                <br>
                <input id="okUse" type="button" value="Usar" data-use='false' style="width: 75px; font-size: 16px;"/>
                <input id="cancelUse" type="button" value="Cancelar" style="width: 75px; font-size: 16px;"/>
            </form>
        </div>
    </div>
    <div id="shop" class="draggable-demo-shop jqx-rc-all">
        <div id="catalog" class="draggable-demo-catalog jqx-rc-all"></div>
        <div class="draggable-demo-cart-wrapper jqx-rc-all">
            <div class="draggable-demo-title jqx-rc-t">Equipos en uso</div>
                <div id='cart' class="draggable-demo-cart jqx-rc-all">
                    <div id="jqxgrid"></div>
                </div>
                <div class="draggable-demo-total">Total<strong><span id="total"> 0</span></strong></div>
            </div>
        <div style="clear: both;"></div>
    </div>
</body>
</html>