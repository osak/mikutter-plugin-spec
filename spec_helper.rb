require_relative '../../../../core/miquire.rb'
require 'tempfile'
require 'delayer'

require_relative 'lib/environment'
require_relative 'lib/mopt'
require_relative 'lib/timelimitedqueue'

# Setup delayer
Delayer.default = Delayer.generate_class(priority: [:ui_response,
                                                    :routine_active,
                                                    :ui_passive,
                                                    :routine_passive,
                                                    :ui_favorited],
                                         default: :routine_passive,
                                         expire: 0.02)
# プラグインを呼ぶなど、何かイベントを起こしたらこのメソッドを叩いて消化する。
def process_all_events
  mq = Message.class_variable_get(:@@appear_queue)
  while !mq.empty? || !Delayer.empty?
    mq.process_all
    Delayer.run while !Delayer.empty?
  end
end

miquire :lib, 'plugin'
miquire :lib, 'message'
miquire :lib, 'user'

require_relative 'lib/user_helper'
require_relative 'lib/message_helper'

# Useful refinements
module Unsample
  refine Array do
    def sample(n = 1)
      self[0...n]
    end
  end
end

# load plugin
require_relative '../_osa_k'
