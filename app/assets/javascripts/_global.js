// general submit on change class
$(document).on('change', '.autosubmitme', function() {
  $(this).parents('form:first').submit();
});

//$(document).on('change', '.autosubmitme2', function() {
//  $.ajax("update_dates");
//});

$(document).on('railsAutocomplete.select', '#fake_reserver_id', function(event, data){
    $("#reserver_id").val(data.item.id); // updating reserver_id here to make sure that it is done before it submits
    $(this).parents('form').submit();
});