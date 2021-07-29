import SwiftUI

public struct Chrome: View {
    let cornerRadius: CGFloat
    public var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .strokeBorder(lineWidth: cornerRadius/2, antialiased: true)
            .foregroundColor(Color(red: 192, green: 192, blue: 192))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(lineWidth: 2)
                    .blur(radius: 2)
                    .mask(RoundedRectangle(cornerRadius: cornerRadius))
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius/2)
                    .stroke(lineWidth: 2)
                    .blur(radius: 2)
                    .padding(6)
                    .mask(RoundedRectangle(cornerRadius: cornerRadius/2))
            )
    }
}

public struct Meter: View {
    let valueType: MeterValue.ValueType
    @Binding var selectedId: Int
    @State private var rects: [CGRect]
    @State private var dragOffset = CGFloat(0)
    @State private var isDragging = false
    @State private var draggingSelectedId = 0

    public init(type: MeterValue.ValueType, selectedId: Binding<Int>) {
        valueType = type
        _selectedId = selectedId
        rects = Array<CGRect>(repeating: CGRect(), count: valueType.values.count)
    }

    private let gradient = LinearGradient(colors: [Color(white: 0.6), Color(white: 0.45)], startPoint: UnitPoint(x: 0.25, y: 0), endPoint: UnitPoint(x: 0.75, y: 1))
    private let gradientDark = LinearGradient(colors: [Color(white: 0.1), Color(white: 0.35)], startPoint: UnitPoint(x: 0.45, y: 0), endPoint: UnitPoint(x: 0.55, y: 1))

    public var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .leading) {
                Text(valueType.title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                ZStack(alignment: .leading) {
                    ZStack {
                        HStack(alignment: .center, spacing: 0) {
                            ForEach(valueType.values, id: \.id) { value in
                                MeterLabel(activeId: $selectedId, value: value)
                            }
                        }
                        .onPreferenceChange(MeterLabelPreferenceKey.self) { preferences in
                            for p in preferences {
                                self.rects[p.viewIdx] = p.rect
                            }
                        }
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(gradientDark, lineWidth: 4)
                            .frame(height: 50)
                    }
                    Chrome(cornerRadius: 12)
                        .shadow(color: .black, radius: 3, x: 1, y: 2)
                        .frame(width: rects[selectedId].size.width, height: rects[selectedId].size.height)
                        .offset(markerOffset)
                        .animation(.spring())
                        .contentShape(Rectangle().offset(markerOffset))
                        .gesture(dragGesture)
                }
                .coordinateSpace(name: "meterZstack")
                .padding(.horizontal, 10)
            }
        }
    }

    var markerOffset: CGSize {
        CGSize(width: isDragging ? dragOffset : rects[selectedId].minX, height: rects[selectedId].minY)
    }

    var dragGesture: some Gesture {
        DragGesture()
            .onChanged { gesture in
                if !isDragging {
                    isDragging = true
                    draggingSelectedId = selectedId
                }
                dragOffset = rects[draggingSelectedId].midX + gesture.translation.width
                let closest = rects.enumerated()
                    .map { rect in (abs(rect.1.midX - dragOffset), rect.0) }
                    .sorted { $0.0 < $1.0 }
                    .first
                if let newSelected = closest?.1, newSelected != selectedId {
                    // Haptics.generate()
                    selectedId = newSelected
                }
            }
            .onEnded { _ in
                isDragging = false
            }
    }
}

public struct MeterValue {
    let id: Int
    let name: String
    let color: Color

    public enum ValueType {
        case temperature
        case oxygen

        public var values: [MeterValue] {
            switch self {
            case .temperature:
                return MeterValue.temperatures
            case .oxygen:
                return MeterValue.oxygens
            }
        }

        public var title: String {
            switch self {
            case .temperature:
                return "Temperature"
            case .oxygen:
                return "Oxygen concentration"
            }
        }
    }
}

public struct MeterLabelPreferenceKey: PreferenceKey {
    public typealias Value = [MeterLabelPreferenceData]

    public static var defaultValue: [MeterLabelPreferenceData] = []

    public static func reduce(value: inout [MeterLabelPreferenceData], nextValue: () -> [MeterLabelPreferenceData]) {
        value.append(contentsOf: nextValue())
    }
}

public struct MeterLabelPreferenceData: Equatable {
    let viewIdx: Int
    let rect: CGRect
}

public struct PreferenceViewSetter: View {
    let index: Int

    public var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(Color.clear)
                .preference(key: MeterLabelPreferenceKey.self,
                            value: [MeterLabelPreferenceData(viewIdx: self.index, rect: geometry.frame(in: .named("meterZstack")))])
        }
    }
}

public struct MeterLabel: View {
    @Binding var activeId: Int
    let value: MeterValue
    public var body: some View {
        Text(value.name)
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(value.color)
            .background(PreferenceViewSetter(index: value.id))
            .onTapGesture {
                self.activeId = value.id
                // Haptics.generate()
            }
    }
}

extension MeterValue {
    public static var temperatures: [Self] {
        [
            .init(id: 0, name: "-30º", color: .purple),
            .init(id: 1, name: "-28º", color: .purple),
            .init(id: 2, name: "-26º", color: .purple),
            .init(id: 3, name: "-24º", color: .purple),
            .init(id: 4, name: "-22º", color: .purple),
            .init(id: 5, name: "-20º", color: .purple),
            .init(id: 6, name: "-18º", color: .red),
            .init(id: 7, name: "-16º", color: .red),
            .init(id: 8, name: "-14º", color: .red),
            .init(id: 9, name: "-12º", color: .red),
            .init(id: 10, name: "-10º", color: .red),
            .init(id: 11, name: "-8º", color: .yellow),
            .init(id: 12, name: "-6º", color: .yellow),
            .init(id: 13, name: "-4º", color: .yellow),
            .init(id: 14, name: "-2º", color: .yellow),
            .init(id: 15, name: "-0º", color: .yellow),
            .init(id: 16, name: "2º", color: .white),
            .init(id: 17, name: "4º", color: .white),
            .init(id: 18, name: "6º", color: .white),
            .init(id: 19, name: "8º", color: .white)
        ]
    }

    public static var oxygens: [Self] {
        [
            .init(id: 0, name: "0%", color: .purple),
            .init(id: 1, name: "1%", color: .purple),
            .init(id: 2, name: "2%", color: .purple),
            .init(id: 3, name: "3%", color: .red),
            .init(id: 4, name: "4%", color: .red),
            .init(id: 5, name: "5%", color: .red),
            .init(id: 6, name: "6%", color: .red),
            .init(id: 7, name: "7%", color: .yellow),
            .init(id: 8, name: "8%", color: .yellow),
            .init(id: 9, name: "9%", color: .yellow),
            .init(id: 10, name: "10%", color: .yellow),
            .init(id: 11, name: "11%", color: .yellow),
            .init(id: 12, name: "12%", color: .white),
            .init(id: 13, name: "13%", color: .white),
            .init(id: 14, name: "14%", color: .white)
        ]
    }
}
