// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on("ready",function(){
	$('.js-go').on('click',function(){
		$('.js-time-limit').addClass('is-active');
	});

	$('.modal-background, .modal-close').on('click',function(){
		$('.modal').removeClass('is-active');
	});
});
