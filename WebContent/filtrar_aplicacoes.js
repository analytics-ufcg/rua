var dataset = [];
var filtro_mem = [];
var filtro_cpu = [];
var maquina;
var opcao_caract;

function getMenuOptionFiltro(selection) {
	//limpa containers
	cleanContainers();
    maquina = selection.options[selection.selectedIndex].value;
	
	clearImages()
	getAplicacaoFiltro();
	return maquina;
}

function cleanContainers(){
	d3.selectAll("svg")
    .remove();
}

function filtrar_aplicacoes(opcao){ //adicionar o id da opcao aqui depois
	var myList = d3.selectAll("#myListFiltro");
	opcao_carac = opcao;
	
	//Atualizar dropdown a cada selecao de variavel
	if(opcao == "1"){
		myList = d3.selectAll("#myListFiltro");
		myList.selectAll("option").remove();
		clearImages()
		myList.selectAll("option").data(filtro_mem).enter().append("option")
		.attr("value",function(d){return d.maquina;})
		.attr("label",function(d){return d.maquina;})
		.text(function(d){return d.maquina;});
	}else if(opcao == "2"){
		myList = d3.selectAll("#myListFiltro");
		myList.selectAll("option").remove();
		clearImages()
		myList.selectAll("option").data(filtro_cpu).enter().append("option")
		.attr("value",function(d){return d.maquina;})
		.attr("label",function(d){return d.maquina;})
		.text(function(d){return d.maquina;});
	}else if(opcao == "3"){
		
		myList = d3.selectAll("#myListFiltro");
		myList.selectAll("option").remove();
		clearImages()
		myList.selectAll("option").data(filtro_cpu).enter().append("option")
		.attr("value",function(d){return d.maquina;})
		.attr("label",function(d){return d.maquina;})
		.text(function(d){return d.maquina;});
	}
	
}

function getAplicacaoFiltro(){
    var img;
    var svg;
	img = document.createElement('img');
    
	if(opcao_carac == "1"){
		img.src = "data/graficos/filtro/mem/"+ maquina + ".csv.png";
	}else if(opcao_carac == "2"){
		img.src = "data/graficos/filtro/cpu/" + maquina + ".csv.png";
	}else if(opcao_carac == "3"){
		img.src = "data/graficos/filtro/all/" + maquina + ".csv.png";
	}
    img.style.width  = 550  + "px";
    img.style.height = 550 + "px";
	img.style.position = "absolute";
	img.style.top = "120px";
	img.style.left = "320px";
    target = document.getElementById("caracteristicas");
    target.appendChild(img);
	changeTextFiltro();
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

function changeTextFiltro(){
	var maquina_selecionada,texto;
	if(opcao_carac == "1"){
		maquina_selecionada = filtro_mem.filter(function(i){return i.maquina == maquina;});
		texto = "<table class='detalhes'><tr bgcolor=#FF0000><td><b>Característica</b></td><td><b>Valor</b></td></tr>"+
		"<tr><td><i>Predominância</i></td><td>"+maquina_selecionada[0].classe+"</td></tr>" +
		"<tr><td><i>Proporção CPU</i></td><td>"+maquina_selecionada[0].cpu +"</td></tr>" +
		"<tr><td><i>Proporção memória</i></td><td>"+maquina_selecionada[0].mem+"</td></tr>" +
		"<tr><td><i>Tendência</i></td><td>"+maquina_selecionada[0].tendencia+"</td></tr></table>" +
		"<br><table class='detalhes'><tr bgcolor='#FF0000'><td><b>Característica</b></td><td><b>Memória</b></td></tr>"+
		"<tr><td><i>Variabilidade</i></td><td>"+maquina_selecionada[0].variancia+"</td></tr>" +
		"<tr><td><i>Desvio Padrão</i></td><td>"+maquina_selecionada[0].desviopadrao+"</td></tr>" +
		"<tr><td><i>Max autocorrelação</i></td><td>"+maquina_selecionada[0].max_autocorrelacao + "</td></tr>" +
		"<tr><td><i>Min autocorrelação</i></td><td>"+maquina_selecionada[0].min_autocorrelacao + "</td></tr>" +
		"<tr><td><i>Grau de autocorrelação</i></td><td>"+maquina_selecionada[0].grau_autocorrelacao + "</td></tr>" +
		"</table>";
	}else if(opcao_carac =="2"){
		maquina_selecionada = filtro_cpu.filter(function(i){return i.maquina == maquina;});
		texto = "<table class='detalhes'><tr bgcolor=#FF0000><td><b>Característica</b></td><td><b>Valor</b></td></tr>"+
		"<tr><td><i>Predominância</i></td><td>"+maquina_selecionada[0].classe+"</td></tr>" +
		"<tr><td><i>Proporção CPU</i></td><td>"+maquina_selecionada[0].cpu +"</td></tr>" +
		"<tr><td><i>Proporção memória</i></td><td>"+maquina_selecionada[0].mem+"</td></tr>" +
		"<tr><td><i>Tendência</i></td><td>"+maquina_selecionada[0].tendencia+"</td></tr></table>" +
		"<br><table class='detalhes'><tr bgcolor='#FF0000'><td><b>Característica</b></td><td><b>CPU</b></td></tr>"+
		"<tr><td><i>Variabilidade</i></td><td>"+maquina_selecionada[0].variancia+"</td></tr>" +
		"<tr><td><i>Desvio Padrão</i></td><td>"+maquina_selecionada[0].desviopadrao+"</td></tr>" +
		"<tr><td><i>Max autocorrelação</i></td><td>"+maquina_selecionada[0].max_autocorrelacao + "</td></tr>" +
		"<tr><td><i>Min autocorrelação</i></td><td>"+maquina_selecionada[0].min_autocorrelacao + "</td></tr>" +
		"<tr><td><i>Grau de autocorrelação</i></td><td>"+maquina_selecionada[0].grau_autocorrelacao + "</td></tr>" +
		"</table>";
	}else if(opcao_carac =="3"){
		maquina_mem = filtro_mem.filter(function(i){return i.maquina == maquina;});
		maquina_cpu = filtro_cpu.filter(function(i){return i.maquina == maquina;});
		
		texto = "<table class='detalhes'><tr bgcolor='#FF0000'><td><b>Característica</b></td><td><b>Valor</b></td></tr>"+
		"<tr><td><i>Predominância</i></td><td>"+maquina_mem[0].classe+"</td></tr>" +
		"<tr><td><i>Proporção CPU</i></td><td>"+maquina_mem[0].cpu +"</td></tr>" +
		"<tr><td><i>Proporção memória</i></td><td>"+maquina_mem[0].mem+"</td></tr>" +
				"<tr><td><i>Tendência</i></td><td>"+maquina_mem[0].tendencia+"</td></tr></table>" +
		"<br><table class='detalhes'><tr bgcolor='#FF0000'><td><b>Característica</b></td><td><b>Memória</b></td><td><b>CPU</b></td></tr>"+
		"<tr><td><i>Variabilidade</i></td><td>"+maquina_mem[0].variancia+"<td>"+maquina_cpu[0].variancia+"</td></tr>" +
		"<tr><td><i>Desvio Padrão</i></td><td>"+maquina_mem[0].desviopadrao+"<td>"+maquina_cpu[0].desviopadrao+"</td></tr>" +
		"<tr><td><i>Max autocorrelação</i></td><td>"+maquina_mem[0].max_autocorrelacao + "<td>"+maquina_cpu[0].max_autocorrelacao+"</td></tr>" +
		"<tr><td><i>Min autocorrelação</i></td><td>"+maquina_mem[0].min_autocorrelacao + "<td>"+maquina_cpu[0].min_autocorrelacao+"</td></tr>" +
		"<tr><td><i>Grau de autocorrelação</i></td><td>"+maquina_mem[0].grau_autocorrelacao + "<td>"+maquina_cpu[0].grau_autocorrelacao+"</td></tr>" +
		"</table>";
	}
	document.getElementById('legenda').innerHTML = "<br><br>" + texto;
}
