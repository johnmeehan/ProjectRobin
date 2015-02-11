# Authorization Helper to create a Permission entry for a users action on a thing
module AuthorizationHelpers
  def define_permission!(user, action, thing)
    Permission.create!(user: user, action: action, thing: thing)
  end
end

RSpec.configure do |c|
  c.include AuthorizationHelpers
end
