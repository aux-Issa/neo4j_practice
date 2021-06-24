class ForceCreate学部codeConstraint < Neo4j::Migrations::Base
  def up
    add_constraint :学部, :code, force: true
  end

  def down
    drop_constraint :学部, :code
  end
end
