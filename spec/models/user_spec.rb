require 'spec_helper'

describe User do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:highrise_access_token) }
    it { should validate_uniqueness_of(:email) }
    it { should_not allow_value("not_an_email").for(:email) }
    it { should_not allow_value("not@an-email").for(:email) }
    it { should allow_value("an@email.address").for(:email) }
    it { should_not allow_value("1234").for(:password) }
    it { should allow_value("12345").for(:password) }
  end

  describe "mass assignments" do
    it { should allow_mass_assignment_of(:name) }
    it { should allow_mass_assignment_of(:email) }
    it { should allow_mass_assignment_of(:password) }
    it { should allow_mass_assignment_of(:password_confirmation) }
    it { should_not allow_mass_assignment_of(:crypted_password) }
  end

  describe "#set_highrise_info" do
    let(:user){ create(:user) }
    let(:info){ double(:info) }
    before do
      info.stub(:email_address).and_return("an@email.address")
      info.stub(:name).and_return("John Smith")
      user.set_highrise_info(info)
    end
    subject { user }

    its(:email){ should == "an@email.address" }
    its(:name){ should == "John Smith" }
  end
end
