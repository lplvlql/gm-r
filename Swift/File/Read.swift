import Foundation

func fileRead(filePath: String) -> String? {
    let fileURL: URL = URL(fileURLWithPath: filePath)
    guard let fileData: String = try? String(contentsOf: fileURL, encoding: .utf8) else {
        return nil
    }
    return fileData
}

let arguments: [String] = CommandLine.arguments
let filePath: String = arguments[1]
let fileData: String = fileRead(filePath: filePath) ?? ""
print(fileData)
