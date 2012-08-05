function truncate() {
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
};

function validate_checkin(){
  flag = false;
  $.each( $(".checkin"), function(i, l){
    var steps = $(this).find(':checkbox').length;
    var steps_completed = $(this).find("input:checked").length;
      if (steps_completed != steps && steps_completed != 0) {
        flag = true;
      }
      else {
        //do nothing
      }
  });
  return flag;
};

function validate_checkout(){
  flag = false;
  $.each( $(".checkout"), function(i, l){
    var steps = $(this).find(':checkbox').length;
    var steps_completed = $(this).find("input:checked").length;
    var selected = $(this).find(".dropselect").val();
    if (selected != ""){
      if (steps_completed != steps) {
        flag = true;
      }
      else { // do nothing
      }
    } else {
        if (steps_completed > 0) {
          flag = true;
        }
        else {}
      }
  });
  return flag;
};

function confirm_checkinout(flag){
  if (flag){
    if( confirm("One or more check in or check out procedures have not been completed. Are you sure you want to continue?")){
      (this).submit();
      return false;
    } else {
      //they clicked no.
      return false;
    }
  }
  else {
    (this).submit();
  }
};