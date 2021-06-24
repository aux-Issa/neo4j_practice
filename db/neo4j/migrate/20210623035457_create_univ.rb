class CreateUniv < Neo4j::Migrations::Base
  def up
    #add_constraint :Univ, :uuid
  end

  def down
    drop_constraint :Univ, :uuid
  end
end
