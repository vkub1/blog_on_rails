require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "validation" do
    describe "title" do
      it "should have a title" do
        post = FactoryBot.build(:post, title: nil)
        post.valid?
        expect(post.errors.messages).to(have_key(:title))  
      end

      it "should be unique" do
        post = FactoryBot.create(:post)
        next_post = FactoryBot.build(:post, title: post.title)
        next_post.valid?

        expect(next_post.errors.messages).to(have_key(:title))  
      end
    end

    
    
    
  end
  
end
