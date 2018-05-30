require_relative './concerns/slugifiable.rb'

class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  validates_presence_of :username, :email

  extend Slugifiable::ClassMethods
  include Slugifiable::InstanceMethods
end
