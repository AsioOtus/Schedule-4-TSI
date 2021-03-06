import SwiftUI
import Combine

extension Schedule.Table.EventView {
	struct ItemsView <TextViewModifier: ViewModifier>: View {
		let items: LoadingState<Void, [Schedule.Event.Info.Display.ItemState]>
		let textModifier: TextViewModifier
		
		init (items: LoadingState<Void, [Schedule.Event.Info.Display.ItemState]>, textModifier: TextViewModifier) {
			self.items = items
			self.textModifier = textModifier
		}
		
		var body: some View {
			switch items {
			case .notInitialized:
				placeholderView.background(Color.green)
				
			case .loading:
				placeholderView.background(Color.blue)
				
			case .loaded(let items):
				let enumeratedItems = items.enumerated().map{ index, item in (loopIndex: index, item: item) }
				ForEach(enumeratedItems, id: \.loopIndex) { (loopIndex, item) in
					ItemView(item: item, textModifier: textModifier)
				}
				
			case .failed(_):
				placeholderView.background(Color.red)
			}
		}
		
		var placeholderView: some View {
			Rectangle().size(width: 100, height: 20)
		}
	}
}
