var grupo1 = [];
var grupo2 = [];
var grupo3 = [];
var grupo4 = [];

//codigo pro carousel
/* $(document).ready(function(){
	$('#carousel').cycle({
		fx:   		'scrollHorz',
		prev: 		'#prev',
		next: 		'#next'
	});
 
}); */

var svgContainer;

function settings(){
	cleanContainers();
	
	svgContainer = d3.select("#noticia3").append("svg")
			 .attr("width", width)
			 .attr("height", height)
			 .attr("position","relative");
	
	grupo1 = grupos.filter(function(i){return i.grupo == '1';});
	grupo2 = grupos.filter(function(i){return i.grupo == '2';});
	grupo3 = grupos.filter(function(i){return i.grupo == '3';});
	grupo4 = grupos.filter(function(i){return i.grupo == '4';});
	
	var width = 1170;
	var height = 800;

	
}

function cleanContainers(){
	d3.selectAll("svg")
    .remove();
}

function load_miniaturas(grupo){

}

function load_tables(grupo){
}