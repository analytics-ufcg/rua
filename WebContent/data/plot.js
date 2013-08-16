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
	
	d3.csv("data/sumario_cpu.csv", function(data){
		filtro_cpu = data;
	});

	d3.csv("data/sumario_mem.csv", function(data){
		filtro_mem = data;
	});

}

function filtrar_aplicacoes(opcao){
	
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
		myList.selectAll("option").data(filtro_cpu).enter().append("option")
		.attr("value",function(d){return d.maquina;})
		.attr("label",function(d){return d.maquina;})
		.text(function(d){return d.maquina;});
	}
	
}

function getAplicacao(){
    var img;
    var svg;
	img = document.createElement('img');
    
	if(opcao_carac == "1"){
		img.src = "data/graficos/mem/memoria_" + maquina + ".png";
	}else if(opcao_carac == "2"){
		img.src = "data/graficos/cpu/cpu_" + maquina + ".png";
	}else if(opcao_carac == "3"){
		img.src = "data/graficos/all/cpu_memoria _" + maquina + ".png";
	}
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
		texto = "<b>Predominância: </b> " + maquina_selecionada[0].classe +
		"<br><br><b>Proporção CPU: </b>" + maquina_selecionada[0].cpu + 
		"<br><b>Proporção memória: </b> "  + maquina_selecionada[0].mem +
		"<br><b>Variabilidade: </b> "+ maquina_selecionada[0].variancia +
		"<br><b>Desvio Padrão: </b> "+ maquina_selecionada[0].desviopadrao +
		"<br><b>Tendência: </b> "+ maquina_selecionada[0].tendencia +
		"<br><b>Max autocorrelação: </b> "+ maquina_selecionada[0].max_autocorrelacao +
		"<br><b>Min autocorrelação</b>: "+ maquina_selecionada[0].min_autocorrelacao +
		"<br><b>Grau de autocorrelação</b>: " + maquina_selecionada[0].grau_autocorrelacao;
	}else if(opcao_carac =="2"){
		maquina_selecionada = filtro_cpu.filter(function(i){return i.maquina == maquina;});
		texto = "<b>Predominância: </b> " + maquina_selecionada[0].classe +
		"<br><br><b>Proporção CPU: </b>" + maquina_selecionada[0].cpu + 
		"<br><b>Proporção memória: </b> "  + maquina_selecionada[0].mem +
		"<br><b>Variabilidade: </b> "+ maquina_selecionada[0].variancia +
		"<br><b>Desvio Padrão: </b> "+ maquina_selecionada[0].desviopadrao +
		"<br><b>Tendência: </b> "+ maquina_selecionada[0].tendencia +
		"<br><b>Max autocorrelação: </b> "+ maquina_selecionada[0].max_autocorrelacao +
		"<br><b>Min autocorrelação</b>: "+ maquina_selecionada[0].min_autocorrelacao +
		"<br><b>Grau de autocorrelação</b>: " + maquina_selecionada[0].grau_autocorrelacao;
	}else if(opcao_carac =="3"){
		maquina_mem = filtro_mem.filter(function(i){return i.maquina == maquina;});
		maquina_cpu = filtro_cpu.filter(function(i){return i.maquina == maquina;});
		
		texto = "<b>Predominância: </b> " + maquina_mem[0].classe +
		"<br><br><b>Proporção CPU: </b>" + maquina_mem[0].cpu + 
		"<br><b>Proporção memória: </b> "  + maquina_mem[0].mem +
		"<br><b>Variabilidade: </b><br> "+ maquina_mem[0].variancia + " Mem. e " + maquina_cpu[0].variancia + " CPU"+
		"<br><b>Desvio Padrão: </b><br> "+ maquina_mem[0].desviopadrao +" Mem. e " + maquina_cpu[0].desviopadrao + " CPU"+
		"<br><b>Tendência: </b><br>"+ maquina_mem[0].tendencia + " Mem. e " + maquina_cpu[0].tendencia + " CPU"+
		"<br><b>Max autocorrelação: </b><br> "+ maquina_mem[0].max_autocorrelacao+ " Mem. e " + maquina_cpu[0].max_autocorrelacao + " CPU"+
		"<br><b>Min autocorrelação</b>: <br>"+ maquina_mem[0].min_autocorrelacao+ " Mem. e " + maquina_cpu[0].min_autocorrelacao + " CPU"+
		"<br><b>Grau de autocorrelação</b>: <br>" + maquina_mem[0].grau_autocorrelacao + " Mem. e " + maquina_cpu[0].variancia + " CPU";
	}
	document.getElementById('legenda').innerHTML = "<br><br>" + texto;
}

// function navegar_traces(){
	// console.log("Navegar entre os traces");
// }

// function classificar_aplicacoes(){
	// console.log("Classificar aplicacoes");
// }
