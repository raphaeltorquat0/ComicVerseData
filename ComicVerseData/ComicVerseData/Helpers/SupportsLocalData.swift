//
//  SupportsLocalData.swift
//  ComicVerseData
//
//  Created by Raphael Torquato on 31/05/23.
//

import Foundation

struct readingDataFrom{
    
    func loadFromLocalMock(for name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main(forResource: name, offType: "json") {
                let mockData = try String(contentsOfFile: bundlePath).data(using: .utf8)
                return mockData
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
