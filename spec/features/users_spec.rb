require "spec_helper"

describe "Users" do
  context "that have not signed up" do
    describe "visiting the homepage" do
      before { visit "/" }

      it "displays an Highrise sign up button" do
        page.should have_content("Sign Up with Highrise")
      end
    end

    describe "signing up" do
      context "with a valid Highrise auth code" do
        before do
          token_double = double(:token)
          token_double.stub(:token).and_return("an-access-token")
          token_double.stub(:authorize_url).and_return("http://vigetdevs.highrisehq.com/authorization/new")
          Highrise::AccessToken.stub(:new).and_return(token_double)
          visit "/user/new?code=valid-auth-code"
        end

        it "displays a signup form" do
          page.should have_selector("form.edit_user")
        end

        describe "submitting the signup form" do
          context "with complete information" do
            let(:user) { build(:user, :highrise_access_token => nil) }
            before do
              fill_in "user_name", :with => user.name
              fill_in "user_email", :with => user.email
              fill_in "user_password", :with => user.password
              fill_in "user_password_confirmation", :with => user.password
            end

            it "creates a new user" do
              expect{ submit_form }.to change(User, :count).by(1)
            end

            it "redirects to the homepage" do
              submit_form
              current_path.should == root_path
            end

            it "displays a success message" do
              submit_form
              page.should have_content "You're signed up!"
            end
          end

          context "with incomplete information" do
            it "does not create a new user" do
              expect{ submit_form }.not_to change(User, :count)
            end

            it "redisplays the signup form" do
              submit_form
              page.should have_selector("form.new_user")
            end

            it "displays an error message" do
              submit_form
              page.should have_content("There were errors with your submission.")
            end
          end
          
          def submit_form
            click_button "Sign Up"
          end
        end
      end

      context "with an invalid Highrise auth code" do
        before { visit "/user/new?code=invalid-code" }

        it "displays an error message" do
          page.should have_content("Invalid authorization code. Try again.")
        end
      end

      context "without a Highrise code" do
        before { visit "/user/new" }

        it "displays an error message" do
          page.should have_content("No authorization code was provided")
        end
      end
    end
  end
end
