module IntegrationMacros
  def log_in(email, password)
    visit("/session/new")
    fill_in "Email", :with => email
    fill_in "Password", :with => password
    click_button "Sign in"
  end
end
