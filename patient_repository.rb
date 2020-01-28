require_relative 'patient'
require_relative 'room_repository'
require 'CSV'

# FOR A MODEL REPO REMEMBER THAT YOU'LL HAVE 2 BASIC METHODS
# load_csv (taking values from the csv file and creating those as instances)
# save_csv (taking instances and saving those as text csv)
# method: add(patient) that will add the instance to the array and save to csv
# find

class PatientRepository
  def initialize(csv_file, room_repository)
    @csv_file = csv_file
    @room_repository = room_repository
    @next_id = 1
    @patients = []

    load_csv
  end

  def add(patient)
    patient.id = @next_id
    @next_id += 1
    @patients << patient

    save_csv
  end

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file, csv_options) do |row|
      row[:id]      = row[:id].to_i          # Convert column to Integer
      row[:cured]   = row[:cured] == 'true'  # Convert column to boolean

      room = @room_repository.find(row[:room_id].to_i)
      patient = Patient.new(row)
      patient.room = room
      room.add_patient(patient)
      @patients << patient
    end

    @next_id = @patients.empty? ? 1 : @patients.last.id + 1
  end

  def save_csv
    csv_options = { col_sep: ','}
    CSV.open(@csv_file, 'wb', csv_options) do |csv|
      csv << ['id', 'name', 'cured', 'room_id']
      @patients.each  do |patient|
        csv << [patient.id, patient.name, patient.cured, patient.room.id]
      end
    end
  end
end

# room_repo    = RoomRepository.new('rooms.csv')
# patient_repo = PatientRepository.new('patients.csv', room_repo)

# jaime = Patient.new(name: 'jaime', cured: false)
# private_room = Room.new(capacity: 1)
# room_repo.add(private_room)
# private_room.add_patient(jaime)

# patient_repo.add(jaime)

# pp patient_repo

