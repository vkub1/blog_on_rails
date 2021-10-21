require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "validates" do
    it "body should be present" do
      comment = Comment.new(body:nil)
      comment.valid?
      expect(comment.errors.messages).to(have_key(:body))  
    end
  end
  
end
