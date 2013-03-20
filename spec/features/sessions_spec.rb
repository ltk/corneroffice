require "spec_helper"

describe "Sessions" do
  describe "Signing In" do
    describe "with invalid credentials" do
      it "re-renders the form with errors" do 
        visit "/session/new"

        fill_in "Email", :with => "blue@devils.bsktbll"
        fill_in "Password", :with => "#winning"

        click_button "Sign in"

        current_path.should == new_session_path
        page.should have_content "Couldn't locate a user with those credentials"
      end
    end

    describe "with valid credentials" do
      let(:user) { create(:user) }
      
      it "renders the account page" do
        visit "/session/new"

        fill_in "Email", :with => user.email
        fill_in "Password", :with => user.password

        click_button "Sign in"

        page.current_path.should == root_path
        page.should have_content "Signed in"
      end
    end
  end

  describe "Signing Out" do
    describe "a user who is logged in" do
      it "can log out" do
        user = create(:user)
        log_in user.email, user.password

        visit root_path
        click_link "Sign Out"

        page.current_path.should == new_session_path
        page.should have_content "Signed out"
      end
    end
  end
end