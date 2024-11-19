import Foundation

func fileWrite(filePath: String, fileData: String) {
    let fileURL: URL = URL(fileURLWithPath: filePath)
    try? fileData.write(to: fileURL, atomically: true, encoding: .utf8)
}

let arguments: [String] = CommandLine.arguments
let filePath: String = arguments[1]
let fileData: String = arguments[2]
fileWrite(filePath: filePath, fileData: fileData)