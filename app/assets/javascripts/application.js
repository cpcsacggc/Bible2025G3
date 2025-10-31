$(function() {
   /*$(".sort_paginate_ajax").on("click", ".pagination a", function(){ */
    $(".sort_paginate_ajax th a, .sort_paginate_ajax .pagination a").on("click", function(){

        $.getScript(this.href);
        return false;
    });
});