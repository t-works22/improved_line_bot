class City < ApplicationRecord
  has_many :children, class_name => "City", foreign_key: :parent_id
  belongs_to :parent, :class_name => "City", foreign_key: :parent_id
end
