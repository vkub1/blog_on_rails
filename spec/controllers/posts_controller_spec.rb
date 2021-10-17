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

    describe "#new" do
        it "should render a new template" do
            get(:new)
            expect(response).to(render_template(:new))  
        end

        it "should set a new instance variable @post" do
            get(:new)
            expect(assigns(:post)).to(be_a_new(Post))  
        end
    end

    describe "#create" do
        context "with valid params" do
            def valid_param_request
                post(:create, params:{ post: {
                    title: 'some title',
                    body: 'some body' * 25,
                }})
            end

            it "should create a post in the database" do
                count_before = Post.count
                valid_param_request
                count_after = Post.count
                expect(count_after).to(eq(count_before + 1))  
            end

            it "should redirect us to a show page for that post" do
                valid_param_request
                post = Post.last
                expect(response).to(redirect_to post_path(post.id))  
            end
            
            
        end
        
        
    end
    
    
end
