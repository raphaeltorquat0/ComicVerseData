//
//  SupportsLocalDAta.swift
//  ComicVerseData
//
//  Created by Raphael Torquato on 31/05/23.
//

import Foundation
import ComicVerseDomain

struct readingDataFrom: Codable {
    
    func localMock(for name: String) throws -> Data? {
        do {
            if let filePath = Bundle.main.path(forResource: name, ofType: "json") {
                let fileURL = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileURL)
                return data
            }
        } catch {
            print("error: \(error.localizedDescription)")
        }
        return nil
    }
}
