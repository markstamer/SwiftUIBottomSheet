import SwiftUI

enum BottomSheetState: Int, CaseIterable {
    case condensed
    case normal
    case expanded

    var height: CGFloat {
        switch self {
        case .condensed: return 60
        case .normal: return 300
        case .expanded: return 600
        }
    }
}

extension BottomSheetState {

    static func headingToState(fromHeight height: CGFloat, relativePredictedEndTranslation translation: CGSize) -> BottomSheetState {
        switch translation.height {
        case let y where y < -100:
            return (height > BottomSheetState.normal.height) ? .expanded : .normal
        case let y where y > 100:
            return (height < BottomSheetState.normal.height) ? .condensed : .normal
        default:
            return Self.closestState(toHeight: height)
        }
    }

    static func closestState(toHeight height: CGFloat) -> BottomSheetState {
        BottomSheetState.allCases.enumerated().min(by: { first, second in
            abs(first.element.height - height) < abs(second.element.height - height)
        })!.element
    }
}
