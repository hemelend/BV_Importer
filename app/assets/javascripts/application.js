// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
//= require twitter/bootstrap
// require turbolinks
//= require_tree .

transparent = true;
$(document).ready(function () {
    $('.reset_pass').on('click', function(){
        $('#modal-login').modal('hide');
    });
    $('.table').dataTable({"order": []});
});
$(document).scroll(function() {
    if( $(this).scrollTop() > 50 ) {
        if(transparent) {
            transparent = false;
            $('.navbar-fixed-top').removeClass('navbar-prespectec');
            $('.navbar-fixed-top').addClass('navbar-inverse');
        }
    } else {
        if( !transparent ) {
            transparent = true;
            $('.navbar-fixed-top').addClass('navbar-prespectec');
            $('.navbar-fixed-top').removeClass('navbar-inverse');
        }
    }
});