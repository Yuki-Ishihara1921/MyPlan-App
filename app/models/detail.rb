class Detail < ApplicationRecord
  belongs_to :plan, touch: true
end
