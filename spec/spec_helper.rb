require 'bundler'

Bundler.require(:default, :test)

class SuperModel::Base

  def read_attribute_for_serialization(n)
    attributes[n]
  end

end

class User < SuperModel::Base
  has_many :projects
  has_many :categories
end

class Project < SuperModel::Base
  belongs_to :user
  belongs_to :category
  has_many :categories
end

class Category < SuperModel::Base
  belongs_to :user
  belongs_to :project
  has_many :projects
end

RSpec.configure do |config|
  config.before do
    user1 = User.create(id: 1, name: "User1") 
    user2 = User.create(id: 2, name: "User2")

    c = Category.create(project: Project.create(user: user2))

    Project.create(user: user1, category: c)
    Project.create(user: user2, category: c)
  end

  config.after do
    User.delete_all
    Project.delete_all
    Category.delete_all
  end
end
