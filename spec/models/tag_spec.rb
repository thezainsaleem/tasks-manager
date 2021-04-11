require 'rails_helper'

RSpec.describe Tag, type: :model do

  let (:valid_tag_params) { { title: "dummy" } }

  context 'Validations' do 
    context ' title' do
      it 'is must be present' do 
        tag = Tag.new({
        })
        expect(tag).to_not be_valid
        tag.title = "Some name"
        expect(tag).to be_valid
      end

      it '''s length must be larger or equal to one' do 
        tag = Tag.new({
          title: ""
        })
        expect(tag).to_not be_valid
        tag.title = "x"
        expect(tag).to be_valid
      end
    end
  end

  context 'Creating new tag' do
    it 'should increase length of total by 1 ' do
      tags_count = Tag.count()
      Tag.create(valid_tag_params)
      expect(Tag.count).to eq(tags_count + 1)
    end
  end

  context 'Deleting Artist' do
    before (:each) do
      @tag_to_destroy = Tag.create(valid_tag_params)
    end

    it 'should decrease length of total by 1' do
      tags_count = Tag.count()
      @tag_to_destroy.destroy
      expect(Tag.count).to eq(tags_count - 1)
    end
  end

end
