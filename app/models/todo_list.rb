# frozen_string_literal: true

class TodoList < ApplicationRecord
  enum routine: { once: 0, daily: 1, weekly: 2, monthly: 3 }

  belongs_to :user

  validates :title, presence: true

  def destroy
    update completed_at: Time.current
  end
end
