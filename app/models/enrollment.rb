class Enrollment < ApplicationRecord
  belongs_to :user, foreign_key: :user_id
  belongs_to :teacher, foreign_key: :teacher_id, class_name: 'User'
  belongs_to :program
  validates_uniqueness_of :user_id, scope: 'teacher_id'
  
end
