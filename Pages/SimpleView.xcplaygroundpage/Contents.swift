import SwiftUI
import PlaygroundSupport

struct SimpleView0: View {
    var body: some View {
        Text("some View")
//            .foregroundColor(.white)
//            .padding()
//            .background(Color.blue)
            .mirror()
    } 
}


struct SimpleView1: View {
    var body: some View {
        Text(someView2)
            .font(.system(size: 14, design: .monospaced))
            .mirror()
    }
}


PlaygroundPage.current.setLiveView(SimpleView0())
