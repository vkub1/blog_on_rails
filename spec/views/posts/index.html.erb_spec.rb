require "spec_helper"
require 'rails_helper'

describe "posts/index.html.erb" do
    it "displays all the posts" do
        assign(:posts, [
            Post.create!(:title => "A test title", :body => 'Culpa quis aut. Modi reprehenderit ut. Veniam iste iusto. Cumque dolor laudantium. Earu.'),
            Post.create!(:title => "A test title2", :body => 'Culpa quis aut. Modi reprehenderit ut. Veniam iste iusto. Cumque dolor laudantium. Earu1.')
          ])
      
          render
      
          expect(rendered).to match /A test title/
          expect(rendered).to match /A test title2/
    end
end