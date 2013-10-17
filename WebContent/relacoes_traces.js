var dataset = [];
var relacao;
var opcao_caract;

// function getMenuOptionRelacoes(selection) {
	// //limpa containers
	// cleanContainers();
    // relacao = selection.options[selection.selectedIndex].value;
	
	// clearImages();
	// getRelacoes();
	// return relacao;
// }

// function cleanContainers(){
	// d3.selectAll("svg")
    // .remove();
// }

function relacoes_traces(){
	// var myList = d3.selectAll("#myListRelacoes");

	// clearImages();
	// myList.selectAll("option").data(relacoes).enter().append("option")
	// .attr("value",function(d){return d.relacao;})
	// .attr("label",function(d){return d.relacao;})
	// .text(function(d){return d.relacao;});
}

function selecionar_relacoes(opcao){ //adicionar o id da opcao aqui depois
	// var myList = d3.selectAll("#myListFiltro");
	// opcao_carac = opcao;
	
	// //Atualizar dropdown a cada selecao de variavel
	// if(opcao == "1"){
		// myList = d3.selectAll("#myListFiltro");
		// myList.selectAll("option").remove();
		// clearImages()
		// myList.selectAll("option").data(filtro_mem).enter().append("option")
		// .attr("value",function(d){return d.maquina;})
		// .attr("label",function(d){return d.maquina;})
		// .text(function(d){return d.maquina;});
	// }else if(opcao == "2"){
		// myList = d3.selectAll("#myListFiltro");
		// myList.selectAll("option").remove();
		// clearImages()
		// myList.selectAll("option").data(filtro_cpu).enter().append("option")
		// .attr("value",function(d){return d.maquina;})
		// .attr("label",function(d){return d.maquina;})
		// .text(function(d){return d.maquina;});
	// }else if(opcao == "3"){
		
		// myList = d3.selectAll("#myListFiltro");
		// myList.selectAll("option").remove();
		// clearImages()
		// myList.selectAll("option").data(filtro_cpu).enter().append("option")
		// .attr("value",function(d){return d.maquina;})
		// .attr("label",function(d){return d.maquina;})
		// .text(function(d){return d.maquina;});
	// }	
}

// function getRelacoes(){
    // var img;
    // var svg;
	// img = document.createElement('img');

	// img.src = "data/graficos/relacoes/" + relacao + ".png";

    // img.style.width  = 840  + "px";
    // img.style.height = 550 + "px";
	// img.style.position = "absolute";
	// img.style.top = "70px";
	// img.style.left = "350px";
    // target = document.getElementById("noticia");
    // target.appendChild(img);
	// changeTextRelacoes();
// }

// function clearImages(){
	// if(document.getElementById("img") != null){
		// document.getElementById("img").remove();
	// }
// }

// function changeTextRelacoes(){
	// var relacao_sel, texto;
	// relacao_sel = relacoes.filter(function(i){return i.relacao == relacao;});

	// texto = "<br><br>Na relação selecionada " + relacao + " o uso de memória <br> e CPU ao longo do tempo é inversamente proporcional.<br>" +
		// "No gráfico podemos observar que ao longo do tempo <br> enquanto o uso de memória cresce o de CPU decresce,<br> na tabela abaixo podemos notar a influência desse com-<br>portamento nos valores observados.<br>" +
		// "<br><br><table class='detalhes'><tr bgcolor='#FF0000'><td><b>Característica</b></td><td><b>Valor</b></td></tr>"+
		// "<tr><td><i>Predominância</i></td><td>"+relacao_sel[0].classe+"</td></tr>" +
		// "<tr><td><i>Proporção CPU</i></td><td>"+relacao_sel[0].cpu +"</td></tr>" +
		// "<tr><td><i>Proporção memória</i></td><td>"+relacao_sel[0].mem+"</td></tr>" +
				// "<tr><td><i>Tendência</i></td><td>"+relacao_sel[0].tendencia+"</td></tr></table>" +
		// "<br><table class='detalhes'><tr bgcolor='#FF0000'><td><b>Característica</b></td><td><b>Memória</b></td><td><b>CPU</b></td></tr>"+
		// "<tr><td><i>Variabilidade</i></td><td>"+relacao_sel[0].variancia+"<td></tr>" +
		// "<tr><td><i>Desvio Padrão</i></td><td>"+relacao_sel[0].desviopadrao+"<td></tr>" +
		// "<tr><td><i>Max autocorrelação</i></td><td>"+relacao_sel[0].max_autocorrelacao + "<td></tr>" +
		// "<tr><td><i>Min autocorrelação</i></td><td>"+relacao_sel[0].min_autocorrelacao + "<td></tr>" +
		// "<tr><td><i>Grau de autocorrelação</i></td><td>"+relacao_sel[0].grau_autocorrelacao + "<td></tr>" +
		// "</table>";

	// document.getElementById('legenda').innerHTML = "<br><br>" + texto;
// }