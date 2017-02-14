Hanami::Model.migration do
  change do
    add_column :users, :password_digest, String, null: false
  end
end
