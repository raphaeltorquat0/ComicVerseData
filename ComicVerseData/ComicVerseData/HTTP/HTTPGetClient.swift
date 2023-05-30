//
//  HTTPGetClient.swift
//  ComicVerseData
//
//  Created by Raphael Torquato on 30/05/23.
//

import Foundation

public protocol HTTPGetClient {
    func get(to url: URL, with data: Data?, completion: @escaping(Result<Data?, HTTPError>) -> Void)
}
