var dataset = [];
var filtro_mem = [];
var filtro_cpu = [];
var maquina;
var opcao_caract;

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
	opcao_carac = opcao;
	
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
    var svg;
	img = document.createElement('img');
    img.src = "data/graficos/mem/" + maquina + ".png";
    img.style.width  = 940  + "px";
    img.style.height = 300 + "px";
	img.style.position = "absolute";
	img.style.top = "70px";
	img.style.left = "250px";
    target = document.getElementById("caracteristicas");
    target.appendChild(img);
	changeText();
}

function clearImages(){
	if(document.getElementById("img") != null){
		document.getElementById("img").remove();
	}
}

function getvalores_mem(variavel){
	if(variavel =="1"){
		return filtro_mem.filter(function(i){return i.maquina == maquina;})[4];
	}
}

function changeText(){
	var maquina_selecionada,texto;
	if(opcao_carac == "1"){
		maquina_selecionada = filtro_mem.filter(function(i){return i.maquina == maquina;});
		texto ="Variabilidade: "+ maquina_selecionada[0].var_mem +
		"<br>Desvio Padrão: "+ maquina_selecionada[0].sd_mem +
		"<br>Sazonalidade: "+ maquina_selecionada[0].sazonalidade_mem +
		"<br>Tendência: "+ maquina_selecionada[0].tendencia_mem +
		"<br>Grau de autocor.:" + maquina_selecionada[0].grauautocor_mem;
	}else if(opcao_carac =="2"){
		maquina_selecionada = filtro_cpu.filter(function(i){return i.maquina == maquina;});
		texto ="Variabilidade: "+ maquina_selecionada[0].var_cpu +
		"<br>Desvio Padrão: "+ maquina_selecionada[0].sd_cpu +
		"<br>Sazonalidade: "+ maquina_selecionada[0].sazonalidade_cpu +
		"<br>Tendência: "+ maquina_selecionada[0].tendencia_cpu +
		"<br>Grau de autocor.:" + maquina_selecionada[0].grauautocor_cpu;
	}else if(opcao_carac =="3"){
		maquina_selecionada = filtro_mem.filter(function(i){return i.maquina == maquina;});
		texto ="Variabilidade: "+ maquina_selecionada[0].var_mem + " , " + maquina_selecionada[0].var_cpu +
		"<br>Desvio Padrão: "+ maquina_selecionada[0].sd_mem + ", " + maquina_selecionada[0].sd_cpu +
		"<br>Sazonalidade: "+ maquina_selecionada[0].sazonalidade_mem + ", " + maquina_selecionada[0].sazonalidade_cpu +
		"<br>Tendência: "+ maquina_selecionada[0].tendencia_mem + ", " + maquina_selecionada[0].tendencia_cpu +
		"<br>Grau de autocor.:" + maquina_selecionada[0].grauautocor_mem; ", " + maquina_selecionada[0].grauautocor_cpu;
	}
	document.getElementById('legenda').innerHTML = "<br><br><br><br><br>" + texto;
}

// function navegar_traces(){
	// console.log("Navegar entre os traces");
// }

// function classificar_aplicacoes(){
	// console.log("Classificar aplicacoes");
// }