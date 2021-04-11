require 'rails_helper'

RSpec.describe Api::V1::TagsController, type: :request do
  context 'GET #index' do
    it 'returns 200' do
      get api_v1_tags_path
      expect(response.status).to eq(200)
    end
  end

  context 'GET #index' do
    before(:all) do
      @tag = Tag.create({ title: "dummy"})
    end
    it 'returns list of tags' do
      get api_v1_tags_path
      expect(JSON.parse(response.body).first["title"]).to eq("dummy")
    end
  end


  context 'GET #show' do
    before(:all) do
      @tag = Tag.create({ title: "dummy"})
    end
    it 'returns tag json' do 
      get api_v1_tag_path(@tag)
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)["title"]).to eq("dummy")
    end
  end

  context 'GET #show for invalid tag' do
    it 'returns 404' do 
      get api_v1_tag_path(-99)
      expect(response.status).to eq(404)
    end
  end

  context 'POST #create' do
    it ' with valid params returns created tag json' do 
      post api_v1_tags_path, params: {"data":
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
      post api_v1_tags_path, params: {"data":
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
      @tag = Tag.create({ title: "dummy"})
    end

    it ' with valid params returns updated tag json' do 
      patch api_v1_tag_path(@tag), params: {"data":
        {	"type": "undefined",
          "id": @tag.id,
          "attributes":{
            "title": "Updated Tag Title"
          }
        }
      }
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)["title"]).to eq("Updated Tag Title")
    end

    it ' with invalid params returns errors' do 
      patch api_v1_tag_path(@tag), params: {"data":
        {	"type": "undefined",
          "id": @tag.id,
          "attributes":{
            "title": ""
          }
        }
      }
      expect(response.status).to eq(422)
      expect(JSON.parse(response.body)["errors"]).to_not eq([])
    end

    it ' with invalid id returns 404' do 
      patch api_v1_tag_path(-99), params: {"data":
        {	"type": "undefined",
          "id": -99,
          "attributes":{
            "title": ""
          }
        }
      }
      expect(response.status).to eq(404)
    end
  end
end
