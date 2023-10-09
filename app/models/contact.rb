class Contact < ApplicationRecord
  belongs_to :user

  def self.today_birthdays
    where('EXTRACT(month FROM birthday) = ? AND EXTRACT(day FROM birthday) = ?', Date.today.month, Date.today.day)
  end

end
