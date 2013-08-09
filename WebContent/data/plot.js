var dataset = [];
var filtro_mem = [];
var filtro_cpu = [];
var maquina;

function getMenuOption(selection) {
	//limpa containers
	cleanContainers();
    maquina = selection.options[selection.selectedIndex].value;
	
	clearImages()
	getAplicacao();
	return maquina;
}

function cleanContainers(){
	d3.selectAll("svg")
    .remove();

	d3.selectAll("h1").remove();
}

function loadData(){
	
	d3.csv("data/Maquinas_selecionas.csv", function(data){
		dataset = data;
	});

}

function filtrar_aplicacoes(opcao){
	
	filtro_mem = dataset.filter(function(i){return i.mem == "TRUE";});
	filtro_cpu = dataset.filter(function(i){return i.cpu == "TRUE";});
	var myList = d3.selectAll("#myList");
	
	//Atualizar dropdown a cada selecao de variavel
	if(opcao == "1"){
		
		myList = d3.selectAll("#myList");
		myList.selectAll("option").remove();
		clearImages()
		myList.selectAll("option").data(filtro_mem).enter().append("option")
		.attr("value",function(d){return d.maquina;})
		.attr("label",function(d){return d.maquina;})
		.text(function(d){return d.maquina;});
	}else if(opcao == "2"){
		
		myList = d3.selectAll("#myList");
		myList.selectAll("option").remove();
		clearImages()
		myList.selectAll("option").data(filtro_cpu).enter().append("option")
		.attr("value",function(d){return d.maquina;})
		.attr("label",function(d){return d.maquina;})
		.text(function(d){return d.maquina;});
	}else if(opcao == "3"){
		
		myList = d3.selectAll("#myList");
		myList.selectAll("option").remove();
		clearImages()
		myList.selectAll("option").data(dataset).enter().append("option")
		.attr("value",function(d){return d.maquina;})
		.attr("label",function(d){return d.maquina;})
		.text(function(d){return d.maquina;});
	}
	
}

function getAplicacao(){
    var img;
    img = document.createElement('img');
    img.src = "data/graficos/mem/" + maquina + ".png";
    img.style.width  = 940  + "px";
    img.style.height = 300 + "px";
	img.style.position = "absolute";
	img.style.top = "70px";
	img.style.left = "250px";
    target = document.getElementById("caracteristicas");
    target.appendChild(img);

}

function clearImages(){
	if(document.getElementById("img") != null){
		document.getElementById("img").remove();
		d3.selectAll("svg").remove();
	}
}


// function navegar_traces(){
	// console.log("Navegar entre os traces");
// }

// function classificar_aplicacoes(){
	// console.log("Classificar aplicacoes");
// }