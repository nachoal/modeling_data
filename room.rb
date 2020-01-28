require_relative 'patient'
class Room
  attr_accessor :id
  attr_reader :capacity
  class RoomFullError < StandardError
  end
  # STATE?
  # - capacity (Fixnum)
  # - patients (Array of patient instances)

  def initialize(attributes = {})
    @capacity = attributes[:capacity]
    @patients = attributes[:patients] ||= []
    @id       = attributes[:id]
  end

  def full?
    @capacity == @patients.length
  end

  def add_patient(patient)
    if full?
      raise RoomFullError, 'You can\'t add new patients to a full room'
    else
      @patients << patient
      patient.room = self
    end
  end
end

# room_1 = Room.new(capacity: 2)
# # puts 'Is it full?'
# # p room_1.full?
# # puts '----------'

# # I would like to add the patient to a room
# # Ask patient what room he is in
# john = Patient.new(name: 'John')
# paul = Patient.new(name: 'Paul')
# tarzan = Patient.new(name: 'Tarzan')
# room_1.add_patient(john)
# room_1.add_patient(paul)
# begin
# room_1.add_patient(tarzan)
# rescue Room::RoomFullError
#   puts 'You can\'t add new users to a room!'
# end
# p room_1

