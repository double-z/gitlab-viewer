require 'spec_helper'

describe "Profile" do
  before do 
    login_as :user
  end

  describe "Show profile" do
    before do 
      visit profile_path
    end

    it { page.should have_content(@user.name) }
    it { page.should have_content(@user.email) }
  end

  describe "Password update" do
    before do 
      visit profile_password_path
    end

    it { page.should have_content("Password") }
    it { page.should have_content("Password confirmation") }

    describe "change password" do 
      before do 
        @old_pwd = @user.encrypted_password 
        fill_in "user_password", :with => "777777"
        fill_in "user_password_confirmation", :with => "777777"
        click_button "Save"
        @user.reload
      end

      it "should redirect to signin page" do
        current_path.should == new_user_session_path
      end

      it "should change password" do 
        @user.encrypted_password.should_not == @old_pwd
      end

      describe "login with new password" do 
        before do
          fill_in "user_email", :with => @user.email
          fill_in "user_password", :with => "777777"
          click_button "Sign in"
        end
        
        it "should login user" do 
          current_path.should == root_path
        end
      end
    end
  end
end
