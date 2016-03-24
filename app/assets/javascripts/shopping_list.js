// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.




$(document).on("ready",function(){
	$('p.js-sl-item').on('click', function(){
		$(this).toggleClass('strikethrough');
	});

	$('.js-submit').on('click',function(){
		var sl_items = $('.js-sl-item');
		var sl_items_needed = {};
		$.each(sl_items,function(i,v){
			if (!$(v).hasClass('strikethrough')){
				var heading = $(v).parent().children('.js-sl-heading').text()
				if (sl_items_needed[heading]){
				  sl_items_needed[heading].push($(v).text())
				} else {
				  sl_items_needed[heading] = [$(v).text()]
				}
			}
		});	
		$("input[name='shopping_list']").attr("value",JSON.stringify(sl_items_needed))
		console.log(sl_items_needed);
	});
});