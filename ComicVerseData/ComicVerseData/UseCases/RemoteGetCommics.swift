//
//  RemoteGetCommics.swift
//  ComicVerseData
//
//  Created by Raphael Torquato on 30/05/23.
//

import Foundation
import ComicVerseDomain

public final class RemoteGetCommics: GetCommics {
    private let url: URL
    private let httpClient: HTTPGetClient
    
    public init(url: URL, httpClient: HTTPGetClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    public func get(getCommicsModel: GetCommicsModel, completion: @escaping (GetCommics.Result) -> Void) {
        httpClient.get(to: url, with: getCommicsModel.toData()) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let data):
                if let model: CommicsModel = data?.toModel() {
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
