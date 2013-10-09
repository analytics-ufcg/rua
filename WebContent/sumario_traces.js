function getMenuOptionSum(selection) {
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
}

function sumario(){
	opcao = 3;
	var myList = d3.selectAll("#myListSumario");

	clearImages();
	myList.selectAll("option").data(filtro_cpu).enter().append("option")
	.attr("value",function(d){return d.maquina;})
	.attr("label",function(d){return d.maquina;})
	.text(function(d){return d.maquina;});
	
}

function getAplicacao(){
    var img;
    var svg;
	img = document.createElement('img');

	img.src = "data/graficos/sumario/" + maquina + ".csv.png";

    img.style.width  = 860  + "px";
    img.style.height = 530 + "px";
	img.style.position = "absolute";
	img.style.top = "70px";
	img.style.left = "320px";
    target = document.getElementById("noticia");
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

	document.getElementById('legenda').innerHTML = "<br><br>" + texto;
}