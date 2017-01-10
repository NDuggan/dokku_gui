$(document).on('turbolinks:load', function() {
  // On modal open
  $("#myModal").on("shown.bs.modal", function(){
    $("#app_name").focus();
  });

  // Submit with enter
  $("#app_name").keypress(function(e){
    if (e.which == 13 || e.keyCode == 13) {
      $("#create-app").click();
    }
  });

  // Create app
  $("#create-app").click(function(e){
    e.preventDefault();
    e.stopPropagation();
    $(this).attr("disabled", true).text("Creating…");

    $.post("/apps", { app_name: $("#app_name").val() }).done(function(){
      $("#myModal .modal-body .alert").text("App successfully created").removeClass("hide alert-danger").addClass("alert-success");

      setTimeout(function(){
        window.location = "/apps";
      }, 900);
    }).fail(function(){
      $("#myModal .modal-body .alert").text("App couldn't be created").removeClass("hide alert-success").addClass("alert-danger");
      $("#create-app").attr("disabled", false).text("Create");
    });
  });
});
