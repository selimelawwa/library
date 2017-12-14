class Book < ApplicationRecord
    mount_uploader :image, ImageUploader
    before_create :default_ordered_times
     has_many :book_categories
    has_many :categories, through: :book_categories
    

    has_many :order_items, dependent: :destroy
    
     
    validates :name, presence: true
    validates :isbn, presence: true
    validates :author, presence: true
    validates :price, presence: true
    validates :publisher, presence: true
    validates :quantity, presence: true
    validates_numericality_of :quantity, :only_integer => true, :greater_than_or_equal_to => 0
   # validates_numericality_of :rating, :only_integer => true, :greater_than_or_equal_to => 0

  

   def default_ordered_times
        self.ordered_times ||= 0
    end
end
