import SwiftUI

struct BottomSheet<Content: View>: View {

    @Binding var state: BottomSheetState
    @State var height: CGFloat = BottomSheetState.normal.height // The height above the bottom within it's parent view

    let content: Content

    init(state: Binding<BottomSheetState>, @ViewBuilder content: () -> Content) {
        self._state = state
        self.content = content()
    }

    var dragHandle: some View {
        Color.yellow
            .clipShape(RoundedRectangle(cornerRadius: 2))
            .frame(width: 44, height: 4, alignment: .center)
            .padding()
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.gray

                VStack {
                    self.dragHandle
                    self.content
                    Spacer()
                }
            }
            .cornerRadius(15)
            .frame(height: geometry.size.height, alignment: .bottom)
            .offset(CGSize(width: 0, height: geometry.size.height - self.height))
            .highPriorityGesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .global)
                    .onChanged { value in
                        print(value.translation)
                        self.height = min(BottomSheetState.expanded.height, max(BottomSheetState.condensed.height, self.state.height - value.translation.height))
                }
                .onEnded { value in
                    let animation: Animation
                    if abs(value.predictedEndTranslation.height) > 400 {
                        animation = .interactiveSpring(response: 0.2, dampingFraction: 0.8, blendDuration: 0.25)
                        print("fast")
                    } else {
                        animation = .interactiveSpring(response: 0.3, dampingFraction: 1.0, blendDuration: 0.25)
                        print("slow")
                    }
                    withAnimation(animation) {
                        let state: BottomSheetState = .headingToState(fromHeight: self.height, relativePredictedEndTranslation: value.predictedEndTranslation)
                        self.height = state.height
                        self.state = state
                    }
                }
            )
        }
    }
}
