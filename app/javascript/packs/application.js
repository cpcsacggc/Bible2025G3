// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import "bootstrap"
import "../stylesheet/application"
document.addEventListener("turbolinks:load", () => {
    $('[data-toggle="tooltip"]').tooltip()
    $('[data-toggle="popover"]').popover()

})

// app/javascript/packs/pagination.js (or application.js)
$(document).on('turbo:load ready', function () {
    $(document).on('click', '.sort_paginate_ajax .pagination a', function (e) {
        e.preventDefault();
        $.getScript(this.href);
    });
});