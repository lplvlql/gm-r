import Foundation
import CoreGraphics

func appWindowID(appName: String, windowIndex: Int = 0) -> Int {
    var windowIndex: Int = windowIndex
    
    let options: CGWindowListOption = [.optionOnScreenOnly, .optionIncludingWindow]
    let windowList: [[String : Any]] = CGWindowListCopyWindowInfo(options, kCGNullWindowID) as! [[String: Any]]
    
    for window: [String : Any] in windowList {
        let windowName: String = window[kCGWindowOwnerName as String] as? String ?? ""
        let windowID: CGWindowID = window[kCGWindowNumber as String] as? CGWindowID ?? 0

        if windowName != appName { continue }
        if windowIndex == 0 { return Int(windowID) }
        windowIndex -= 1
    }
    
    return 0;
}

let arguments: [String] = CommandLine.arguments

let appName: String = arguments[1]
let windowIndex: Int = (arguments.count > 2) ? Int(arguments[2]) ?? 0 : 0
let windowID: Int = appWindowID(appName: appName, windowIndex: windowIndex)

print(windowID)
