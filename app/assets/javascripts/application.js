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
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require activestorage
//= require turbolinks
//= require_tree .

// Image Uploader
$(document).on('turbolinks:load', function () {
  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();

      reader.onload = function (e) {
        $('#img_prev').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }

  $("#post_img").change(function () {
    $('#img_prev').removeClass('hidden');
    $('.present_img').remove();
    readURL(this);
  });
});

// 下スクロールで隠れて上スクロールで表示されるheader
var startPos = 0, winScrollTop = 0;
$(window).on('scroll', function () {
  winScrollTop = $(this).scrollTop();
  if (winScrollTop >= startPos) {
    if (winScrollTop >= 200) {
      $('.site_header').addClass('hide');
    }
  } else {
    $('.site_header').removeClass('hide');
  }
  startPos = winScrollTop;
});
