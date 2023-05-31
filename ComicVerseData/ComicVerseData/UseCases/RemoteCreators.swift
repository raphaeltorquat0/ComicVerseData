//
//  RemoteCreators.swift
//  ComicVerseData
//
//  Created by Raphael Torquato on 30/05/23.
//

import Foundation
import ComicVerseDomain

public final class RemoteGetCreators: GetCreators {
    private let url: URL
    private let httpCient: HTTPGetClient
    
    public init(url: URL, httpCient: HTTPGetClient) {
        self.url = url
        self.httpCient = httpCient
    }
    
    public func getCreators(_ getCreators: CreatorsModel, completion: @escaping (GetCreators.Result) -> Void) {
        httpCient.get(to: url, with: getCreators.toData()) { [weak self] result in
            guard self != nil else { return }
            switch result {
                case .success(let data):
                if let model: CreatorsModel = data?.toModel() {
                    completion(.success(model))
                } else {
                    completion(.failure(.unexpected))
                }
            case .failure(let error):
                switch error {
                case .emptyParameter:
                    completion(.failure(.invalidCredentials))
                default:
                    completion(.failure(.unexpected))
                }
            }
        }
    }
}
