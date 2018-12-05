// Javascript

//var type = ['L', 'W'];
var species = [];
var genus = [];
var comname = [];
var family = [];
var loc = [];
var collector = [];
var contributor = [];
var dates = [];
window.onload = function () {
    if (window.innerWidth > 1000) {
        screen = window.innerWidth - 210;
        document.getElementsByTagName('body')[0].style = 'width:' + screen + ';'
    }
}

function generateUniques() {
    for (var i = 0; i < trees.length; i++) {
        if (!species.includes(trees[i].Species)) {
            species.push(trees[i].Species);
        }
        if (!genus.includes(trees[i].Genus)) {
            genus.push(trees[i].Genus);
        }
        if (!comname.includes(trees[i].ComName)) {
            comname.push(trees[i].ComName);
        }
        if (!family.includes(trees[i].Family)) {
            family.push(trees[i].Family);
        }
        if (!loc.includes(trees[i].Location)) {
            loc.push(trees[i].Location);
        }
        if (!collector.includes(trees[i].Collector)) {
            collector.push(trees[i].Collector);
        }
        if (!contributor.includes(trees[i].Contributor)) {
            contributor.push(trees[i].Contributor);
        }
        if (!dates.includes(trees[i].Date)) {
            dates.push(trees[i].Date);
        }

    }
    species.sort();
    genus.sort();
    comname.sort();
    family.sort();
    loc.sort();
    collector.sort();
    contributor.sort();
    dates.sort();
}

function updateNav() {
    nav = document.getElementById('dropdown');
    console.log(nav.value);
    switch (nav.value) {
        case "Species":
            popNav(species);
            break;
        case "Family":
            popNav(family);
            break;
        case "Common Name":
            popNav(comname);
            break;
        case "Genus":
            popNav(genus);
            break;
        case "Location":
            popNav(loc);
            break;
        case "Collector":
            popNav(collector);
            break;
        case "Contributor":
            popNav(contributor);
            break;
        case "Date":
            popNav(dates);
            break;
    }
}

function popNav(s) {
    var l = [];
    for (var i = 0; i < s.length; i++) {
        l.push('<ni onclick="loadContent(' + "'" + s[i] + "'" + '); menu(false);">' + s[i] + "</ni>")
    }
    var temp = l.join('');
    return document.getElementById('filter').innerHTML = temp;
}

function loadContent(c) {
    var item = [];
    console.log(c);
    for (var i = 0; i < trees.length; i++) {
        if (trees[i].Species == c || trees[i].Family == c || trees[i].Genus == c || trees[i].ComName == c || trees[i].Location == c || trees[i].Collector == c || trees[i].Contributor == c || trees[i].Date == c) {
            console.log("Match");

            item.push("<div class='item'><div class='picture'><object type='image/jpeg' data ='../images/jpeg/" + trees[i].Num + (trees[i].Type).toLowerCase() + "(a).jpeg'><img src='../images/uoftForestry.jpg'></object></div>");
            item.push("<table>");
            item.push("<tr><td class='key'>Type</td><td class='type'>" + trees[i].Type + "</td></tr>");
            item.push("<tr><td class='key'>Num</td><td class='num'>" + trees[i].Num + "</td></tr>");
            item.push("<tr><td class='key'>Genus</td><td class='genus'>" + trees[i].Genus + "</td></tr>");
            item.push("<tr><td class='key'>Species</td><td class='species'>" + trees[i].Species + "</td></tr>");
            item.push("<tr><td class='key'>Family</td><td class= 'family'>" + trees[i].Family + "</td></tr>")
            item.push("<tr><td class='key'>ComName</td><td class='comname'>" + trees[i].ComName + "</td></tr>");
            item.push("<tr><td class='key'>Location</td><td class='location'>" + trees[i].Location + "<td></tr>");
            item.push("<tr><td class='key'>Collector</td><td class='collector'>" + trees[i].Collector + "</td></tr>");
            item.push("<tr><td class='key'>Contributor</td><td class='contributor'>" + trees[i].Contributor + "</td></tr>");
            item.push("<tr><td class ='key'>Date</td><td class='date'>" + trees[i].Date + "</td></tr>");
            item.push("<tr><td class ='key'>Notes</td><td class ='notes'>" + trees[i].Notes + "</td></tr>");
            item.push("</table></div>");
        }
    }
    var results = item.join('');
    return document.getElementById('content').innerHTML = results;
}


generateUniques();
popNav(species)
loadContent(species[0]);
