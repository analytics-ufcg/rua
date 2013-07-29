var dataset = [];

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
	
	
}