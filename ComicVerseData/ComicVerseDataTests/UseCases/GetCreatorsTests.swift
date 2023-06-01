//
//  GetCreatorsTests.swift
//  ComicVerseData
//
//  Created by Raphael Torquato on 31/05/23.
//

import XCTest
import ComicVerseDomain

final class GetCreatorsTests: XCTestCase {
    
    func test_get_creators_should_call_httpClient_with_correct_url() async throws {
        let url = makeURL()
        let (sut, httpClientSpy) = makeSUT(url: url)
        do {
            guard let makeCreators = try await makeCreatorsModel() else { return }
            sut.getCreators(makeCreators) { _ in }
            XCTAssertEqual(httpClientSpy.urls, [url])
        } catch {
            print("error...:\(error.localizedDescription)")
        }
    }
    
    func test_get_creators_should_call_httpClient_with_correct_value() async throws {
        let (sut, httpClientSpy) = makeSUT()
        do {
            guard let makeCreators = try await makeCreatorsModel() else { return }
            sut.getCreators(makeCreators) { _ in }
            XCTAssertEqual(httpClientSpy.data, makeCreators.toData())
        } catch {
            print("error...:\(error.localizedDescription)")
        }
    }
    
    func test_get_creators_should_complete_with_error_if_completes_with_wrong_key() async throws {
        let (sut, httpClientSpy) = try await makeSUT()
        do {
            try? await expect(sut, completeWith: .failure(.invalidCredentials), when: {
                httpClientSpy.completeWithError(.invalidOrUnrecognizedParameter)
            })
        } catch {
            print("error...:\(error.localizedDescription)")
        }
        
    }
    
    func test_get_creators_should_complete_with_error_if_completes_are_missing_key() async throws {
        let (sut, httpClientSpy) = makeSUT()
        do {
            try await expect(sut, completeWith: .failure(.invalidCredentials)) {
                httpClientSpy.completeWithError(.emptyParameter)
            }
        } catch {
            print("error...\(error.localizedDescription)")
        }
    }
    
    func test_get_creators_should_not_complete_if_sut_has_been_deallocated() async throws {
        let httpClientSpy = HTTPClientSpy()
        var sut: RemoteGetCreators? = try await RemoteGetCreators(url: makeURL(), httpCient: httpClientSpy)
        var result: GetCreators.Result?
        guard let creatorsModel = try await makeCreatorsModel() else { return }
        try await sut?.getCreators(creatorsModel) { result = $0 }
        sut = nil
        httpClientSpy.completeWithError(.limitInvalidOrBellow1)
        XCTAssertNil(result)
    }
}

extension GetCreatorsTests {
    
    func makeSUT(url: URL = URL(string: "https://any-url.com")!, file: StaticString = #file, line: UInt = #line) -> (sut: RemoteGetCreators, httpClientSpy: HTTPClientSpy) {
        let httpClientSpy = HTTPClientSpy()
        let sut = RemoteGetCreators(url: url, httpCient: httpClientSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: httpClientSpy, file: file, line: line)
        return (sut, httpClientSpy)
    }
    
    func expect(_ sut: RemoteGetCreators, completeWith expectedResult: GetCreators.Result, when action: () -> Void, file: StaticString = #file, line: UInt = #line) async {
        let exp = expectation(description: "waiting...")
        guard let creatorsModel = try? await makeCreatorsModel() else { return }
        sut.getCreators(creatorsModel) { receivedResult in
            switch(expectedResult, receivedResult) {
            case(.failure(let expectedError), .failure(let receivedError)):
                XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case(.success(let expectedCreators), .success(let receivedCreators)):
                XCTAssertEqual(expectedCreators, receivedCreators)
            default:
                XCTFail("-> Expected: \(expectedResult) \n -> -> Received: \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        action()
        wait(for: [exp], timeout: 1)
    }
}
