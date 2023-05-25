//
//  File.swift
//  
//
//  Created by Luiz Sena on 21/03/22.
//

import Foundation
import ArgumentParser

extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}

enum SizeConstants: Int {
    case Min = 8
    case Max = 32
}

enum ValidationError: Error, LocalizedError {
    case tooShort
    case tooLong

    public var errorDescription: String? {
        switch self {
        case .tooShort:
            return NSLocalizedString("\nThe password length cannot be less than 8", comment: "")
        case .tooLong:
            return NSLocalizedString("\nThe password length cannot be more than 32", comment: "")
        }
    }
}

public struct passwordSt: ParsableCommand {
    
    public static var configuration = CommandConfiguration(commandName: "passgen")
    
    @Option(name: NameSpecification.shortAndLong, help: "Size of password")
    var size: Int
    @Option(name: NameSpecification.shortAndLong, help: "Name to be assigned to password")
    var pass_name: String
    
    public init() { }
    
    public func run() {
        var password = ""
        
        while true {
            do {
                try verifyError(size: size)
            } catch {
                print(error.localizedDescription)
                break
            }
                print(messag, terminator: "")
                while validadePassword(password: password) != 4 {
                    password = randomString(length: size)
                }
                print("\n\nYour password \(pass_name) is \(password)", terminator: "")
                print("\nYour password to \((Double(validadePassword(password: password))/4)*100)" + "% of force\n")
            do {
                let filePath = NSHomeDirectory() + "/senhas.txt"
                if try createFile(filePath, fileManager: FileManager.default) {
                    print("File created with success.")
                }
            } catch {
                print(error.localizedDescription)
            }

            let filePath = NSHomeDirectory() + "/senhas.txt"
            writeFile(filePath: filePath, pass_name: pass_name, password: password)
                do{
                    let testing = try String(contentsOf: URL(fileURLWithPath: filePath))
                    print(testing)
                }catch{
                    print(error)
                }
                break
        }
    }
    
    func verifyError(size: Int) throws -> Bool {
        if size < SizeConstants.Min.rawValue {
            throw ValidationError.tooShort
        } else if size > SizeConstants.Max.rawValue {
            throw ValidationError.tooLong
        } else {
            return false
        }
    }
    
}
