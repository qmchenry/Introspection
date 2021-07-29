import SwiftUI
import PlaygroundSupport

struct ButtonView: View {
    @State private var on = false
    var body: some View {
        Button { on.toggle() }
            label: {
                Image(systemName: on ? "power" : "poweroff")
                on ? Text("On") : Text("Off")
            }
        .mirror()
        .padding()
    }
}

PlaygroundPage.current.setLiveView(ButtonView())
