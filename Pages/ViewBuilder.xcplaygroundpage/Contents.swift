import SwiftUI
import PlaygroundSupport

struct ViewBuilderView: View {
    @State private var on = false
    var body: some View {
        eitherOr()
            .mirror() 
            .onTapGesture { on.toggle() }
    }

    @ViewBuilder
    func eitherOr() -> some View {
        if on {
            Text("on")
        } else {
            Image(systemName: "poweroff")
        }
    }
}

PlaygroundPage.current.setLiveView(ViewBuilderView())
