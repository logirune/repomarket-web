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
//= require jquery
//= require rails-ujs
//= require trix
//= require activestorage
//= require turbolinks
//= require foundation
//= require owl.carousel
//= require_tree .


function import_repository(repo_id)
{
    location.replace('/account/products/import/'+repo_id);
}

function delete_repository(product_id)
{
    if(confirm('Are you sure you want to delete this product?'))
    {
        $.ajax({
            url: '/account/products/'+product_id,
            type: 'DELETE',
        });
    }
}

$(document).on('turbolinks:load', function() {

    $(document).foundation();
    $(window).trigger('load.zf.sticky');

    // LISTES DEROULANTES DYNAMIQUES
    $('#product_language_id').change(function(){
        var language_id = this.value
        if(language_id != "undefined" && language_id != 0)
        {
            $.ajax({
                url : "/account/products/list_frameworks/"+language_id,
            })
        }
    });



});
