class Order < ApplicationRecord
    belongs_to :user
    has_many :order_items, dependent: :destroy
    before_create :default_total_cost

    def default_total_cost
        self.total_cost ||= 0
    end
end
