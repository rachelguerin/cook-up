// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

MyMenuApp.MyMenu = function(cook_time, servings, classifications) {
	this.cook_time = cook_time;
	this.servings = servings;
	this.classifications = classifications;
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

MyMenuApp.MyMenu.prototype.refillBackup = function(){
	var self = this; //so we have THIS this, not the function this once we get to ajax

	$.ajax({
		type:'GET',
		url: "/menus",
		data: {cook_time: this.cook_time, servings: this.servings, classifications: this.classifications},
		success: function (response) {	
			self.info = response;

			var recipes = [];

			$.each(self.info,function(i,recipe){
				recipes.push(recipe);
			});	
			localStorage.setItem("recipeBackups",JSON.stringify(recipes));	
		},
		error: function(error){
			console.log("There was an error.");
			console.log(error);
		}
	});
};

MyMenuApp.MyMenu.prototype.exchange = function(position){
	var recipeBackups = JSON.parse(localStorage.getItem("recipeBackups"));
	var new_recipe = recipeBackups[0];
	this.renderRecipe(position,new_recipe);
	recipeBackups.shift();
	if (recipeBackups.length == 0){
		this.refillBackup();
	}

	localStorage.setItem("recipeBackups",JSON.stringify(recipeBackups));
	MyMenuApp.MyMenu.setShoppingList();
	MyMenuApp.MyMenu.setRecipeCardHeight();

	$('.js-save').removeClass('is-disabled');

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
		type:'GET',
		url: "/menus",
		data: {cook_time: this.cook_time, servings: this.servings, classifications: this.classifications},
		success: function (response) {	
			self.info = response;
			console.log("Recipes:")
			console.log(self.info);

			var recipes = [];

			$.each(self.info,function(i,recipe){

				if (i<5){
					self.renderRecipe(i,recipe);
				} else {
					recipes.push(recipe);
				}
			
			});	
			localStorage.setItem("recipeBackups",JSON.stringify(recipes));	
			MyMenuApp.MyMenu.saveToLocal("1");
		},
		error: function(error){
			console.log("There was an error.");
			console.log(error);
		}
	});
};

MyMenuApp.MyMenu.setShoppingList = function(){
	var recipe_ids = [];
	console.log("Set shopping list..");

	$.each([1,2,3,4,5],function(i,x){
		recipe_ids.push($($('.js-recipe')[i]).data('type-id'));
	});

	$('.js-shopping').attr("href","/shopping_list/"+recipe_ids);
};

MyMenuApp.MyMenu.prototype.loadMenus = function(){
	$.each([1,2,3,4,5],function(i,x){
		var menu_created_at = localStorage.getItem("Menu"+x+"_created_at");
		if (menu_created_at != undefined){
			$($('.js-show-menu')[i]).text(x+"."+menu_created_at);
		}
	});	
	$('.js-save-menus p').text("");
};

MyMenuApp.MyMenu.prototype.renderLocalStorage = function(menu_id){
	var recipes = JSON.parse(localStorage.getItem(menu_id));

	if (recipes != null){
		//fadeout
		$('.js-image').addClass("fadeout");

		$.each(recipes,function(i,recipe){
			$($('.js-recipe')[i]).data('type-id',recipe.id);
			$($('.js-recipe-link')[i]).attr("href","recipes/"+recipe.id);
			$($('.js-image')[i]).attr("src",recipe.image_url);
			$($('.js-origin')[i]).attr("href",recipe.source_url);
			$($('.js-title')[i]).text(recipe.title);
			$($('.js-minutes')[i]).text(recipe.cook_time);
			$($('.js-servings')[i]).text(recipe.servings);
		})
		$('.js-image').delay(400).removeClass("fadeout");
		MyMenuApp.MyMenu.setShoppingList();

	} else {
		$('.js-save-menus p').text("No menu saved.")
		this.render();
	}
};

MyMenuApp.MyMenu.saveToLocal = function(menu_id){
	var recipes = [];
	var recipe_ids = [];
	console.log("Saving menu "+menu_id)

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
		recipe_ids.push(r.id);

	});

	var now = new Date;
	var now_print = now.toDateString()+" "+now.getHours()+":"+now.getMinutes();
	localStorage.setItem("Menu"+menu_id,JSON.stringify(recipes));
	localStorage.setItem("Menu"+menu_id+"_created_at",now_print);
	MyMenuApp.MyMenu.setShoppingList();
	$('.js-save-menus p').text("Menu "+menu_id+" saved.")
};

MyMenuApp.MyMenu.setRecipeCardHeight = function(){
	var maxHeight = 0
	$.each($('.js-recipe'),function(i,v){
		if ($(v).height() > maxHeight){
			maxHeight = $(v).height();
		}
	});

	$.each($('.js-recipe'),function(i,v){
		$(v).height(maxHeight);
	});

};


$(document).on("ready",function(){

	var my_menu = new MyMenuApp.MyMenu(0,0,[]);
	my_menu.renderLocalStorage("Menu1");
	MyMenuApp.MyMenu.setShoppingList();
	
	$('.js-go').on('click',function(){
		$('.js-time-limit').addClass('is-active');
		$('.js-save').removeClass('is-disabled');
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
		$(this).toggleClass('is-inverted');
	});

	$('.js-search').on('click',function(){
		my_menu.getClassifications();

		$('.modal').removeClass('is-active');
		console.log('calling AJAX'); 
		my_menu.render();
	});

	$('.js-save-menu').on('click',function(){
		var menu_id = $(this).data("menu-id")
		MyMenuApp.MyMenu.saveToLocal(menu_id);
		$(this).prev().text(menu_id+"."+localStorage.getItem("Menu"+menu_id+"_created_at"));
	});

	$('.js-show-menu').on('click',function(){
		my_menu.renderLocalStorage("Menu"+$(this).data("menu-id"));
	})

	$('.js-menu-manager').hover(function(){
		$('.js-save-menus').fadeIn();
		$('.js-menu-manager').toggleClass('is-outlined');
		my_menu.loadMenus();
	});

	$('.delete').on('click',function(){
		$('.js-save-menus').fadeOut();
	});

	$('.js-exchange').on('click',function(){
		$(this).parent().parent().parent().toggleClass('flipped');
		my_menu.exchange($(this).data('position-id'));
		
	});

	$('.js-recipe').hover(function(){
		$(this).find('.js-title').toggleClass('hilight');
	});


	// MyMenuApp.MyMenu.setRecipeCardHeight();

});
