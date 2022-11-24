class Liker < ApplicationRecord
    validates :name, {uniqueness: true, allow_nil: true}
end
