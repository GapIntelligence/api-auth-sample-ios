class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    @sessions_controller = SessionsController.alloc.init

    @navigation_controller = UINavigationController.alloc.init
    @navigation_controller.pushViewController(@sessions_controller, animated:false)

    @window.rootViewController = @navigation_controller
    @window.makeKeyAndVisible

    true
  end
end
