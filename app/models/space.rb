class Space
  include DataMapper::Resource
  has n, :users, through: Resource

  property :id,     Serial
  property :name,  String
  property :location, String
  property :description, String
  property :price_per_night, Integer
  property :available_from, Date
  property :available_to, Date

  validates_presence_of :name, :location, :description, :price_per_night, :available_from, :available_to

  def self.filter(params)
    spaces = []
    Space.all.each do |space|
      if Date.strptime(params[:filter_from], '%Y-%m-%d').to_time.to_i >= space.available_from.to_time.to_i && Date.strptime(params[:filter_to], '%Y-%m-%d').to_time.to_i <= space.available_to.to_time.to_i
        spaces << space
      end
    end
    return spaces
  end
end
