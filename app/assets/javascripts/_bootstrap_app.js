$(document).ready(function() {
// Tooltips
  $(".btn#modal").tooltip();
  $(".not-qualified-icon").tooltip();
  $(".not-qualified-icon-em").tooltip();

  // Popovers
  $('.associated_em_box img').popover({ placement: 'bottom' });
  $("#my_reservations .dropdown-menu a").popover({ placement: 'bottom' });
  $("#my_equipment .dropdown-menu a").popover({ placement: 'bottom' });
});