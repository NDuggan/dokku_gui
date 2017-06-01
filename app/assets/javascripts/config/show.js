$(document).on('turbolinks:load', function() {
  $(".destroy-config").on("ajax:success", function(){
    $this = $(this);
    $tbody = $this.closest("tbody");

    $this.closest("tr").fadeOut().remove();
    if ($tbody.find("tr").length === 0){
      $tbody.append('<tr><td colspan="3">No config vars to display.</td></tr>');
    }
  });
});