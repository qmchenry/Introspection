import SwiftUI
import PlaygroundSupport

struct Introduction: View {
    var body: some View {
        VStack(spacing: 20) {
            Text(someView2)
            Text("Based on \nhttps://www.hackingwithswift.com/books/ios-swiftui/why-does-swiftui-use-some-view-for-its-view-type")

            Text("Strongly leveraging \nhttps://gist.github.com/chriseidhof/d23f82f8a9e85e75bc02be220326199a")
        }
        .font(.system(size: 12, design: .monospaced))
        .padding()
    }
}

PlaygroundPage.current.setLiveView(Introduction())
