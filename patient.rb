# 1. Define the state


class Patient
  attr_reader :name, :cured
  attr_accessor :room, :id
  # State? Attributes
  # - name (string)
  # - cured boolean
  def initialize(attributes = {})
    @name  = attributes[:name]
    @cured = attributes[:cured] ||= false
    @blood_type = attributes[:blood_type]
    @room = attributes[:room]
    @id   = attributes[:id]
  end

  def cure
    @cured = true
  end
end
