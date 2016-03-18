// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

MyMenuApp.MyMenu = function() {
	
};

MyMenuApp.MyMenu.renderLocalStorage = function(){
	var images = JSON.parse(localStorage.getItem("images"));
	var origins = JSON.parse(localStorage.getItem("origins"));
	var titles = JSON.parse(localStorage.getItem("titles"));
	var minutes = JSON.parse(localStorage.getItem("minutes"));
	var servings = JSON.parse(localStorage.getItem("servings"));
	
	if (images != null){
		$.each(images,function(i,img){
			$($('.js-image')[i]).attr("src",img)
		})

		$.each(origins,function(i,org){
			$($('.js-origin')[i]).attr("href",org)
		})

		$.each(titles,function(i,title){
			$($('.js-title')[i]).text(title);
		})

		$.each(minutes,function(i,min){
			$($('.js-minutes')[i]).text(min);
		})

		$.each(servings,function(i,serv){
			$($('.js-servings')[i]).text(serv);
		})
	}
};

$(document).on("ready",function(){
	
	MyMenuApp.MyMenu.renderLocalStorage();

	$('.js-go').on('click',function(){
		$('.js-time-limit').addClass('is-active');
	});

	$('.modal-background, .modal-close').on('click',function(){
		$('.modal').removeClass('is-active');
	});

	$('.js-time').on('click',function(){
		$('.modal').removeClass('is-active');
		$('.js-howmany-modal').addClass('is-active');
	});

	$('.js-howmany-modal').on('click',function(){
		$('.modal').removeClass('is-active');
		$('.js-diet-restrictions').addClass('is-active');
	});

	$('.js-save').on('click',function(){
		var counter = [0,1,2,3,4];
		console.log("Saving weekly menu..")
		var images = [];
		var origins = [];
		var titles = [];
		var minutes = [];
		var servings = [];
		$.each(counter,function(i,x){
			images.push($($('.js-image')[i]).attr("src"));
			origins.push($($('.js-origin')[i]).attr("href"));
			titles.push($($('.js-title')[i]).text());
			minutes.push($($('.js-minutes')[i]).text());
			servings.push($($('.js-servings')[i]).text());
		});

		localStorage.setItem("images",JSON.stringify(images));
		localStorage.setItem("origins",JSON.stringify(origins));
		localStorage.setItem("titles",JSON.stringify(titles));
		localStorage.setItem("minutes",JSON.stringify(minutes));
		localStorage.setItem("servings",JSON.stringify(servings));
	});

});
