import SwiftUI

struct StartupSplash: View {
    @State private var wheels = false
    @State private var light = false

    var body: some View {
        ZStack {
            AppBackground()

            VStack(spacing: 24) {
                AptumBikeImage()
                    .frame(width: 340, height: 205)
                    .shadow(color: .cyan.opacity(0.35), radius: 22)

                ZStack {
                    Circle()
                        .trim(from: 0.08, to: 0.34)
                        .stroke(.cyan, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                        .frame(width: 82, height: 82)
                        .rotationEffect(.degrees(wheels ? 720 : 0))
                        .offset(x: -120, y: -80)

                    Circle()
                        .trim(from: 0.08, to: 0.34)
                        .stroke(.cyan, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                        .frame(width: 80, height: 80)
                        .rotationEffect(.degrees(wheels ? 720 : 0))
                        .offset(x: 110, y: -80)

                    Capsule()
                        .fill(.cyan.opacity(light ? 0.85 : 0.1))
                        .frame(width: 95, height: 10)
                        .blur(radius: 9)
                        .offset(x: -150, y: -178)
                }
                .frame(height: 0)

                Text("APTUM DASHBOARD")
                    .font(.system(size: 27, weight: .heavy, design: .rounded))
                    .tracking(4)
                    .foregroundStyle(.white)

                Text("Connecting to FFE0")
                    .font(.headline.weight(.semibold))
                    .foregroundStyle(.cyan)
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 1.1).repeatForever(autoreverses: false)) {
                wheels = true
            }
            withAnimation(.easeInOut(duration: 0.16).repeatCount(4, autoreverses: true).delay(0.35)) {
                light = true
            }
        }
    }
}
