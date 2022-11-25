// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

var $ham_dom = document.getElementById("ham-btn");
$ham_dom.addEventListener('click', function() {
    var $menu_dom = document.getElementById("menus-ul");
    if(document.defaultView.getComputedStyle($menu_dom, '').display === "none"){
        $menu_dom.style.display = "block"
    } else {
        $menu_dom.style.display = "none"
    }
});
