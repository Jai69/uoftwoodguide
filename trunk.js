var x = document.getElementsByTagName('body');
var t = document.getElementById('header');
var h = t.clientHeight;


function sortList(choice) {

    var i, j, item, switching, shouldswitch;
    var tableItem = [];
    var c = []
    item = document.getElementsByClassName('item');
    for (j = 0; j < (item.length); j++) {
        tableItem.push(item[j].getElementsByClassName('detail'));
        c.push(tableItem[j][choice].innerHTML);
    }
    //console.log(c.sort());

    switching = true;
    while (switching) {
        switching = false;

        for (i = 0; i < (item.length - 1); i++) {
            //console.log(c[i],tableItem[i][choice].innerHTML, c[i+1],tableItem[i + 1][choice].innerHTML);
            if (c[i] > c[i + 1]) {
                console.log('should switch')
                shouldswitch = true;
                break;
            }

        }
        if (shouldswitch) {
            tableItem[i][choice].parentNode.parentNode.insertBefore(item[i + 1], item[i]);
            console.log('Switch', tableItem[i][choice].innerHTML + '->' + tableItem[i + 1][choice].innerHTML);
            switching = true;
            console.log(switching);
        }

    }

}
