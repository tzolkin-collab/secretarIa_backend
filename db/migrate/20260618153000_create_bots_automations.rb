class CreateBotsAutomations < ActiveRecord::Migration[8.1]
  def change
    create_table "bots.automations" do |t|
      t.string   :instance_id,  null: false
      t.string   :name,         null: false
      t.boolean  :enabled,      null: false, default: true
      t.string   :author,       null: false, default: "ai"   # ai | operator
      t.string   :trigger_type, null: false                  # on_message | on_schedule | on_http
      t.string   :http_slug                                  # só para on_http — roteamento + unicidade
      t.jsonb    :recipe,       null: false, default: {}      # receita completa validada (D2)

      # Observabilidade (preenchida pelo executor B2)
      t.datetime :last_run_at
      t.string   :last_run_status                            # success | error | running
      t.text     :last_error
      t.datetime :next_run_at

      t.timestamps
    end

    add_index "bots.automations", :instance_id
    add_index "bots.automations", [:instance_id, :http_slug],
              unique: true,
              where:  "http_slug IS NOT NULL",
              name:   "index_automations_on_instance_and_slug"
  end
end
