require './lib/peep'

module PeepHelpers
 
  def find_peeps
    @peeps = Peep.all
  end

  def find_peep
    Peep.get(params[:id]) 
  end

  def create_peep
    @peep = Peep.create(params[:message])
  end
end