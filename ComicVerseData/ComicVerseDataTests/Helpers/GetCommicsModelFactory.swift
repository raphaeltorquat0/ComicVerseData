//
//  GetCommicsModelFactory.swift
//  ComicVerseData
//
//  Created by Raphael Torquato on 31/05/23.
//

import Foundation
import ComicVerseDomain

func makeCommicsModel() async throws -> CommicsModel? {
    var json = readingDataFrom()
    do {
        guard let commics = try await parseMock(jsonData: json.localMock(for: "ComicsMock")!) else { return nil }
        return try CommicsModel(from: commics.self as! Decoder)
    } catch {
        print("error:\(error.localizedDescription)")
    }
    return nil
}

private func parseMock(jsonData: Data) -> CommicsModel? {
    do {
        let decodedData = try JSONDecoder().decode(CommicsModel.self, from: jsonData)
        return decodedData
    } catch {
        print("error: \(error.localizedDescription)")
    }
    return nil
}

func getComicsModel() -> GetCommicsModel {
    return GetCommicsModel(hash: "hash_string", ts: Date(), apikey: "api_key")
}
