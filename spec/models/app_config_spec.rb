require 'spec_helper'

describe AppConfig do
  before(:each) do
    @ac = FactoryGirl.build(:app_config)
  end
  it "has a working factory" do
    @ac.save.should be_true
  end
  it "does not accept empty site title" do
    @ac.site_title = nil
    @ac.should_not be_valid
    @ac.site_title = " "
    @ac.should_not be_valid
  end
  it "does not accept too long a site title" do
    @ac.site_title = "AaaaaBbbbbCccccDddddEeeee"
    @ac.should_not be_valid
  end
  it "shouldn't have an invalid e-mail" do
    emails = ["ana@com", "anda@pres,com", nil, " "]
    emails.each do |invalid|
      @ac.admin_email = invalid
      @ac.should_not be_valid
    end
  end
  it "should have a valid and present e-mail" do
    @ac.admin_email = "ana@yale.edu"
    @ac.should be_valid
  end
  # it "has an attachment that could serve as favicon" do
  #   @ac.favicon_file_name = "icon.ico"
  #   @ac.should be_valid
  # end
  # it "does not accept a missing favicon" do
  #   @ac.favicon_file_name = ""
  #   @ac.should_not be_valid
  # end
  it "has an attachment that is of the favicon format" do
    types = ["image/gif", "image/jpeg", "image/png"]
    types.each do |invalid|
      @ac.favicon_content_type = invalid
      @ac.should_not be_valid
    end
    @ac.favicon_content_type = "image/vnd.microsoft.icon"
  end
end
