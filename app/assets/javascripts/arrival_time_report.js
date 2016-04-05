$(document).on("ready",function(){
  $(".date").datepicker({
    format: 'yyyy-mm-dd',
    autoclose: true
  });
  $(".date").on("change",function(){
    if($("#from").val().trim() != ""){
      data = {from: $("#from").val().trim(), to: $("#to").val().trim(), id:$("#employee_id").val()};
      var build = function(){
        buildTable("working_time_tbl");
      };
      loadAjaxSection('/manage/arrival_report/'+$("#employee_id").val()+"/section/",data,"tbl_section",build);
    }else{
      $("#tbl_section").children().remove();
    }
  });
  $('[data-toggle="buttons"] > .btn').on('click',function() {
    var button = $(this).find("input")[0];
    console.log($(button).attr("class"));
    $('#option_report').val($(button).attr("class"));
  });
});
