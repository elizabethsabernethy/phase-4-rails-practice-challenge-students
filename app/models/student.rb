class Student < ApplicationRecord
    belongs_to :instructor
    validates :name, presence: true
    validates :age, maximum: {18}
end
