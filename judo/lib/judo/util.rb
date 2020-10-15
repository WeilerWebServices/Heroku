module Judo
  module Util
    def self.system_confirmed(cmd)
      system cmd
      raise "Command #{cmd} failed with exit code #{$?.to_i}" unless $?.success?
    end
  end
end
