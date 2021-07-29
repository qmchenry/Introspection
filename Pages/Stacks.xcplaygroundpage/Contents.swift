import SwiftUI
import PlaygroundSupport

struct StacksView: View {
    var body: some View {
        ScrollView(.horizontal) {
            VStack {
                Text("1")
                Text("2")
                Text("3")
                Text("4")
                Text("5")
                Text("6")
                Text("7")
                Text("8")
                Text("9")
                Text("10")
            }
            .mirror()
        }
    }
}


PlaygroundPage.current.setLiveView(StacksView())
