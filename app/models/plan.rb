class Plan < ApplicationRecord
  belongs_to :user

  has_many :outlines, -> { order(Arel.sql('sort IS NULL, sort ASC, id ASC')) }, dependent: :destroy
  has_many :details, -> { order(Arel.sql('sort IS NULL, sort ASC, id ASC')) }, dependent: :destroy
end
