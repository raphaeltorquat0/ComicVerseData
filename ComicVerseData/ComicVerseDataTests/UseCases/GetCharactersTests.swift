//
//  GetCharactersTests.swift
//  ComicVerseData
//
//  Created by Raphael Torquato on 31/05/23.
//

import XCTest
import ComicVerseDomain

final class GetCharactersTests: XCTestCase {

    func test_get_character_should_call_httpClient_with_correct_url() {
        let url = makeURL()
        let (sut, httpClientSpy) = makeSUT(url: url)
        guard let makeCharacters = makeCharactersModel() else { return }
        sut.getCharactersModel(makeCharacters) { _ in }
        XCTAssertEqual(httpClientSpy.urls, [url])
    }
    
    func test_get_character_should_call_httpClient_with_correct_value() {
        let (sut, httpClientSpy) = makeSUT()
        guard let charactersModel = makeCharactersModel() else { return }
        sut.getCharactersModel(charactersModel) { _ in }
        XCTAssertEqual(httpClientSpy.data, charactersModel.toData())
    }
    
    func test_get_character_should_complete_with_error_if_completes_with_wrong_key() {
        let (sut, httpClientSpy) = makeSUT()
        expect(sut, completeWith: .failure(.invalidCredentials), when: {
            httpClientSpy.completeWithError(.invalidOrUnrecognizedParameter)
        })
    }
    
    func test_get_character_should_complete_with_error_if_completes_are_missing_key() {
        let (sut, httpClientSpy) = makeSUT()
        expect(sut, completeWith: .failure(.invalidCredentials)) {
            httpClientSpy.completeWithError(.emptyParameter)
        }
    }
    
    func test_get_character_should_not_complete_if_sut_has_been_deallocated() {
        let httpClientSpy = HTTPClientSpy()
        var sut: RemoteGetCharacters? = RemoteGetCharacters(url: makeURL(), httpClient: httpClientSpy)
        var result: GetCharacters.Result?
        guard let charactersModel = makeCharactersModel() else { return }
        sut?.getCharactersModel(charactersModel) { result = $0 }
        sut = nil
        httpClientSpy.completeWithError(.limitInvalidOrBellow1)
        XCTAssertNil(result)
    }
}


extension GetCharactersTests {
    
    func makeSUT(url: URL = URL(string: "https://any-uyrl.com")!, file: StaticString = #file, line: UInt = #line) -> (sut: RemoteGetCharacters, httpClientSpy: HTTPClientSpy) {
        let httpClientSpy = HTTPClientSpy()
        let sut = RemoteGetCharacters(url: url, httpClient: httpClientSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: httpClientSpy, file: file, line: line)
        return (sut, httpClientSpy)
    }
    
    func expect(_ sut: RemoteGetCharacters, completeWith expectedResult: GetCharacters.Result, when action: () -> Void, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "waiting...")
        sut.getCharactersModel(makeCharactersModel()!) { receivedResult in
            switch(expectedResult, receivedResult) {
            case(.failure(let expectedError), .failure(let receivedError)):
                XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case (.success(let expectedCharacters), .success(let receivedCharacters)):
                XCTAssertEqual(expectedCharacters, receivedCharacters, file:  file, line:  line)
            default:
                XCTFail("-> Expected: \(expectedResult) \n -> -> Received: \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        action()
        wait(for: [exp], timeout: 1)
    }
}
