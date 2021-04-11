class CreateTaskTags < ActiveRecord::Migration[6.0]
  def change
    create_table :task_tags, id: false do |t|
      t.references :task
      t.references :tag

      t.timestamps
    end
  end
end
