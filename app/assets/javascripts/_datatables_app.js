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

  $('.datatable-wide').dataTable({
    "sDom": "<'row'<'span5'l><'span7'f>r>t<'row'<'span5'i><'span7'p>>",
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

  $('.report_table').dataTable({
    "sDom": "<'row'<'span3'l>fr>t<'row'<'span3'i><p>>",
    "sPaginationType": "bootstrap",
    "iDisplayLength" : 25,
    "aLengthMenu": [[25, 50, 100, -1], [25, 50, 100, "All"]],
    "aoColumnDefs": [{ "bSortable": false, "aTargets": [ "no_sort" ] }]
  });
});