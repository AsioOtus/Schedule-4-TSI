import SwiftUI

extension UIColor {
	var color: Color { Color(self) }
	
	static func from (resource name: String) -> UIColor {
		UIColor(named: name).unwrap("ColorGroup – Cannot create instnace of UIColor with resource name \"\(name)\"")
	}
}
