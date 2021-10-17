require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
    describe "#create" do
        context "with valid params" do
            def valid_params_request
                @post = FactoryBot.create(:post)
                post(:create, params:{
                    post_id: @post.id,
                    comment: {
                        body: 'some body'
                    }
                })
            end

            it "should create a comment in the database" do
                count_before = Comment.count
                valid_params_request
                count_after = Comment.count
                expect(count_after).to(eq(count_before+1))  
            end

            it "should redirect to post path" do
                valid_params_request
                expect(response).to(redirect_to(post_path(@post.id)))  
            end

            it "should set a flash success message" do
                valid_params_request
                expect(flash[:success]).to be  
            end
            
            
        end
        
        
    end
    
end
