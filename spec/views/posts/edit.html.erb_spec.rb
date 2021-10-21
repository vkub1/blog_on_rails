require "spec_helper"
require 'rails_helper'

describe "posts/show.html.erb" do
    describe "posts/edit.html.erb" do
        before do
            @post = FactoryBot.create(:post)
            assign(:post, @post)
            params[:id] = '@post.id'
            render
        end
        
        it "should render a text field with the correct title value" do
            expect(rendered).to match(@post.title)
        end

        it "should render a textarea with the correct body value" do
            expect(rendered).to match(@post.body)
        end
    end

end