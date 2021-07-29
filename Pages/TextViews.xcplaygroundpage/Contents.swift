import SwiftUI
import PlaygroundSupport

struct TextViews: View {
    var body: some View {
        texts
            .mirror()
            .padding()
    }

    var texts: some View {
        Text("Hello ")
            .foregroundColor(.blue)
        + Text("Small ")
            .font(.largeTitle)
        + Text("Planet")
            .foregroundColor(.green)
    }
}


PlaygroundPage.current.setLiveView(TextViews())
