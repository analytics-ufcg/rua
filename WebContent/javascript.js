// JavaScript Document
var filtro_cpu = [];
var filtro_mem = [];
var grupos = [];
var relacoes =[];
var noticia;	
var hash = window.location.hash;

$(function(){
	$('#conteudo').hide();
	var noticia;	
	var hash = window.location.hash;
	if (hash !=''){
		noticia = $(hash).html();
		$('.abas li a[href="' + hash + '"]').parent().addClass('ativo');		
	} else {
		noticia = $('#conteudo div:first-child').html();			
		$('.abas li:first-child').addClass('ativo');
	}
	$('#noticia').append('<div>' + noticia + '</div>').find('div').slideDown();
	$('.abas li a').click(function(){
		$('.abas li').removeClass('ativo');
		$(this).parent().addClass('ativo');
		var ancora = $(this).attr('href');
		var nome = ancora.substr(1, ancora.length);
		noticia = $('#conteudo div[id="' + nome + '"]').html();
		$('#noticia').empty();
		$('#noticia').append('<div>' + noticia + '</div>').find('div').slideDown();
	return false();
	})
	
})

function loadData(){
	d3.csv("data/sumario_cpu.csv", function(data){
		filtro_cpu = data;
	});

	d3.csv("data/sumario_mem.csv", function(data){
		filtro_mem = data;
	});
	
	d3.csv("data/agrupamento_traces.csv", function(data){
		grupos = data;
	});
	
	d3.csv("data/sumario_relacoes.csv", function(data){
		relacoes = data;
	});
}

