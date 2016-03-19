// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

MyMenuApp.MyMenu = function(cook_time, servings, classifications) {
	this.cook_time = cook_time;
	this.servings = servings;
	this.classifications = [2];
	this.recipes = [];
};

MyMenuApp.MyMenu.prototype.setCookTime = function(time){
	this.cook_time = time;
};

MyMenuApp.MyMenu.prototype.setServings = function(servings){
	this.servings = servings;
};

MyMenuApp.MyMenu.prototype.getClassifications = function(){
	var classifications = [];
	$.each($('.js-diet'),function(i,c){
		console.log(c)
		if ($(c).hasClass('selected')) {
			classifications.push($(c).data('type-id'));
		}
	});
	this.classifications = classifications;
};

MyMenuApp.MyMenu.prototype.exchange = function(position){
	var recipeBackups = JSON.parse(localStorage.getItem("recipeBackups"));
	var new_recipe = recipeBackups[0];
	this.renderRecipe(position,new_recipe);
	recipeBackups.shift();
	localStorage.setItem("recipeBackups",JSON.stringify(recipeBackups));


};

MyMenuApp.MyMenu.prototype.renderRecipe = function(i,recipe){
	$($('.js-recipe')[i]).data('type-id',recipe.id);
	$($('.js-recipe-link')[i]).attr("href","recipes/"+recipe.id);
	$($('.js-image')[i]).attr("src",recipe.image_url);
	$($('.js-origin')[i]).attr("href",recipe.source_url);
	$($('.js-title')[i]).text(recipe.title);
	$($('.js-minutes')[i]).text(recipe.cook_time);
	$($('.js-servings')[i]).text(recipe.servings);
};

MyMenuApp.MyMenu.prototype.render = function(){
	console.log("Rendering menus: "+ this.cook_time + " minutes, " + this.servings + " serves, classifications "+ this.classifications);

	var self = this; //so we have THIS this, not the function this once we get to ajax

	$.ajax({
		type:'POST',
		url: "/",
		data: {cook_time: this.cook_time, servings: this.servings, classifications: this.classifications},
		success: function (response) {	
			self.info = response;
			console.log("Recipes:")
			console.log(self.info);

			var recipes = [];

			$.each(self.info,function(i,recipe){

				if (i<5){
					my_menu.renderRecipe(i,recipe);
				} else {
					recipes.push(recipe);
				}

				localStorage.setItem("recipeBackups",JSON.stringify(recipes));
			});		
			MyMenuApp.MyMenu.saveAllToLocal();
		},
		error: function(error){
			console.log("There was an error.");
			console.log(error);
		}
	});
};

MyMenuApp.MyMenu.renderLocalStorage = function(){
	var recipes = JSON.parse(localStorage.getItem("savedRecipes"));

	if (recipes != null){
		$.each(recipes,function(i,recipe){
			$($('.js-recipe')[i]).data('type-id',recipe.id);
			$($('.js-recipe-link')[i]).attr("href","recipes/"+recipe.id);
			$($('.js-image')[i]).attr("src",recipe.image_url);
			$($('.js-origin')[i]).attr("href",recipe.source_url);
			$($('.js-title')[i]).text(recipe.title);
			$($('.js-minutes')[i]).text(recipe.cook_time);
			$($('.js-servings')[i]).text(recipe.servings);
		})

	}
};

MyMenuApp.MyMenu.saveAllToLocal = function(){
	var recipes = [];
	console.log("Saving weekly menu..")

	$.each([1,2,3,4,5],function(i,x){
		r = new MyMenuApp.Recipe(
				$($('.js-recipe')[i]).data('type-id'),
				$($('.js-image')[i]).attr("src"),
				$($('.js-origin')[i]).attr("href"),
				$($('.js-title')[i]).text(),
				$($('.js-minutes')[i]).text(),
				$($('.js-servings')[i]).text()
			);

		recipes.push(r);

	});

	localStorage.setItem("savedRecipes",JSON.stringify(recipes));

};

$(document).on("ready",function(){
	
	MyMenuApp.MyMenu.renderLocalStorage();
	var my_menu = new MyMenuApp.MyMenu(0,0,[]);

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

	$('.js-no-time').on('click',function(){	
		my_menu.setCookTime(45);
	});

	$('.js-some-time').on('click',function(){	
		my_menu.setCookTime(90);
	});

	$('.js-all-time').on('click',function(){	
		my_menu.setCookTime(120);
	});

	$('.js-howmany').on('click',function(){
		$('.modal').removeClass('is-active');
		$('.js-diet-restrictions').addClass('is-active');
	});

	$('.js-howmany-couple').on('click',function(){
		my_menu.setServings(3);
	});

	$('.js-howmany-crowd').on('click',function(){
		my_menu.setServings(5);
	});

	$('.js-howmany-army').on('click',function(){
		my_menu.setServings(10);
	});


	$('.js-diet').on('click',function(){
		$(this).toggleClass('selected');
	});

	$('.js-search').on('click',function(){
		my_menu.getClassifications();

		$('.modal').removeClass('is-active');
		console.log('calling AJAX'); 
		my_menu.render();
	});

	$('.js-save').on('click',function(){
		MyMenuApp.MyMenu.saveAllToLocal();
		
	});

	$('.js-exchange').on('click',function(){
		my_menu.exchange($(this).data('position-id'));
	});

});
