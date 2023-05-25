//
//  functions.swift
//  Password-Generate
//
//  Created by Luiz Sena on 11/03/22.
//

import Foundation
import ArgumentParser

func validadePassword(password: String) -> Int {
    var creationProgress = 0
    if (SizeConstants.Min.rawValue <= password.count && SizeConstants.Max.rawValue >= password.count){
        if password.matches(".*\\d.*"){creationProgress += 1}
        if password.matches(".*[a-z].*"){creationProgress += 1}
        if password.matches(".*[A-Z].*"){creationProgress += 1}
        if password.matches(#".[.!@#$%^&(){}[:"';<>,.?/~`+]-\\=|].*"#){creationProgress += 1}
    }

    return creationProgress
}

func randomString(length: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789*.!@#$%^&(){}[]:;<>,.?/~+-=|\\"
    return String((0..<length).map{ _ in letters.randomElement()! })
}


func createFile(_ filePath: String, fileManager: FMProtocol) throws -> Bool {
    if fileVerify(filePath) == false {
        fileManager.createFile(atPath: filePath, contents: nil, attributes: nil)
        return true
    } else {
        throw CreateFileError.emptyFile
    }
}

enum CreateFileError: Error, LocalizedError {
    case emptyFile

    public var errorDescription: String? {
        switch self {
        case .emptyFile:
            return NSLocalizedString("File is empty", comment: "")
        }
    }
}

func writeFile(filePath: String,pass_name: String, password: String) -> Bool {
    do {
        let handle = try FileHandle(forWritingTo: URL(fileURLWithPath: filePath))
        handle.seekToEndOfFile()
        handle.write("\(pass_name)  ->  \(password)\n".data(using: .utf8)!)
        handle.closeFile()
        return true
    } catch {
        print(error)
        return false
    }
}

func fileVerify(_ filePath: String) -> Bool {

    return FileManager.default.fileExists(atPath: filePath)
}

protocol FMProtocol {
    func createFile(atPath: String, contents: Data?, attributes: [FileAttributeKey : Any]?) -> Bool
}

class FileManagerMock: FMProtocol {
    static let shared = FileManagerMock()

    private init() {

    }
    
    func createFile(atPath: String, contents: Data?, attributes: [FileAttributeKey : Any]?) -> Bool {
        return true
    }

}

extension FileManager: FMProtocol {

}
