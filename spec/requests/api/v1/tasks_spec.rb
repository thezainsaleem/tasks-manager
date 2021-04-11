require 'rails_helper'

RSpec.describe "Api::V1::Tasks", type: :request do
  context 'GET #index' do
    it 'returns 200' do
      get api_v1_tasks_path
      expect(response.status).to eq(200)
    end
  end

  context 'GET #index' do
    before(:all) do
      @task = Task.create({ title: "dummy"})
    end
    it 'returns list of tasks' do
      get api_v1_tasks_path
      expect(JSON.parse(response.body).first["title"]).to eq("dummy")
    end
  end


  context 'GET #show' do
    before(:all) do
      @task = Task.create({ title: "dummy"})
    end
    it 'returns task json' do 
      get api_v1_task_path(@task)
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)["title"]).to eq("dummy")
    end
  end

  context 'GET #show for invalid task' do
    it 'returns 404' do 
      get api_v1_task_path(-99)
      expect(response.status).to eq(404)
    end
  end

  context 'POST #create' do
    it ' with valid params returns created task json' do 
      post api_v1_tasks_path, params: {"data":
        {	"type": "undefined",
          "id": "undefined",
          "attributes":{
            "title": "Someday"
          }
        }
      }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)["title"]).to eq("Someday")
    end

    it ' with invalid params returns errors' do 
      post api_v1_tasks_path, params: {"data":
        {	"type": "undefined",
          "id": "undefined",
          "attributes":{
            "title": ""
          }
        }
      }
      expect(response.status).to eq(422)
      expect(JSON.parse(response.body)["errors"]).to_not eq([])
    end
  end

  context 'POST #update' do
    before(:each) do
      @task = Task.create({ title: "dummy"})
    end

    it ' with valid params returns updated task json' do 
      patch api_v1_task_path(@task), params: {"data":
        {	"type": "undefined",
          "id": @task.id,
          "attributes":{
            "title": "Updated Task Title"
          }
        }
      }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)["title"]).to eq("Updated Task Title")
    end

    it ' with valid params and tags returns updated task json' do 
      patch api_v1_task_path(@task), params: {"data":
        {	"type": "undefined",
          "id": @task.id,
          "attributes":{
            "title": "Updated Task Title",
            "tags": ["Urgent", "Home"]
          }
        }
      }
      expect(response.status).to eq(200)
      parsed_data = JSON.parse(response.body)

      expect(parsed_data["title"]).to eq("Updated Task Title")
      expect(parsed_data["tags"].collect {|x| JSON.parse(x)["title"] }).to eq(["Urgent", "Home"])
    end

    it ' with invalid params returns errors' do 
      patch api_v1_task_path(@task), params: {"data":
        {	
          "type": "undefined",
          "id": @task.id,
          "attributes":{
            "title": ""
          }
        }
      }
      expect(response.status).to eq(422)
      expect(JSON.parse(response.body)["errors"]).to_not eq([])
    end

    it ' with invalid id returns 404' do 
      patch api_v1_task_path(-999), params: {"data":
        {	"type": "undefined",
          "id": -999,
          "attributes":{
            "title": ""
          }
        }
      }
      expect(response.status).to eq(404)
    end
  end

  context 'DELETE #destroy' do
    before(:each) do
      @task = Task.create({ title: "dummy"})
    end

    it ' valid task returns frozen destroyed object with 200' do 
      delete api_v1_task_path(@task)
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)["id"]).to eq(@task.id)
    end

    it ' with invalid id returns 404' do
      delete api_v1_task_path(-999)
      expect(response.status).to eq(404)
    end
  end

end
