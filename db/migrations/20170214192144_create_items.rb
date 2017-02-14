Hanami::Model.migration do
  change do
    create_table :items do
      primary_key :id

      column :code,      String, null: false, unique: true, size: 4
      column :available, TrueClass, null: false, default: true

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end
end
