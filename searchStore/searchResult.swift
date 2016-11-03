//
//  searchResult.swift
//  searchStore
//
//  Created by Yiqin Yao on 20/10/2016.
//  Copyright © 2016 Yiqin Yao. All rights reserved.
//

import Foundation

class SearchResult {
    var name = ""
    var artistName = ""
    var artworkSmallURL = "" //60×60 pixel image
    var artworkLargeURL = "" //100×100 pixel image
    var storeURL = ""
    var kind = ""
    var currency = ""
    var price = 0.0
    var genre = ""
    
    func kindForDisplay() -> String {
        switch kind {
        case "album": return "Album"
        case "audiobook": return "Audio Book"
        case "book": return "Book"
        case "ebook": return "E-Book"
        case "feature-movie": return "Movie"
        case "music-video": return "Music Video"
        case "podcast": return "Podcast"
        case "software": return "App"
        case "song": return "Song"
        case "tv-episode": return "TV Episode"
        default: return kind
        }
    }


}

func < (lhs: SearchResult, rhs: SearchResult) -> Bool {
    return lhs.name.localizedStandardCompare(rhs.name) == .orderedAscending
}
    
