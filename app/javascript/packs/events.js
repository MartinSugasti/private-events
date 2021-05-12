$(document).on('turbolinks:load', function () {
  $('#hello-title').on('mouseover', function () {
    $('#hello-title').toggleClass('mt-5');
  });
});
