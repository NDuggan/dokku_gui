$(document).on('turbolinks:load', function() {
  // On modal open
  $("#myModal").on("shown.bs.modal", function(){
    $("#app_name").focus();
  });

  // Submit create with enter
  $("#app_name").keyup(function(e){
    if (e.which == 13 || e.keyCode == 13) {
      $("#create-app").click();
    }
  });

  // Create app
  $("#create-app").click(function(e){
    e.preventDefault();
    e.stopPropagation();
    $(this).attr("disabled", true).text("Creating…");

    $.post("/apps", { app_name: $("#app_name").val() })
      .done(function(){
        $("#myModal .modal-body .alert").text("App successfully created").removeClass("hide alert-danger").addClass("alert-success");

        setTimeout(function(){
          window.location = "/apps";
        }, 900);
      }).fail(function(){
        $("#myModal .modal-body .alert").text("App couldn't be created").removeClass("hide alert-success").addClass("alert-danger");
        $("#create-app").attr("disabled", false).text("Create");
      });
  });

  // Rename app
  $("[data-app]").click(function(e){
    e.preventDefault();
    e.stopPropagation();

    var $this = $(this);

    if ($this.data().state == "read") {
      $this.data("state", "edit");
      $this.siblings("span").hide();
      $this.children("i.fa").removeClass("fa-pencil").addClass("fa-check text-success");
      $this.parent().prepend("<input type='text' class='app-rename' value='" + $(this).data().app + "'>");
      $this.siblings(".app-rename").select();
    } else if ($this.data().state == "edit") {
      $this.children("i.fa").addClass("fa-spin fa-spinner").removeClass("fa-check text-success");
      $.post("/apps/" + $this.data().app + "/rename", { old_app_name: $this.data().app, new_app_name: $this.siblings(".app-rename").val() })
        .done(function(){
          $this.data("state", "read");
          $this.siblings("span").text($this.siblings(".app-rename").val()).show();
          $this.children("i.fa").addClass("fa-pencil").removeClass("fa-spin fa-spinner");
          $this.siblings(".app-rename").remove();
        }).fail(function(){
          $this.siblings(".app-rename").select();
          $this.children("i.fa").addClass("fa-check text-success").removeClass("fa-spin fa-spinner");
        });
    }
  });

  // Submit rename with enter
  $("body").on("keyup", ".app-rename", function(e){
    var $submit = $(this).siblings("a");
    if (e.which == 13 || e.keyCode == 13) {
      $submit.click();
    } else if (e.which == 27 || e.keyCode == 27) {
      $submit.data("state", "read");
      $submit.siblings("span").text($submit.siblings(".app-rename").val()).show();
      $submit.children("i.fa").addClass("fa-pencil").removeClass("fa-spin fa-spinner text-success");
      $submit.siblings(".app-rename").remove();
    }
  });
});
