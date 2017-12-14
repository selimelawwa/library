class Category < ActiveRecord::Base
    
    has_many :book_categories
    has_many :books, through: :book_categories

    validates :name, presence: true, length: {minimum: 3, maximum:25}
    validates_uniqueness_of :name
end