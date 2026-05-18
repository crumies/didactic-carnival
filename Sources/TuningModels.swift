import Foundation
import SwiftUI

enum TuningKind: String, Codable {
    case toggle
    case number
    case readOnly
}

enum TuningGroup: String, CaseIterable, Codable {
    case common = "Common"
    case safety = "Safety"
    case power = "Power"
    case speed = "Speed"
    case advanced = "Advanced"
}

struct TuningParameter: Identifiable, Codable, Equatable {
    var id: Int
    var internalName: String
    var displayName: String
    var detail: String
    var group: TuningGroup
    var kind: TuningKind
    var min: Double
    var max: Double
    var currentValue: Double?
    var originalValue: Double?
    var pendingValue: Double?
    var isRisky: Bool

    var loaded: Bool { currentValue != nil }
    var hasChange: Bool {
        guard let currentValue, let pendingValue else { return false }
        return abs(currentValue - pendingValue) > 0.0001
    }

    static let defaults: [TuningParameter] = [
        .init(id: 99, internalName: "PIDLLDTorqCurveSet1", displayName: "Side Support Sensor", detail: "Kickstand/side support function. 0 disabled, 1 enabled.", group: .safety, kind: .toggle, min: 0, max: 1, currentValue: nil, originalValue: nil, pendingValue: nil, isRisky: false),
        .init(id: 100, internalName: "PIDLLDTorqCurveSet2", displayName: "Anti-Theft Function", detail: "Anti-theft logic. 0 disabled, 1 enabled.", group: .safety, kind: .toggle, min: 0, max: 1, currentValue: nil, originalValue: nil, pendingValue: nil, isRisky: false),
        .init(id: 101, internalName: "PIDLLDTorqCurveSet3", displayName: "Electronic Braking", detail: "Electronic/regen braking function. 0 disabled, 1 enabled.", group: .common, kind: .toggle, min: 0, max: 1, currentValue: nil, originalValue: nil, pendingValue: nil, isRisky: true),
        .init(id: 104, internalName: "PIDLLDTorqCurveSet6", displayName: "Steep Slope Descent", detail: "Hill descent assist. 0 disabled, 1 enabled.", group: .common, kind: .toggle, min: 0, max: 1, currentValue: nil, originalValue: nil, pendingValue: nil, isRisky: true),
        .init(id: 211, internalName: "FunParm2", displayName: "Anti Sliding Slope", detail: "Rollback/anti-slide on slopes. 0 disabled, 1 enabled.", group: .common, kind: .toggle, min: 0, max: 1, currentValue: nil, originalValue: nil, pendingValue: nil, isRisky: true),
        .init(id: 212, internalName: "FunParm3", displayName: "Cruise Control", detail: "Cruise enable. 0 disabled, 1 enabled.", group: .common, kind: .toggle, min: 0, max: 1, currentValue: nil, originalValue: nil, pendingValue: nil, isRisky: false),
        .init(id: 213, internalName: "FunParm4", displayName: "P-Gear Function", detail: "Parking gear function. 0 disabled, 1 enabled.", group: .safety, kind: .toggle, min: 0, max: 1, currentValue: nil, originalValue: nil, pendingValue: nil, isRisky: false),

        .init(id: 3, internalName: "UserParm2", displayName: "Battery Discharge Current Limit", detail: "Current limit from UserParm2.", group: .power, kind: .number, min: 0, max: 1000, currentValue: nil, originalValue: nil, pendingValue: nil, isRisky: true),
        .init(id: 4, internalName: "UserParm3", displayName: "Battery Feeding Current Limit", detail: "Battery feeding/regen current limit.", group: .power, kind: .number, min: 0, max: 100, currentValue: nil, originalValue: nil, pendingValue: nil, isRisky: true),
        .init(id: 35, internalName: "MotorParm2", displayName: "Peak Phase Current Limit", detail: "Peak phase current output limit.", group: .power, kind: .number, min: 0, max: 2000, currentValue: nil, originalValue: nil, pendingValue: nil, isRisky: true),
        .init(id: 253, internalName: "MiscParm28", displayName: "Boost Current", detail: "Boost current value.", group: .power, kind: .number, min: 0, max: 20, currentValue: nil, originalValue: nil, pendingValue: nil, isRisky: true),

        .init(id: 6, internalName: "UserParm5", displayName: "High Speed Mode RPM", detail: "Forward high-speed mode motor speed.", group: .speed, kind: .number, min: 0, max: 9000, currentValue: nil, originalValue: nil, pendingValue: nil, isRisky: true),
        .init(id: 7, internalName: "UserParm6", displayName: "Medium Speed Mode RPM", detail: "Forward medium-speed mode motor speed.", group: .speed, kind: .number, min: 0, max: 9000, currentValue: nil, originalValue: nil, pendingValue: nil, isRisky: true),
        .init(id: 8, internalName: "UserParm7", displayName: "Low Speed Mode RPM", detail: "Forward low-speed mode motor speed.", group: .speed, kind: .number, min: 0, max: 9000, currentValue: nil, originalValue: nil, pendingValue: nil, isRisky: true),
        .init(id: 9, internalName: "UserParm8", displayName: "Reverse Speed Limit", detail: "Reverse gear motor speed limit.", group: .speed, kind: .number, min: 0, max: 9000, currentValue: nil, originalValue: nil, pendingValue: nil, isRisky: true),

        .init(id: 52, internalName: "ProtectParm3", displayName: "Overvoltage Threshold", detail: "Overvoltage protection threshold V.", group: .safety, kind: .number, min: 30, max: 120, currentValue: nil, originalValue: nil, pendingValue: nil, isRisky: true),
        .init(id: 53, internalName: "ProtectParm4", displayName: "Undervoltage Threshold", detail: "Undervoltage protection threshold V.", group: .safety, kind: .number, min: 10, max: 95, currentValue: nil, originalValue: nil, pendingValue: nil, isRisky: true),
        .init(id: 62, internalName: "ProtectParm13", displayName: "Voltage Derating Start", detail: "Voltage derating start threshold.", group: .safety, kind: .number, min: 0, max: 100, currentValue: nil, originalValue: nil, pendingValue: nil, isRisky: true),

        .init(id: 16, internalName: "UserParm15", displayName: "Throttle Upper Limit", detail: "Upper throttle signal limit.", group: .advanced, kind: .number, min: 0, max: 4096, currentValue: nil, originalValue: nil, pendingValue: nil, isRisky: true),
        .init(id: 17, internalName: "UserParm16", displayName: "Throttle Lower Limit", detail: "Lower throttle signal limit.", group: .advanced, kind: .number, min: 0, max: 4096, currentValue: nil, originalValue: nil, pendingValue: nil, isRisky: true),
        .init(id: 13, internalName: "UserParm12", displayName: "Number of Motor Poles", detail: "Motor pole count.", group: .advanced, kind: .number, min: 0, max: 100, currentValue: nil, originalValue: nil, pendingValue: nil, isRisky: true),
        .init(id: 248, internalName: "MiscParm23", displayName: "Battery Rated Voltage", detail: "0 = 72V, 1 = 60V according to screenshot.", group: .advanced, kind: .number, min: 0, max: 2, currentValue: nil, originalValue: nil, pendingValue: nil, isRisky: true)
    ]
}
