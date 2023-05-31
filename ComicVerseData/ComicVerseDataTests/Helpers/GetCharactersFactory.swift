//
//  GetCharactersFactory.swift
//  ComicVerseData
//
//  Created by Raphael Torquato on 31/05/23.
//

import XCTest
import ComicVerseDomain


func makeCharactersModel() async throws -> CharactersModel? {
    var jsonData = readingDataFrom()
    do {
        guard let characters = try await parseMock(jsonData: jsonData.localMock(for: "CharactersMock")!) else { return nil }
//        return CharactersModel(id: characters?.id, name: characters?.name, description: characters?.description, modified: characters?.modified, resourceURI: characters?.resourceURI, urls: characters?.urls, thumbnail: characters?.thumbnail, comics: characters?.comics, stories: characters?.stories, events: characters?.events, series: characters?.series)
        return try CharactersModel(from:characters as! Decoder)
    } catch {
        print("error: \(error.localizedDescription)")
    }
    return nil
}

private func parseMock(jsonData: Data) -> CharactersModel? {
    do {
        let decodedData = try JSONDecoder().decode(CharactersModel.self, from: jsonData)
        return decodedData
    } catch {
        print("error:\(error)")
    }
    return nil
}

func getCharactersModel() -> GetCharactersModel {
    return GetCharactersModel(hash: "hash_string", ts: Date(), apikey: "api_key")
}


