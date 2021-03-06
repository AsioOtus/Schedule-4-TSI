import UIKit
import LoggingUtil

extension App {
	@UIApplicationMain
	class Delegate: UIResponder, UIApplicationDelegate {
		private(set) static var current: Delegate!
		
		func application (_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
			LaunchCounter.default.next(cycle: Date().toFormat("HH:mm:ss"))
			LaunchCounter.default.launch()
			
			Logging.defaultLogger.notice("APPLICATION STARTED")
			
			Self.saveAppDelegateInstanceLink(application)
			
			App.Controller.current.handleApplicationStart()
			
			return true
		}
		
		func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
			return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
		}
		
		func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) { }
	}
}

extension App.Delegate {
	private static func saveAppDelegateInstanceLink (_ application: UIApplication) {
		guard let appDelegate = application.delegate as? App.Delegate else { fatalError("Cannot cast application delegate to type App.Delegate") }
		current = appDelegate
	}
}
