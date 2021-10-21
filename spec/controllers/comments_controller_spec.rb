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

        context "with invalid params" do
            def invalid_params_request
                @post = FactoryBot.create(:post)
                post(:create, params:{
                    post_id: @post.id,
                    comment: {
                        body: nil
                    }
                })
            end

            it "should not create a comment in the database" do
                count_before = Comment.count
                invalid_params_request
                count_after = Comment.count
                expect(count_after).to(eq(count_before))  
            end

            it "should render the post/show page" do
                invalid_params_request 
                expect(response).to(render_template("layouts/application", "posts/show"))  
            end

            it "should set @comments to the post/show page" do
                invalid_params_request
                comment1 = Comment.create(
                    body:"Body1",
                    post: @post
                )
                comment2 = Comment.create(
                    body:"Body1",
                    post: @post
                )
                @comments = [
                    comment2,
                    comment1
                ]
                expect(assigns(:comments)).to(eq(@comments))  
            end
        end
    end

    describe "#destroy" do
        def make_delete_request
            @comment = FactoryBot.create(:comment)
            delete(:destroy, params:{post_id:@comment.post, id:@comment.id})
        end

        it "should destroy a comment from the database" do
            make_delete_request
            expect(Comment.find_by(id: @comment.id)).to(be(nil))  
        end

        it "should redirect to the post show page" do
            make_delete_request
            expect(response).to(redirect_to(post_path(@comment.post)))  
        end
        
        it "should set a flash message" do
            make_delete_request
            expect(flash[:success]).to be  
        end
        
    end
    
    
end
