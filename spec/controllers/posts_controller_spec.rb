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

            it "should set a flash message" do
                valid_param_request
                expect(flash[:notice]).to be  
            end
        end
            
        context "with invalid params" do
            def invalid_params_request
                post(:create, params:{ post: {
                    title: 'some title',
                    body: 'some body',
                }})
            end

            it "should not create a post in the database" do
                count_before = Post.count
                invalid_params_request
                count_after = Post.count
                expect(count_after).to(eq(count_before))  
            end

            it "should render the new template" do
                invalid_params_request
                expect(response).to(render_template(:new))  
            end   
        end
    end
    
    describe "#show" do
        def make_show_request
            @post = Post.create(
                title: 'some title',
                body: 'some body' * 25
            )
            get(:show, params:{id: @post.id})
        end

        it "should render show template" do
            make_show_request
            expect(response).to(render_template(:show))  
        end

        it "should set an instance variable @post for the show template" do
            make_show_request
            expect(assigns(:post)).to(eq(@post))  
        end
    end

    describe "#destroy" do
        def make_destroy_request
            @post = FactoryBot.create(:post)
            delete(:destroy, params:{ id:@post.id})
        end

        it "should remove a post from the database" do
            make_destroy_request
            expect(Post.find_by(id: @post.id)).to(be(nil))  
        end

        it "should redirect to the post index" do
            make_destroy_request
            expect(response).to(redirect_to(posts_path))  
        end

        it "should set a flash message" do
            make_destroy_request
            expect(flash[:info]).to be  
        end
    end

    describe "#edit" do
        def make_edit_request
            @post = Post.create(
                title: 'some title',
                body: 'some body' * 25
            )
            get(:edit, params:{id: @post.id})
        end

        it "should render the edit template" do
            make_edit_request
            expect(response).to(render_template(:edit))  
        end

        it "should set an instance variable @post for the edit template" do
            make_edit_request
            expect(assigns(:post)).to(eq(@post))  
        end
        
    end
    
    
    
    
end
