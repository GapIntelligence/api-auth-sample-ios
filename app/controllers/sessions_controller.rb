class SessionsController < UIViewController
  def viewDidLoad
    super
    self.title = 'Sample Login'
    self.view.backgroundColor = UIColor.whiteColor

    @login_form = LoginFormView.build_login_form
    @login_form.login_button.addTarget(self, action: "login", forControlEvents: UIControlEventTouchUpInside)

    self.view.addSubview @login_form
  end

  def login
    api_client.token(@login_form.username.text, @login_form.password.text) do |result|
      if result['access_token']
        user.save_token(@login_form.username.text, result['access_token'])

        display_message "Welcome", "Welcome #{@login_form.username.text}."
      else
        display_message "Error", "Invalid Credentials."
      end
    end
  end

  def display_message(title, message)
    alert_box = UIAlertView.alloc.initWithTitle(title, 
                                                message: message,
                                                delegate: nil,
                                                cancelButtonTitle: "Ok",
                                                otherButtonTitles:nil)
    alert_box.show
  end

  def api_client
    @api_client ||= ApiClient.new
  end

  def user
    @user ||= User.new
  end
end