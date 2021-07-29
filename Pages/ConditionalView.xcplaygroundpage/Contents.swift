import SwiftUI
import PlaygroundSupport

struct ConditionalView: View {
    @State private var on = false
    var body: some View {
        VStack {
            if on {
                Text("On2")
            } else {
                Text("Off2")
            }

//            Text(on ? "On" : "off")
        }
        .mirror()
        .onTapGesture { on.toggle() }
    }
}

PlaygroundPage.current.setLiveView(ConditionalView())
