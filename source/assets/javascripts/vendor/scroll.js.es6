$(document).ready(() => {
  $("#scroll").click(() => {
    $('html, body').animate({
        scrollTop: $("#qa").offset().top
    }, 2000);
  });
});
