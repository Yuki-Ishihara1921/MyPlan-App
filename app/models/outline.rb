class Outline < ApplicationRecord
  belongs_to :plan, touch: true
end
