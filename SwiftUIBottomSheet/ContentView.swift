import SwiftUI

struct Ball: View {
    @State var color: Color

    var body: some View {
        color
            .clipShape(Circle())
            .frame(width: 100, height: 100)
    }
}

struct ContentView: View {

    @State var bottomSheetState: BottomSheetState = .normal

    var content: some View {
//        ScrollView {
            VStack() {
                ForEach(1...5, id: \.self) {
                    Ball(color: Color.yellow.opacity(1.0/Double($0)))
                }
                Text("Nullam quis risus eget urna mollis ornare vel eu leo. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam quis risus eget urna mollis ornare vel eu leo. Morbi leo risus, porta ac consectetur ac, vestibulum at eros.")
                    .foregroundColor(Color.white.opacity(0.8))
                    .padding()
            }
//        }
    }

    var body: some View {
            ZStack {
                Color.pink.opacity(0.25)
                BottomSheet(state: self.$bottomSheetState) {
                    self.content
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
