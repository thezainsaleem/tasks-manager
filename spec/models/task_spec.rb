require 'rails_helper'

RSpec.describe Task, type: :model do
  let (:valid_task_params) { { title: "dummy" } }
  context 'Validations' do 
    context ' title' do
      it 'is must be present' do 
        task = Task.new({
        })
        expect(task).to_not be_valid
        task.title = "Some name"
        expect(task).to be_valid
      end

      it '''s length must be larger or equal to one' do 
        task = Task.new({
          title: ""
        })
        expect(task).to_not be_valid
        task.title = "x"
        expect(task).to be_valid
      end
    end
  end

  context 'Creating new task without tags' do
    it 'should increase length of total by 1 ' do
      tasks_count = Task.count()
      Task.create(valid_task_params)
      expect(Task.count).to eq(tasks_count + 1)
    end

    it 'should have same title as passed and empty tags' do
      created_task = Task.create(valid_task_params)
      expect(created_task.title).to eq(valid_task_params[:title])
      expect(created_task.tags).to eq([])
    end
  end


  context 'Creating new task with tags' do
    let (:valid_task_with_tags_params) { { title: "dummy", tags_attributes: [{ title: "tag1" }, { title: "tag2"}] } }

    it 'should have same title as passed and tags' do
      created_task = Task.create(valid_task_with_tags_params)
      expect(created_task.title).to eq(valid_task_with_tags_params[:title])
      expect(created_task.tags.collect(&:title)).to eq(valid_task_with_tags_params[:tags_attributes].collect { |t| t[:title] })
    end
  end


  context 'Updating task without tags' do
    before (:each) do
      @task_to_update = Task.create(valid_task_params)
    end

    it 'should have same title as passed and empty tags' do
      @task_to_update.update_attributes({ title: "updated title" })
      @task_to_update.reload
      expect(@task_to_update.title).to eq("updated title")
    end
  end

  context 'Updating task with tags' do
    let (:valid_task_with_tags_params) { { title: "dummy1", tags_attributes: [{ title: "tag1" }, { title: "tag2"}] } }
    before (:each) do
      @task_to_update = Task.create(valid_task_params)
    end

    it 'should have same title as passed and tags' do
      @task_to_update.update_attributes(valid_task_with_tags_params)
      @task_to_update.reload
      expect(@task_to_update.title).to eq(valid_task_with_tags_params[:title])
      expect(@task_to_update.tags.collect(&:title)).to eq(valid_task_with_tags_params[:tags_attributes].collect { |t| t[:title] })
    end
  end

  context 'Updating task and removing tag' do
    let (:valid_task_with_tags_params) { { title: "dummy1", tags_attributes: [{ title: "tag1" }, { title: "tag2"}] } }
    before (:each) do
      @task_to_update = Task.create(valid_task_with_tags_params)
    end

    it 'should remove and delete tag' do
      @task_to_update.update_attributes({
        title: "something else",
        tags_attributes: [{ id: @task_to_update.tags.first.id, title: "tag1", _destroy: true }, { id: @task_to_update.tags.last.id, title: "tag3"} ]
      })
      @task_to_update.reload
      expect(@task_to_update.title).to eq("something else")
      expect(@task_to_update.tags.collect(&:title)).to eq(["tag3"])
    end
  end

  context 'Deleting Task' do
    before (:each) do
      @task_to_destroy = Task.create(valid_task_params)
    end

    it ' should decrease length of total by 1' do
      tasks_count = Task.count()
      @task_to_destroy.destroy
      expect(Task.count).to eq(tasks_count - 1)
    end
  end

end
