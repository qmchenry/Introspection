import SwiftUI
import PlaygroundSupport

struct StacksView: View {
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                Text("1")
                Text("2")
                Text("3")
                Text("4")
                Text("5")
            }
            .mirror()
        }
    }
}


PlaygroundPage.current.setLiveView(StacksView())
