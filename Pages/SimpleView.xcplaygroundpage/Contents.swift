import SwiftUI
import PlaygroundSupport

struct SimpleView: View {
    var body: some View {
        Text("some View")
//            .foregroundColor(.white)
//            .padding()
//            .background(Color.blue)
            .mirror()
    } 
}


PlaygroundPage.current.setLiveView(SimpleView())
