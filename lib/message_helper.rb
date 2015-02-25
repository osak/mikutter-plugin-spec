require_relative 'idgen'

lambda {
  idgen = IDGenerator.new

  define_method :mention do |message, **kwargs|
    m = Message.new(id: idgen.get,
                    message: message,
                    user: new_user("mikutter_bot"),
                    created: Time.now)
    m.define_singleton_method(:to_me?) do
      true
    end
    Plugin.call(:mention, nil, m)
  end
}.call

Plugin.create(:message_helper) do
  @cnt = 0
  @last_message = nil
  on_appear do |srv, msg|
    @cnt += 1
    @last_message = msg
  end
end

def message_count
  Plugin.create(:message_helper).instance_eval{@cnt}
end

def last_message
  Plugin.create(:message_helper).instance_eval{@last_message}
end
