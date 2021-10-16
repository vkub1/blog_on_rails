require 'rails_helper'

RSpec.describe PostsController, type: :controller do
    describe "#index" do
        it "should render an index template" do
            get(:index)
            expect(response).to(render_template(:index))  
        end

        it "should set an instance variable posts for the index template" do
            first_post = FactoryBot.create(:post)
            second_post = FactoryBot.create(:post)
            third_post = FactoryBot.create(:post)
            get(:index)
            expect(assigns(:posts)).to(eq([third_post, second_post, first_post]))
        end
        
        
    end
end
