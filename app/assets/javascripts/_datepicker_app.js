$(document).ready(function() {
  $('.date_start').datepicker({
    onClose: function(dateText, inst) {
      var start_date = $('.date_start').datepicker("getDate");
      var end_date = $('.date_end').datepicker("getDate");
      if (start_date > end_date){
        $('.date_end').datepicker("setDate", start_date);
      }
      $('.date_end').datepicker( "option" , "minDate" , start_date);
    }
  });
});

// to disable selection of dates in the past with datepicker
$.datepicker.setDefaults({
   minDate: new Date()
});