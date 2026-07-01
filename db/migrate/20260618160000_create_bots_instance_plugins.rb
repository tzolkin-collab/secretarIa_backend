class CreateBotsInstancePlugins < ActiveRecord::Migration[8.1]
  def change
    create_table "bots.instance_plugins" do |t|
      t.string :instance_id, null: false
      t.string :plugin_name, null: false
      t.jsonb  :installed_automation_ids, null: false, default: []  # ids das automações que o plugin criou

      t.timestamps
    end

    add_index "bots.instance_plugins", [:instance_id, :plugin_name],
              unique: true, name: "index_instance_plugins_unique"
  end
end
