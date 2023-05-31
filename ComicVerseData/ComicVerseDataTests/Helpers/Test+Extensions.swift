//
//  Test+Extensions.swift
//  ComicVerseData
//
//  Created by Raphael Torquato on 31/05/23.
//

import XCTest

extension XCTestCase {
    func checkMemoryLeak(for instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, file: file, line: line)
        }
    }
}
