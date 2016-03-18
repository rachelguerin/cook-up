if (window.MyMenuApp === undefined) {
	window.MyMenuApp = {};
}

MyMenuApp.init = function(){
	// 3rd party setup code here
	console.log("My Menu App ONLINE!");
}

$(document).on("ready",function(){
	MyMenuApp.init();
});