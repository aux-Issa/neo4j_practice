class Faculty 
  include Neo4j::ActiveNode
  include Neo4j::ActiveNode
  id_property :code
  property :name, type: String
  self.mapped_label_name = '学部'
  has_many :in, :univs, origin: :faculties, unique: true
  validates :name, :presence => true
end
