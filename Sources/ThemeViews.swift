import SwiftUI

struct AppBackground: View {
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(red: 0.02, green: 0.03, blue: 0.05), .black], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            Circle().fill(.cyan.opacity(0.16)).blur(radius: 90).frame(width: 260).offset(x: -150, y: -290)
            Circle().fill(.blue.opacity(0.12)).blur(radius: 90).frame(width: 300).offset(x: 160, y: 240)
        }
    }
}

struct GlassCard<Content: View>: View {
    let content: Content
    var glow: Bool

    init(glow: Bool = false, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.glow = glow
    }

    var body: some View {
        content
            .padding()
            .background(.ultraThinMaterial)
            .overlay(
                RoundedRectangle(cornerRadius: 22)
                    .stroke(.cyan.opacity(glow ? 0.50 : 0.18), lineWidth: 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: 22))
            .shadow(color: .cyan.opacity(glow ? 0.24 : 0.06), radius: glow ? 22 : 8)
    }
}

struct ConnectionPill: View {
    @EnvironmentObject var ble: DunenBLEManager
    var body: some View {
        HStack(spacing: 8) {
            Circle().fill(ble.isConnected ? .green : .red).frame(width: 8, height: 8)
            Text(ble.isConnected ? "Connected" : "Offline").font(.caption.weight(.semibold))
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 7)
        .background(.ultraThinMaterial)
        .clipShape(Capsule())
    }
}

struct LiquidTabBar: View {
    @Binding var selectedTab: AppTab

    var body: some View {
        HStack(spacing: 4) {
            ForEach(AppTab.allCases, id: \.rawValue) { tab in
                Button {
                    withAnimation(.spring(response: 0.32, dampingFraction: 0.78)) {
                        selectedTab = tab
                    }
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: tab.icon).font(.system(size: 16, weight: .semibold))
                        Text(tab.rawValue).font(.system(size: 9, weight: .semibold))
                    }
                    .foregroundStyle(selectedTab == tab ? .white : .white.opacity(0.58))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .background {
                        if selectedTab == tab {
                            Capsule().fill(.ultraThinMaterial).overlay(Capsule().stroke(.cyan.opacity(0.5), lineWidth: 1))
                        }
                    }
                }
                .buttonStyle(.plain)
            }
        }
        .padding(7)
        .background(.ultraThinMaterial)
        .overlay(Capsule().stroke(.white.opacity(0.18), lineWidth: 1))
        .clipShape(Capsule())
        .shadow(color: .black.opacity(0.5), radius: 20, y: 10)
    }
}
