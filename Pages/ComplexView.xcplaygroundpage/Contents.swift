import SwiftUI
import PlaygroundSupport

struct ComplexView: View {
    var body: some View {
        Meter(type: .oxygen, selectedId: .constant(8))
            .frame(width: 600, height: 120)
            .mirror()
    }
}

PlaygroundPage.current.setLiveView(ComplexView())

/// Meter's mirror shows: ```GeometryReader<VStack<TupleView<(ModifiedContent<Text, _PaddingLayout>, ModifiedContent<ModifiedContent<ZStack<TupleView<(ZStack<TupleView<(ModifiedContent<HStack<ForEach<Array<MeterValue>, Int, MeterLabel>>, _PreferenceActionModifier<MeterLabelPreferenceKey>>, ModifiedContent<_ShapeView<_StrokedShape<RoundedRectangle>, LinearGradient>, _FrameLayout>)>>, ModifiedContent<ModifiedContent<ModifiedContent<ModifiedContent<ModifiedContent<ModifiedContent<Chrome, _ShadowEffect>, _FrameLayout>, _OffsetEffect>, _TransactionModifier>, _ContentShapeModifier<OffsetShape<Rectangle>>>, AddGestureModifier<_EndedGesture<_ChangedGesture<DragGesture>>>>)>>, _CoordinateSpaceModifier<String>>, _PaddingLayout>)>>>```
