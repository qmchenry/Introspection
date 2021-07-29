import SwiftUI
import PlaygroundSupport

struct SwitchView: View {
    @State private var thing = 0
    var body: some View {
        Group {
            switch thing {
            case 0:
                Text("One!")
            case 1:
                Text("B!")
            case 2:
                Text("iii!")
            default:
                Image(systemName: "scribble.variable")
            }
        }
        .mirror()
        .onTapGesture {
            thing = (thing + 1) % 4
        }
    }
}

PlaygroundPage.current.setLiveView(SwitchView())
