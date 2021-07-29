import SwiftUI
import PlaygroundSupport

struct ForEachView: View {
    let things = ["🐱", "🐶", "🙈", "🐻", "🦊"]
    var body: some View {
        ForEach(things, id: \.self) { thing in
            Text(thing)
        }
        .mirror()
    }
}

PlaygroundPage.current.setLiveView(ForEachView())
