// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

MyMenuApp.Recipe = function(id,image_url,source_url,title,cook_time,servings){
	this.id = id;
	this.image_url = image_url;
	this.source_url = source_url;
	this.title = title;
	this.cook_time = cook_time;
	this.servings = servings;
};

$(document).on("ready",function(){
	$('.method li').on('click', function(){
		$(this).toggleClass('strikethrough');
	});
});