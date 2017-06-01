$(document).on('turbolinks:load', function() {
  $(".toggle-plugin").on("ajax:success", function(){
    $this = $(this);
    $this.children(".fa").toggleClass("fa-toggle-on fa-toggle-off");
    $label = $this.closest("tr").find(".label");

    if ($label.text() == "ENABLED") {
      $this.attr("href", $this.attr("href").replace("disable", "enable"));
      $label.addClass("label-danger").removeClass("label-success").text("DISABLED");
    } else {
      $this.attr("href", $this.attr("href").replace("enable", "disable"));
      $label.addClass("label-success").removeClass("label-danger").text("ENABLED");
    }
  });
});