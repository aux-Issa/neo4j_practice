class ForceCreate大学codeConstraint < Neo4j::Migrations::Base
  def up
    add_constraint :大学, :code, force: true
  end

  def down
    drop_constraint :大学, :code
  end
end
