$(document).ready(function(){
  $(document).on("change", "#debt_check_all", function(){
    $("input[name='debt_ids[]']").each(function(i, c) {
      c.checked = this.checked;
    }.bind(this));
  });
});
