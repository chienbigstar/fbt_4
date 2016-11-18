$(document).on('turbolinks:load', function() {
  $('input[class="daterange"]').daterangepicker();

  $(function() {
    $date_range = $('#filterrific_date_range');
    $date_range .daterangepicker({
      timePicker24Hour: true,
      autoUpdateInput: false,
      timePicker: true,
      timePickerIncrement: 30,
      locale: {
        cancelLabel: 'Clear',
        format: 'YYYY-MM-DD HH:mm:ss'
      }
    });

    $date_range .on('apply.daterangepicker', function(ev, picker) {
      $(this).val(picker.startDate.format('YYYY-MM-DD HH:mm:ss') +
        ' -> ' + picker.endDate.format('YYYY-MM-DD HH:mm:ss'));
    });

    $date_range .on('cancel.daterangepicker', function(ev, picker) {
      $(this).val('');
    });

  });

  $(function() {
    $('.time_picker').daterangepicker({
      singleDatePicker: true,
      showDropdowns: true,
      timePicker24Hour: true,
      autoUpdateInput: false,
      timePicker: true,
      timePickerIncrement: 30,
      locale: {
        cancelLabel: 'Clear',
        format: 'YYYY-MM-DD HH:mm:ss'
      }
    });
    $('.time_picker').on('apply.daterangepicker', function(ev, picker) {
      $(this).val(picker.endDate.format('YYYY-MM-DD HH:mm:ss'));
    });
  });

  $(function() {
    $.getJSON('/admin/tour_rules/new', function(data){
      prepare_rule_data(data);
    });
    $('#bt_add_condition').click(function(){
      $time = $time = Date.now();
      $condition_field = replace_time($condition_input, $time);
      $number_field = replace_time($number_input, $time);
      $destroy_field = replace_time($destroy_input, $time);
      $('#conditions').append('<div>' + $condition_field + $number_field +
        $remove_button + $destroy_field + '</div>');
      type_select_action();
      action_for_destroy();
    });
    type_select_action();
    action_for_destroy();
  });
});


function prepare_rule_data(data){
  $condition_input = get_condition_input(data);
  $text_input = '<input type="text" name=' +
    name_for_element('$time', 'valued') + ' >';
  $number_input = '<input type="number" name=' +
    name_for_element('$time', 'valued') + ' >';
  $remove_button = '<i class="bt-remove pt glyphicon glyphicon-remove" ></i>';
  $destroy_input = '<input type="hidden" name=' +
    name_for_element('$time', '_destroy') + ' >';
}

function replace_time(content, time){
  return content.split('$time').join(time);
}


function get_condition_input(data){
  condition_input = '<select time="$time" class="rule_select" name=' +
    name_for_element('$time', 'typed') + '>';
  $.each(data.conditions, function(i, val){
    condition_input += '<option value=' + val[1] +' >' + val[0] + '</option>';
  });
  condition_input += '</select>';
  return condition_input;
}

function action_for_destroy(){
  $('.bt-remove').click(function(){
    $destroy = $(this).next();
    $($destroy).attr('value', 1);
    $(this).parent().fadeOut();
  });
}

function type_select_action () {
  $('.rule_select').on('change', function(){
    $value = $(this).val();
    $time = $(this).attr('time');
    if($value == 'price_less' || $value == 'price_more'){
      $(this).next().replaceWith(replace_time($number_input, $time));
    }
    else if($value == 'place'){
      $borrow = '<a href=/admin/places?time='+ $time +
        ' class="glyphicon glyphicon-folder-open" data-remote="true"></a>';
      $(this).next().replaceWith('<span>' + replace_time($text_input, $time) +
        $borrow + '</span>');
    }
    else if($value == 'tour'){
      $borrow = '<a href=/admin/tours?time='+ $time +
        ' class="glyphicon glyphicon-folder-open" data-remote="true"></a>';
      $(this).next().replaceWith('<span>' + replace_time($text_input, $time) +
        $borrow + '</span>');
    }
  });
}

function name_for_element(time, element){
  return 'tour_rule[conditions_attributes][' + time + '][' + element + ']';
}
