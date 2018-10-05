class ApplicationRecord 
  include MongoMapper::Document
  self.abstract_class = true
end
