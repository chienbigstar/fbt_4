module TourRulesHelper
  def rule_number_field name, value = nil
    number_field_tag name, value
  end

  def rule_select_field name, options, selected = nil
    select_tag name, options_for_select(options, selected),
      class: :rule_select, time: "$time"
  end

  def rule_hidden_field name, value = nil, data = nil
    hidden_field_tag name, value, {data: data}
  end

  def name_for_type time = nil
    "tour_rule[conditions_attributes][#{time||"$time"}][typed]"
  end

  def name_for_value time = nil
    "tour_rule[conditions_attributes][#{time||"$time"}][valued]"
  end

  def name_for_destroy time = nil
    "tour_rule[conditions_attributes][#{time||"$time"}][_destroy]"
  end

  def name_for_rule_id time = nil
    "tour_rule[conditions_attributes][#{time||"$time"}][id]"
  end
end
