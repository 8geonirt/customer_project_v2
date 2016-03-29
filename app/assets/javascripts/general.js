var buildTable = function(id){
  $("#"+id).DataTable();
}

var loadAjaxSection = function(url,data,id,callback){
  $.ajax({
    url:url,
    data:data || {},
    success:function(response){
      $("#"+id).html(response);
      if(callback != ""){
        var callbacks = $.Callbacks();
        callbacks.add(callback);
        callbacks.fire();
      }
    },
    error: function(error){
      alert("An error ocurred: " + error);
    }
  });
}
