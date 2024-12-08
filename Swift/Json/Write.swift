import Foundation

func jsonWrite(jsonObject: inout Any, path: [String], value: Any) {
    guard let key: String = path.first else {
        return
    }

    if path.count == 1 {
        guard var jsonDict: [String: Any] = jsonObject as? [String: Any] else {
            return
        }

        jsonDict[key] = value
        jsonObject = jsonDict
        return
    }

    let conditionTokens: [String.SubSequence] = key.split(separator: "==")
    if conditionTokens.count == 2 {
        let conditionKey: String = String(conditionTokens[0])
        let conditionValue: String = String(conditionTokens[1])

        guard var jsonArray: [[String: Any]] = jsonObject as? [[String: Any]] else {
            return
        }

        guard let jsonArrayIndex: Int = jsonArray.firstIndex(where: { $0[conditionKey] as? String == conditionValue }) else {
            return
        }

        var nestedObject: Any = jsonArray[jsonArrayIndex]
        jsonWrite(jsonObject: &nestedObject, path: Array(path.dropFirst()), value: value)

        jsonArray[jsonArrayIndex] = nestedObject as! [String: Any]
        jsonObject = jsonArray
    }
    else {
        
        guard var jsonDict: [String: Any] = jsonObject as? [String: Any] else {
            return
        }

        var nestedObject: Any = jsonDict[key] ?? [:]
        jsonWrite(jsonObject: &nestedObject, path: Array(path.dropFirst()), value: value)

        jsonDict[key] = nestedObject
        jsonObject = jsonDict
    }
}

let arguments: [String] = CommandLine.arguments
guard arguments.count >= 5 else {
    print("Usage: jsonUpdater <jsonString> <dataPath> <value>")
    exit(1)
}

var jsonString: String = arguments[1]
let dataPath: String = arguments[2]
var value: Any = arguments[3]
let type: String = arguments[4]

// parse json
guard !jsonString.isEmpty else {
    print("Error: JSON string is empty.")
    exit(1)
}

guard var jsonData: Data = jsonString.data(using: .utf8) else {
    print("Error: Unable to convert JSON string to data.")
    exit(1)
}

guard var jsonObject: Any = try? JSONSerialization.jsonObject(with: jsonData, options: []) else {
    print("Error: Invalid JSON format.")
    exit(1)
}

// parse path to array
let dataPathArray: [String] = dataPath.split(separator: ".").map(String.init)

// cast value
switch (type) {
    case "int":
        value = Int(arguments[3]) ?? 0
    case "string":
        value = arguments[3]
    default:
        exit(1)
}

// write to object
jsonWrite(jsonObject: &jsonObject, path: dataPathArray, value: value)

// object back to data and string then print for shell
jsonData = try! JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
jsonString = String(data: jsonData, encoding: .utf8) ?? ""
print(jsonString)