import XCTest
@testable import PassGenLibrary
import class Foundation.Bundle

final class Password_GeneretorTests: XCTestCase {
    var passwordST = passwordSt()

    func testValidPassword() {
        let result = validadePassword(password: "Lais123%")

        let expected = 4
        XCTAssertEqual(result, expected, "Este result: \(result) é diferente de \(expected)")
    }

    func testValidadePasswordLessThanMin() {
        let result = validadePassword(password: "lais123")

        let expected = 0

        XCTAssertEqual(result, expected)
    }

    func testValidadePasswordMoreThanMax() {
        let result = validadePassword(password: "thisIsAReallyLongStringUsedForTesting")
        let expected = 0

        XCTAssertEqual(result, expected)
    }

    func testRandomStringLength() {
        let result = randomString(length: 5)
        let expected = 5

        XCTAssertEqual(result.count, expected)
    }

    func testFileVerifyFileDoesNotExist() {
        let filePath = NSHomeDirectory() + "/senhas.testes.txt"

        XCTAssertFalse(fileVerify(filePath))
    }

    func testFileVerifyFileExists() {
        let filePath = NSHomeDirectory() + "/senhas.txt"

        XCTAssertTrue(fileVerify(filePath))
    }

    func testWriteFileTrue() {
        let filePath = NSHomeDirectory() + "/senhas.txt"
        XCTAssertTrue(writeFile(filePath: filePath, pass_name: "discord", password: "534567dndc"))
    }

    func testWriteFileFalse() {
        let filePath = NSHomeDirectory() + "/senhas.text.txt"

        XCTAssertFalse(writeFile(filePath: filePath, pass_name: "discord", password: "534567dndc"))
    }

    func testVerifyErrorLessThanMin() {
        XCTAssertThrowsError(try passwordST.verifyError(size: 4))
    }

    func testVerifyErrorMoreThanMax() {
        XCTAssertThrowsError(try passwordST.verifyError(size: 35))
    }

    func testVerifyErrorNoError() {
        XCTAssertFalse(try passwordST.verifyError(size: 10))
    }

    func testCreateFileFileDoesNotExist() {
        let filePath = NSHomeDirectory() + "/senhas.teste.txt"


        XCTAssertNoThrow(try createFile(filePath, fileManager: FileManagerMock.shared))
    }

    func testCreateFileFileExists() {
        let filePath = NSHomeDirectory() + "/senhas.txt"


        XCTAssertThrowsError(try createFile(filePath, fileManager: FileManagerMock.shared))
    }

    func testCreateFileErrorEmptyFile() {
        let result = CreateFileError.emptyFile

        XCTAssertEqual(result.errorDescription, "File is empty")
    }

    func testValidationErrorTooShort() {
        let result = ValidationError.tooShort.errorDescription

        let expected = "\nThe password length cannot be less than 8"

        XCTAssertEqual(result, expected)
    }

    func testValidationErrorTooLong() {
        let result = ValidationError.tooLong.errorDescription

        let expected = "\nThe password length cannot be more than 32"

        XCTAssertEqual(result, expected)
    }

//    func testPasswordSTRun() {
//        XCTAssertTrue(passwordST.run())
//    }

}

