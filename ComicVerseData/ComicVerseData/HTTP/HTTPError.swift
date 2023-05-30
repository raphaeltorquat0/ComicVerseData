//
//  HTTPError.swift
//  ComicVerseData
//
//  Created by Raphael Torquato on 30/05/23.
//

import Foundation

public enum HTTPError: Error {
    case limitGreaterThan100
    case limitInvalidOrBellow1
    case invalidOrUnrecognizedParameter
    case emptyParameter
    case invalidOrUnrecognizedOrderingParameter
    case tooManyValuesSentToAMultiValueListFilter
    case invalidValuePassedToFilter
}
