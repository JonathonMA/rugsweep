require "rugsweep/version"

module Rugsweep
  def self.sweep
    Sweeper.new.sweep
  end
end

require "rugsweep/sweeper"
