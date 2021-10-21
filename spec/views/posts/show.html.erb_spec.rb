require "spec_helper"
require 'rails_helper'

describe "posts/show.html.erb" do

    before do
        @post = FactoryBot.create(:post)
        assign(:post, @post)
        params[:id] = '@post.id'
        render
    end 

    it "should render post title" do
        expect(rendered).to match(@post.title)
    end

    it "should render post body" do
        expect(rendered).to match(@post.body)
    end

    it "should render post created_at" do
        expect(rendered).to match("Posted #{time_ago_in_words(@post.created_at)} ago")
    end
    
end