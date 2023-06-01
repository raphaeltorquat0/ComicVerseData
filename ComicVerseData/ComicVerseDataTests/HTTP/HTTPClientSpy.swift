//
//  HTTPClientSpy.swift
//  ComicVerseData
//
//  Created by Raphael Torquato on 31/05/23.
//

import Foundation

class HTTPClientSpy: HTTPGetClient {
    var urls = [URL]()
    var data: Data?
    var completion: ((Result<Data?, HTTPError>) -> Void)?
    
    func get(to url: URL, with data: Data?, completion: @escaping (Result<Data?, HTTPError>) -> Void) {
        self.urls.append(url)
        self.data = data
        self.completion = completion
    }
    
    func completeWithError(_ error: HTTPError) {
        completion?(.failure(error))
    }
    
    func completeWithData(_ data: Data) {
        completion?(.success(data))
    }
}
