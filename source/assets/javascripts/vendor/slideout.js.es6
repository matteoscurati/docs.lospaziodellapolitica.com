import Slideout from 'slideout';

const slideout = new Slideout({
  'panel': document.getElementById('panel'),
  'menu': document.getElementById('menu'),
  'padding': 256,
  'tolerance': 70
});

document.querySelector('.toggle-menu').addEventListener('click', function() {
  slideout.toggle();
});

slideout.on('open', function() {
  $('.toggle-menu').addClass('is-opened');
});

slideout.on('close', () => {
  $('.toggle-menu').removeClass('is-opened');
});
