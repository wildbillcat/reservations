// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery.sticky
//= require jquery.dotdotdot-1.5.1
//= require cocoon
//= require autocomplete-rails
//= require dataTables/jquery.dataTables
//= require dataTables_numhtml_sort.js
//= require dataTables_numhtml_detect.js
//= require dataTables/jquery.dataTables.bootstrap
//= require bootstrap
//= require_self

  function truncate() {
	  $(".caption_cat").dotdotdot({
		  height: 126,
		  after: ".more_info",
		  watch: 'window',
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
	};

$(document).ready(function() {
// For DataTables and Bootstrap
	$('.datatable').dataTable({
	  "sDom": "<'row'<'span4'l><'span5'f>r>t<'row'<'span3'i><'span6'p>>",
	  "sPaginationType": "bootstrap",
		"sScrollX": "100%",
		"aoColumnDefs": [
		      { "bSortable": false, "aTargets": [ "no_sort" ] }
		    ]
	});
	
	$('.history_table').dataTable({
	  "sDom": "<'row'<l><f>r>t<'row'<'span3'i><p>>",
		"bLengthChange": false,
	  "sPaginationType": "bootstrap",
		"aoColumnDefs": [
		      { "bSortable": false, "aTargets": [ "no_sort" ] }
		    ]
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
		watch: 'window',
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

	$(".btn#modal").tooltip();
	
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

	$('.associated_em_box img').popover({ placement: 'bottom' });

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
    //$('#userModal div.modal-body').load(new_user_path.value, {from_cart : true }); // new_user_path defined in _cart_dates
    $('#userModal div.modal-body').load('/users/new #content', {from_cart : true }); // new_user_path defined in _cart_dates
  });

});
// to disable selection of dates in the past with datepicker
$.datepicker.setDefaults({
   minDate: new Date()
});

// auto-submit cart dates #only-cart-dates
//  $(document).on('change', '.submitchange', function() {
//    $.ajax({ // we can probably use .get() instead of .ajax(), but this is more flexible going forward since it's essentially the same
//      type: "GET",
//      url: update_cart_path.value, // defined in _cart_dates in hidden field
//      data: { 'reserver_id': reserver_id.value,
//              'start_date_cart': cart_start_date_cart.value,
//              'due_date_cart': cart_due_date_cart.value },
//     dataType: "script"
//    });
//  });

$(".btn.btn-primary").bind('ajax:success', function(){
    alert("Test!");
  });
  
// auto-submit cart dates #only-cart-reserver
//  $(document).on('blur', '.submittable', function() {  // we need a different watch function than 'blur', which seems to break frequently
//    $.ajax({ // we can probably use .get() instead of .ajax(), but this is more flexible going forward since it's essentially the same
//      type: "GET",
//      url: update_cart_path.value, // defined in _cart_dates in hidden field
//      data: { 'reserver_id': reserver_id.value,
//              'start_date_cart': cart_start_date_cart.value,
//              'due_date_cart': cart_due_date_cart.value },
//      dataType: "script"
//    });
//  });
  
// old code to submit cart dates #only-dates and #only-reserver
//  $(document).on('change', '.submitchange', function() {
//      $('#cart_dates').load( update_cart_path.value, // defined in _cart_dates in hidden field
//// params need to be passed
//        { 'reserver_id': reserver_id.value,
//          'start_date_cart': cart_start_date_cart.value,
//          'due_date_cart': cart_due_date_cart.value }
//      );
//  });
//// auto-submit cart dates #only-cart-reserver
//  $(document).on('blur', '.submittable', function() { 
//      $('#cart_dates').load( update_cart_path.value, 
//// params need to be passed
//        { 'reserver_id': reserver_id.value,
//          'start_date_cart': cart_start_date_cart.value,
//          'due_date_cart': cart_due_date_cart.value }
//      );
//  });

// general submit on change class
  $(document).on('change', '.autosubmitme', function() {
    $(this).parents('form:first').submit();
  });

// general submit on click class
  $(document).on('click', '.autosubmitmeclick', function() {
    $(this).parents('form:first').submit();
  });

//Load the user/new into the modal div for the new reserver button in the cart
//$().ready(function() {
  //$('#modal').click(function() {
    //$('#userModal div.modal-body').load(new_user_path.value, {from_cart : true }); // new_user_path defined in _cart_dates
  //});
//});
