//
//  TestFactories.swift
//  ComicVerseData
//
//  Created by Raphael Torquato on 31/05/23.
//

import Foundation

func makeInvalidCredentials() -> Data {
    return Data["InvalidCredentials".utf8]
}

func makeEmptyData() -> Data {
    return Data()
}

func makeURL() -> URL {
    return URL(string: "http://gateway.marvel.com/v1/public/")!
}

func makeError() -> Error {
    return NSError(domain: "any_error", code: 0)
}

func makeHTTPResponse(statusCode: Int = 200) -> HTTPURLResponse {
    return HTTPURLResponse(url: makeURL(), statusCode: statusCode, httpVersion: nil, headerFields: nil)
}
