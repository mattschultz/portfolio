require "spec_helper"

feature "Projects" do
  background do
    @project_1 = Factory(:project, title: "My Project 1")
    @project_2 = Factory(:project, title: "My Project 2")
  end
  
  context "a visitor" do
    scenario "views the projects list" do
      visit projects_url
      page.should have_content("My Project 1")
      page.should have_content("My Project 2")
      page.should have_no_content("Sign out")
      page.should have_no_content("Edit Project")
      page.should have_no_content("Destroy Project")
    end
    
    scenario "attempts to view a restricted page" do
      visit new_project_url
      current_url.should == new_user_session_url
      visit edit_project_url(@project_1)
      current_url.should == new_user_session_url
    end
  end
  
  context "a user" do
    background do
      @user = Factory(:user)
      sign_in @user
    end
  
    scenario "views the projects list" do
      page.should have_content("My Project 1")
      page.should have_content("My Project 2")
      page.should have_content("Sign out")
      page.should have_content("Edit Project")
      page.should have_content("Destroy Project")
    end
  
    scenario "creates a project with valid attributes" do
      click_link "New Project"
      current_url.should == new_project_url
      fill_in "Title", with: "My New Project"
      fill_in "Url", with: "http://example.com"
      fill_in "Description", with: "This is the description of my project"
      attach_file("Image", "#{Rails.root}/spec/fixtures/do_it_live.jpg")
      click_button "Create Project"
      current_url.should == projects_url
      page.should have_content("Project was successfully created.")
      page.should have_content("My New Project")
      page.should have_css("img[alt=Do_it_live]")
    end
    
    scenario "creates a project with invalid attributes" do
      click_link "New Project"
      current_url.should == new_project_url
      fill_in "Title", with: "My New Project"
      fill_in "Url", with: "jello puddin pops"
      fill_in "Description", with: "This is the description of my project"
      attach_file("Image", "#{Rails.root}/spec/fixtures/do_it_live.jpg")
      click_button "Create Project"
      page.should have_content("New project")
      page.should have_content("1 error prohibited this Project from being saved:")
    end
    
    scenario "edits a project with valid attributes" do
      click_link "Edit Project"
      current_url.should == edit_project_url(@project_1)
      fill_in "Title", with: "My Edited Project"
      click_button "Update Project"
      current_url.should == projects_url
      page.should have_content("Project was successfully updated.")
      page.should have_content("My Edited Project")
    end
    
    scenario "edits a project with invalid attributes" do
      click_link "Edit Project"
      current_url.should == edit_project_url(@project_1)
      fill_in "Url", with: "Jello Puddin Pops"
      click_button "Update Project"
      page.should have_content("Editing project")
      page.should have_content("1 error prohibited this Project from being saved:")
    end
    
    scenario "destroys a project" do
      click_link "Destroy Project"
      current_url.should == projects_url
      page.should have_no_content("My Project 1")
      page.should have_content("Project was successfully destroyed.")
    end
  end
end
