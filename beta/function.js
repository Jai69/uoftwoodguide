var x = document.getElementsByTagName('body');
var t = document.getElementById('header');
var h = t.clientHeight;

//Function to sort the page elements from dropdown. 
// Never did get the function to work correctly

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
            if (tableItem[0][choice].innerHTML > tableItem[i][choice].innerHTML) {
                shouldswitch = true;
                console.log('should switch' +shouldswitch)
                break;
            }

        }
        if (shouldswitch) {
            console.log('Switch', tableItem[i][choice].innerHTML + '<' + tableItem[1][choice].innerHTML, i);
            
            item[0].insertBefore(item[1]);
            console.log("Switching: "+switching);
            switching = true;
        }

    }

}