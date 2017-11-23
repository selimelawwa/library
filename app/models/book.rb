class Book < ApplicationRecord
    mount_uploader :image, ImageUploader

    has_many :order_items, dependent: :destroy

    validates :name, presence: true
    validates :isbn, presence: true
    validates :author, presence: true
    validates :price, presence: true
    validates :publisher, presence: true
    validates :quantity, presence: true

    
end
