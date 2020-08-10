$(document).on('turbolinks:load', function(){
  $(function(){
    function appendOption(category){
      var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
      return html;
    }
    function appendChidrenBox(insertHTML){
      var childSelectHtml = '';
      childSelectHtml = `<select id="child_category" name="item[category_id]">
                          <option value="---">---</option>
                            ${insertHTML}
                          <select>`;
      $('.category').append(childSelectHtml);
    }


    function appendGrandchidrenBox(insertHTML){
      var grandchildSelectHtml = '';
      grandchildSelectHtml = `<select id="grandchild_category" name="item[category_id]">
                                <option value="---">---</option>
                                  ${insertHTML}
                              <select>`;
      $('.category').append(grandchildSelectHtml);
    }


    $('#parent_category').on('change', function(){
      var parent_category_id = document.getElementById
      ('parent_category').value;
      if (parent_category_id != "---"){
        $.ajax({
          url: '/items/category/get_category_children',
          type: 'GET',
          data: { parent_id: parent_category_id },
          dataType: 'json'
        })
        .done(function(children){
          $('#child_category').remove();
          $('#grandchild_category').remove();
          var insertHTML = '';
          children.forEach(function(child){
            insertHTML += appendOption(child);
          });
          appendChidrenBox(insertHTML);
        })
        .fail(function(){
          alert('カテゴリー取得に失敗しました');
        })
      }else{
        $('#child_category').remove();
        $('#grandchild_category').remove();
      }
    });


    $('.category').on('change', '#child_category', function(){
      var child_category_id = $('#child_category option:selected').data('category');
      if (child_category_id != "---"){
        $.ajax({
          url: '/items/category/get_category_grandchildren',
          type: 'GET',
          data: { child_id: child_category_id },
          dataType: 'json'
        })
        .done(function(grandchildren){
          if (grandchildren.length != 0) {
            $('#grandchild_category').remove();
            var insertHTML = '';
            grandchildren.forEach(function(grandchild){
              insertHTML += appendOption(grandchild);
            });
            appendGrandchidrenBox(insertHTML);
          }
        })
        .fail(function(){
          alert('カテゴリー取得に失敗しました');
        })
      }else{
        $('#grandchild_category').remove();
      }
    });
  });
});