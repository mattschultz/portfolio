require 'spec_helper'

feature "Authentication" do  
  background do
    @user = Factory(:user)
  end

  scenario "sign in with correct credentials" do
    sign_in @user
    current_path.should == root_path
    page.should have_content("Signed in successfully.")
  end
  
  scenario "sign in with incorrect credentials" do
    @user.password = "invalid_password"
    sign_in @user
    current_path.should == new_user_session_path
    page.should have_content("Invalid email or password.")
  end
  
  scenario "sign out" do
    sign_in @user
    click_link "Sign out"
    current_path.should == root_path
    page.should have_content("Signed out successfully.")
  end
end
