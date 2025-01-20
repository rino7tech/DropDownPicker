import SwiftUI

struct DropDownView: View {
    var hint: String
    var options: [String]
    var maxWidth: CGFloat = 180
    var cornerRadius: CGFloat = 15
    @Binding var selection: String?
    @State private var showOptions: Bool = false
    @Environment(\.colorScheme) private var scheme

    var body: some View {
        GeometryReader {
            let size = $0.size

            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Text(selection ?? hint)
                        .foregroundStyle(selection == nil ? .gray : .primary)
                        .lineLimit(1)

                    Spacer(minLength: 0)

                    Image(systemName: "chevron.down")
                        .font(.title3)
                        .foregroundStyle(.gray)
                        .rotationEffect(.init(degrees: showOptions ? -180 : 0))
                }
                .padding(.horizontal, 15)
                .frame(width: size.width, height: size.height)
                .background(scheme == .dark ? .black : .white)
                .contentShape(.rect)
                .onTapGesture {
                    withAnimation(.snappy) {
                        showOptions.toggle()
                    }
                }
                .zIndex(10)

                if showOptions {
                    OptionsView()
                }
            }
            .clipped()
            .background((scheme == .dark ? Color.black : Color.white).shadow(.drop(color: .primary.opacity(0.15), radius: 4)), in: .rect(cornerRadius: cornerRadius))
            .frame(height: size.height, alignment: .top)
        }
        .frame(width: maxWidth, height: 50)
    }

    @ViewBuilder
    func OptionsView() -> some View {
        VStack(spacing: 15) { // ここで選択肢の間隔を広げる
            ForEach(options, id: \.self) { option in
                HStack(spacing: 0) {
                    Text(option)
                        .lineLimit(1)
                    Spacer(minLength: 0)

                    Image(systemName: "checkmark")
                        .font(.caption)
                        .opacity(selection == option ? 1 : 0)
                }
                .foregroundStyle(selection == option ? Color.primary : Color.gray)
                .animation(.none, value: selection)
                .frame(width: 100, height: 40) // 縦幅の間隔を増やす
                .contentShape(.rect)
                .onTapGesture {
                    withAnimation(.snappy) {
                        selection = option
                        showOptions = false
                    }
                    print(option) // タップした選択肢を出力
                }
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .transition(.move(edge: .top)) // 上から下にスライドするアニメーション
    }

    enum Anchor {
        case top
        case bottom
    }
}
