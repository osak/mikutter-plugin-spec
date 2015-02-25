require_relative 'idgen'

lambda {
  idgen = IDGenerator.new
  define_method :new_user do |idname|
    User.new(id: idgen.get,
             idname: idname)
  end
}.call
