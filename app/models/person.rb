class Person < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  validates :email, :presence => true

  has_many :group_memberships
  has_many :persons, :through => :group_memberships
  has_many :groups, :through => :group_memberships, :conditions => {:visible => true}

  def related
    group_ids = GroupMembership.
      where(:person_id => person.id).
      select("DISTINCT(group_id)").
      map(&:group_id)

    people_ids = GroupMembership.
      where(:group_id => group_ids).
      where("person_id IS NOT NULL").
      where("person_id != ?", person.id).
      select("DISTINCT(person_id)").
      map(&:person_id)

    Person.where(:id => people_ids)
  end
end
