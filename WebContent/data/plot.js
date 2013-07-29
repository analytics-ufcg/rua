var dataset = [];
var svg;

var margin = {top: 20, right: 20, bottom: 30, left: 50},
    width = 960 - margin.left - margin.right,
    height = 500 - margin.top - margin.bottom;


function getMenuOption(selection) {
	//limpa containers
	cleanContainers();
    maquina = selection.options[selection.selectedIndex].value;
	console.log(maquina);
}

function cleanContainers(){
	d3.selectAll("svg")
    .remove();

	d3.selectAll("h1").remove();
}

function loadData(){
	
	d3.csv("data/Maquinas_selecionas.csv", function(data){
		
		var myList = d3.selectAll("#myList");
		myList.selectAll("option").data(data).enter().append("option")
		.attr("value",function(d){return d.Maquina;})
		.attr("label",function(d){return d.Maquina;})
		.text(function(d){return d.Maquina;});
		console.log(myList);
	});
	
	d3.csv("data/traces_selecionados.csv", function(data){
		dataset = data;
	});
	
	plotSerie();
}

function plotSerie(){
	svg = d3.select("#div_indicador").select("svg");
	
	
}