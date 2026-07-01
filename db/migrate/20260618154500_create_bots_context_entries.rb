class CreateBotsContextEntries < ActiveRecord::Migration[8.1]
  def change
    create_table "bots.context_entries" do |t|
      t.string   :instance_id, null: false
      t.string   :scope,       null: false                       # conversation | instance
      t.string   :scope_key,   null: false, default: "__instance__"  # conversa (telefone) ou sentinela de instância
      t.string   :key,         null: false
      t.jsonb    :value,       null: false, default: {}
      t.datetime :expires_at                                     # TTL — NULL = não expira

      t.timestamps
    end

    add_index "bots.context_entries",
              [:instance_id, :scope, :scope_key, :key],
              unique: true,
              name:   "index_context_entries_unique"
    add_index "bots.context_entries", :expires_at
  end
end
