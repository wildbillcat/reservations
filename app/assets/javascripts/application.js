//= require jquery
//= require jquery_ujs
//= require jquery.ui.datepicker
//= require jquery.sticky
//= require jquery.dotdotdot-1.5.1
//= require cocoon
//= require autocomplete-rails
//= require dataTables/jquery.dataTables
//= require _dataTables_numhtml_sort
//= require _dataTables_numhtml_detect
//= require dataTables/jquery.dataTables.bootstrap
//= require bootstrap-transition
//= require bootstrap-alert
//= require bootstrap-button
//= require bootstrap-collapse
//= require bootstrap-dropdown
//= require bootstrap-modal
//= require bootstrap-scrollspy
//= require bootstrap-tab
//= require bootstrap-tooltip
//= require bootstrap-popover
//= require _variables
//= require select2
//= require _select2_app
//= require _datatables_app
//= require _bootstrap_app
//= require _datepicker_app
//= require _functions
//= require _global
//= require_self

$(document).ready(function() {

  $('#checkout_button').click(function() {
    var flag = validate_checkout();
    confirm_checkinout(flag);
    return false;
  });

  $('#checkin_button').click(function() {
    var flag = validate_checkin();
    confirm_checkinout(flag);
    return false;
  });

// For fading out flash notices
  $(".alert .close").click( function() {
       $(this).parent().addClass("fade");
  });

// make the sidebar follow you down the page
  $("#sidebarbottom").sticky({topSpacing: 50, bottomSpacing: 200});

// perform truncate, which is also defined outside of document ready
// it needs to be both places due to a webkit bug not loading named
// JS functions in (document).ready() until AFTER displaying all the things
  $(".caption_cat").dotdotdot({
    height: 126,
    after: ".more_info",
    watch: 'window'
    });

  $(".equipment_title").dotdotdot({
    height: 54, // must match .equipment_title height
    watch: 'window'
  });

  $(".equipment_title").each(function(){
    $(this).trigger("isTruncated", function( isTruncated ) {
      if ( isTruncated ) {
        $(this).children(".equipment_title_link").tooltip();
      }
    });
  });

  // Equipment Model - show - progress bar

  $('.progress .bar').each(function() {
      var me = $(this);
      var perc = me.attr("data-percentage");
      var current_perc = 0;

      var progress = setInterval(function() {
          if (current_perc>=perc) {
              clearInterval(progress);
          } else {
              current_perc = perc;
              me.css('width', (current_perc)+'%');
          }
      }, 100);
  });

  // fix sub nav on scroll
  var $win = $(window)
    , $nav = $('.subnav')
    , navTop = $('.subnav').length && $('.subnav').offset().top - 40
    , isFixed = 0
    , $hiddenName = $('.subnav .hide')

  processScroll()

  // hack sad times - holdover until rewrite for 2.1
  $nav.on('click', function () {
    if (!isFixed) setTimeout(function () {  $win.scrollTop($win.scrollTop() - 47) }, 10)
  })

  $win.on('scroll', processScroll)

  function processScroll() {
    var i, scrollTop = $win.scrollTop()
    if (scrollTop >= navTop && !isFixed) {
      isFixed = 1
      $nav.addClass('subnav-fixed')
      $hiddenName.removeClass('hide')
      if (!$('.subnav li').hasClass('active')) {
        $('.subnav li:eq(1)').addClass('active')
      }
    } else if (scrollTop <= navTop && isFixed) {
      isFixed = 0
      $nav.removeClass('subnav-fixed')
      $hiddenName.addClass('hide')
      $('.subnav li').removeClass('active')
    }
  }

  $('#modal').click(function() {
    $('#userModal div.modal-body').load(new_user, {from_cart : true }); // new_user defined in variables.js.erb
  });

});
