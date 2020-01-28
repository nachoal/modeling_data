require_relative 'room'
require 'CSV'
class RoomRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @next_id = 0
    @rooms = []

    load_csv
  end

  def add(room)
    room.id = @next_id
    @next_id += 1
    @rooms << room
    save_csv
  end

  def find(room_id)
    @rooms.find do |room|
      room.id == room_id.to_i
    end
  end

  def load_csv
    csv_options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file, csv_options) do |row|
      row[:id] = row[:id].to_i
      row[:capacity] = row[:capacity].to_i
      @rooms << Room.new(row)
    end

    @next_id = @rooms.empty? ? 1 : @rooms.last.id + 1
  end

  def save_csv
    csv_options = { col_sep: ','}
    CSV.open(@csv_file, 'wb', csv_options) do |csv|
      csv << ['id', 'capacity']
      @rooms.each  do |room|
        csv << [room.id, room.capacity]
      end
    end
  end
end