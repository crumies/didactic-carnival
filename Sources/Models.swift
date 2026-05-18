import Foundation
import SwiftUI

enum AppTab: String, CaseIterable {
    case dashboard = "Dash"
    case advanced = "Info"
    case tuning = "Tuning"
    case diagnostics = "Diag"
    case settings = "Settings"

    var icon: String {
        switch self {
        case .dashboard: return "gauge.with.dots.needle.bottom.50percent"
        case .advanced: return "list.bullet.rectangle"
        case .tuning: return "slider.horizontal.3"
        case .diagnostics: return "waveform.path.ecg.rectangle"
        case .settings: return "gearshape.fill"
        }
    }
}

enum SpeedUnit: String, CaseIterable, Identifiable {
    case kmh = "KM/H"
    case mph = "MPH"
    var id: String { rawValue }
}

final class AppSettings: ObservableObject {
    @AppStorage("speedUnit") var speedUnitRaw: String = SpeedUnit.kmh.rawValue
    @AppStorage("startupAnimation") var startupAnimation: Bool = true
    @AppStorage("showRawPackets") var showRawPackets: Bool = true
    @AppStorage("expertTuningUnlocked") var expertTuningUnlocked: Bool = false

    var speedUnit: SpeedUnit {
        get { SpeedUnit(rawValue: speedUnitRaw) ?? .kmh }
        set { speedUnitRaw = newValue.rawValue }
    }
}

struct Telemetry: Equatable {
    var speedKmh: Double = 0
    var rpm: Int = 0
    var voltage: Double = 0
    var odometerKm: Double = 0
    var warningCode: Int = 0
    var errorCode: Int = 0
    var dcCurrent: Double = 0
    var phaseCurrent: Double = 0
    var phaseVoltage: Double = 0
    var motorAngle: Int = 0
    var torque: Double = 0
    var zeroAngle: Int = 0
    var motorTemp: Double = 0
    var controllerTemp: Double = 0
    var rawHex: String = ""
    var packetCount: Int = 0
    var productModel: String = "DEMCC2416QS035ZFS01"
    var controllerName: String = "DUNEN312"
}
