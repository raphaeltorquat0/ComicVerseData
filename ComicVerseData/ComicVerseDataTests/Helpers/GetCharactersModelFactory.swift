//
//  GetCharactersModelFactory.swift
//  ComicVerseData
//
//  Created by Raphael Torquato on 31/05/23.
//

import Foundation
import ComicVerseDomain

func makeCharactersModel() -> CharactersModel {
    return CharactersModel(id: 0, name: "any_name", description: "any_description", modified: "any_date", resourceURI: "any_resource_URI", urls: "any_array_urls", thumbnail: "any_image", comics: "any_comics", stories: "any_stories", events: "any_events", series: "any_series")
}


func getCharactersModel() -> GetCharactersModel {
    
}
