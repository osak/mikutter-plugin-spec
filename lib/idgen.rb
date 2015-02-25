class IDGenerator
  def initialize
    @counter = 0
  end

  def get
    @counter += 1
  end
end
