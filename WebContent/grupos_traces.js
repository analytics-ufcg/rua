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

	dataset = [{ "x_axis": 70, "y_axis": 130, "radius": 7*grupo1.length, "color" : "green" , "grupo" : "Grupo A"},
				{ "x_axis": 275, "y_axis": 240, "radius": 7*grupo2.length, "color" : "purple", "grupo" : "Grupo B"},
				{ "x_axis": 230, "y_axis": 110, "radius": 7*grupo3.length, "color" : "blue", "grupo" : "Grupo C"},
				{ "x_axis": 140, "y_axis": 270, "radius": 7*grupo4.length, "color" : "red", "grupo" : "Grupo D"}];

	var circles = svgContainer.selectAll("circle")
			.data(dataset)
			.enter()
			.append("circle");

	var legenda = svgContainer.selectAll("text")
					.data(dataset)
					.enter()
					.append("text");
	
	var rect_informacoes = svgContainer.append("rect")
							.attr("x", 400)
							.attr("y", 30)
							.attr("width", 750)
							.attr("height", 400)
							.style("stroke", "grey")
							.style("stroke-widht",3)
							.style("fill","none");
							
	var rect_miniaturas = svgContainer.append("rect")
							.attr("x", 30)
							.attr("y", 490)
							.attr("width", 1100)
							.attr("height", 270)
							.style("stroke", "grey")
							.style("stroke-widht",1)
							.style("fill","none");
	
	circles.attr("cx", function (d) { return d.x_axis; })
                       .attr("cy", function (d) { return d.y_axis; })
					   .attr("r", function (d) { return d.radius;})
					   .style("fill", function(d) { return d.color; })
					   .style("opacity", 0.3);
					  // .on("click", function(d){ 
						//			load_tables(d.grupo);});
	
	legenda.attr("x", function(d) { return d.x_axis; })
		.attr("y", function(d) { return d.y_axis; })
		.text( function (d) { return d.grupo; })
		.attr("font-family", "sans-serif")
		.attr("text-anchor", "middle")
		.attr("font-size", "15px")
		.attr("fill", "grey");
		
	load_tables("Grupo A");
	load_miniaturas("Grupo A");
}

function cleanContainers(){
	d3.selectAll("svg")
    .remove();
}

function load_miniaturas(grupo){
	// var img;
    // var svg;
	// img = document.createElement('img');
    			
	// img.src = "data/left_arrow.jpg";
	// img.style.width  = 840  + "px";
    // img.style.height = 300 + "px";
	// img.style.position = "absolute";
	// img.style.top = "100px";
	// img.style.left = "350px";
    // target = document.getElementById("noticia3");
    // target.appendChild(img);
	
	// if(grupo == "Grupo A"){
		// img.src = "data/graficos/grupoA/" + maquina + ".png";
	// }else if(grupo == "B"){
		// img.src = "data/graficos/grupoB/" + maquina + ".png";
	// }else if(grupo == "C"){
		// img.src = "data/graficos/grupoC/" + maquina + ".png";
	// }
    // img.style.width  = 840  + "px";
    // img.style.height = 300 + "px";
	// img.style.position = "absolute";
	// img.style.top = "100px";
	// img.style.left = "350px";
    // target = document.getElementById("noticia3");
    // target.appendChild(img);
	// changeTextFiltro();

}

function load_tables(grupo){

	//substituir os dois arrays pelos dados do arquivo sobre os grupos.
	
	var caracteristicas_geral = [{"caracteristica":"Caracteristica","valor":"Valor","x":500,"y":110},
							{"caracteristica":"Predominância","valor":"CPU","x":500,"y":110},
							{"caracteristica":"Proporção Memória","valor":"70%","x":430,"y":30},
							{"caracteristica":"Proporção CPU","valor":"30%","x":430,"y":30},
							{"caracteristica":"Tendência","valor":"Positiva","x":430,"y":30}];
	
	//var rect_geral = [{"x":430,"y":90,"w":250,"h":30},{"x":682,"y":90,"w":250,"h":30}];
	
	svgContainer.append("rect")
		.attr("x", 430)
		.attr("y", 90)
		.attr("width", 250)
		.attr("height", 30)
		.style("stroke", "#e8e8e8")
		.style("stroke-widht",3)
		.style("fill","#e8e8e8");
	
	svgContainer.append("rect")
		.attr("x", 682)
		.attr("y", 90)
		.attr("width", 80)
		.attr("height", 30)
		.style("stroke", "#e8e8e8")
		.style("stroke-widht",3)
		.style("fill","#e8e8e8");
							
	svgContainer.append("rect")
		.attr("x", 430)
		.attr("y", 120)
		.attr("width", 332)
		.attr("height", 230)
		.style("stroke", "#e8e8e8")
		.style("stroke-widht",3)
		.style("fill","white");
	
	svgContainer.append("text")
				.attr("x", 550)
				.attr("y", 60)
				.text("Informações sobre o " + grupo)
				.attr("text-anchor", "middle")
				.attr("font-size", "15px")
				.attr("fill","black"); 
	
	svgContainer.append("text")
		.data(caracteristicas_geral)
		.attr("x", function(d){return d.x;})
		.attr("y", function(d){return d.y;})
		.text(function(d){return d.caracteristica})
		.attr("text-anchor", "middle")
		.attr("font-size", "15px")
		.attr("fill","black");
	
	svgContainer.append("text")
		.data(caracteristicas_geral)
		.attr("x", function(d){return d.x + 210;})
		.attr("y", function(d){return d.y;})
		.text(function(d){return d.valor})
		.attr("text-anchor", "middle")
		.attr("font-size", "15px")
		.attr("fill","black");
	
}