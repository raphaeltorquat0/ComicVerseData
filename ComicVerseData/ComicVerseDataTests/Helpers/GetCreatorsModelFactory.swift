//
//  GetCreatorsModelFactory.swift
//  ComicVerseData
//
//  Created by Raphael Torquato on 31/05/23.
//

import Foundation
import ComicVerseDomain

func makeCreatorsModel() async throws -> CreatorsModel? {
    let json =  readingDataFrom()
    do {
        guard let creators = try await parseMock(jsonData: json.localMock(for: "CreatorsMock")!) else { return nil }
        return try CreatorsModel(from: creators.self as! Decoder)
    } catch {
        print("error:\(error.localizedDescription)")
    }
    return nil
}

private func parseMock(jsonData: Data) -> CreatorsModel? {
    do {
        let decodedData = try JSONDecoder().decode(CreatorsModel.self, from: jsonData)
        return decodedData
    } catch {
        print("error: \(error.localizedDescription)")
    }
    return nil
}

func getCreatorsModel() -> GetCreatorsModel {
    return GetCreatorsModel(hash: "hash_string", ts: Date(), apikey: "api_key")
}
