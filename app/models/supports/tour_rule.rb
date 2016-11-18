class Supports::TourRule
  def places
    @places ||= Place.all.collect {|place| [place.name, place.id]}
  end

  def conditions
    @conditions = TourRule.typeds.collect {|key, value| [key, key]}
  end
end
