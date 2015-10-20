class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :imported_files

  validates_presence_of :email

  before_create :validate_user

  def name
    unless first_name.nil? || last_name.nil?
      first_name + ' ' + last_name
    end
  end

  def validate_user
    validates_presence_of :email, :password, :password_confirmation
  end
end
