var grupo;
var svgContainer;

function getMenuOptionGrupo(selection) {
	//limpa containers
	cleanContainers();
    grupo = selection.options[selection.selectedIndex].value;
	
	clearImages()
	getGrupos();
	return grupo;
}

function selecionar_grupo(opcao){
	var myList = d3.selectAll("#myListGrupos");
	opcao_carac = opcao;
	
	correlacao_cruzada = [{grupo:"Grupo1"},{grupo:"Grupo2"},{grupo:"Grupo3"}];
	
	if(opcao == "1"){
		myList = d3.selectAll("#myListGrupos");
		myList.selectAll("option").remove();
		clearImages()
		myList.selectAll("option").data(correlacao_cruzada).enter().append("option")
		.attr("value",function(d){return d.grupo;})
		.attr("label",function(d){return d.grupo;})
		.text(function(d){return d.grupo;});
	}else if(opcao == "2"){
		myList = d3.selectAll("#myListGrupos");
		myList.selectAll("option").remove();
		clearImages()
		myList.selectAll("option").data(correlacao_cruzada).enter().append("option")
		.attr("value",function(d){return d.grupo;})
		.attr("label",function(d){return d.grupo;})
		.text(function(d){return d.grupo;});
	}else if(opcao == "3"){
		myList = d3.selectAll("#myListGrupos");
		myList.selectAll("option").remove();
		clearImages()
		myList.selectAll("option").data(correlacao_cruzada).enter().append("option")
		.attr("value",function(d){return d.grupo;})
		.attr("label",function(d){return d.grupo;})
		.text(function(d){return d.grupo;});
	}else if(opcao == "4"){
		myList = d3.selectAll("#myListGrupos");
		myList.selectAll("option").remove();
		clearImages()
		myList.selectAll("option").data(correlacao_cruzada).enter().append("option")
		.attr("value",function(d){return d.grupo;})
		.attr("label",function(d){return d.grupo;})
		.text(function(d){return d.grupo;});
	}
}

function getGrupos(){
    var img;
    var svg;
	img = document.createElement('img');
	
	if(opcao_carac == "1"){
		img.src = "data/graficos/agrupamento/correlacao/"+ grupo + ".csv.png";
	}else if(opcao_carac == "2"){
		img.src = "data/graficos/agrupamento/dtw/" + grupo + ".csv.png";
	}else if(opcao_carac == "3"){
		img.src = "data/graficos/agrupamento/distancia/" + grupo + ".csv.png";
	}else if(opcao_carac == "4"){
		img.src = "data/graficos/agrupamento/correlacao_cruzada/" + grupo + ".png";
		img.style.width  = 850  + "px";
		img.style.height = 550 + "px";
	}
    
	img.style.position = "absolute";
	img.style.top = "120px";
	img.style.left = "270px";
    target = document.getElementById("metricas");
    target.appendChild(img);
	changeTextFiltro();
}

function cleanContainers(){
	d3.selectAll("svg")
    .remove();
}

function clearImages(){
	if(document.getElementById("img") != null){
		document.getElementById("img").remove();
	}
}
