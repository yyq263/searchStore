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
    
    private let displayNamesForKind = [
        "album": NSLocalizedString("Album", comment: "Localized kind: Album"),
        "audiobook": NSLocalizedString("Audio Book",comment: "Localized kind: Audio Book"),
        "book": NSLocalizedString("Book", comment: "Localized kind: Book"),
        "ebook": NSLocalizedString("E-Book",
                                   comment: "Localized kind: E-Book"),
        "feature-movie": NSLocalizedString("Movie",
                                           comment: "Localized kind: Feature Movie"),
        "music-video": NSLocalizedString("Music Video",
                                         comment: "Localized kind: Music Video"),
        "podcast": NSLocalizedString("Podcast",
                                     comment: "Localized kind: Podcast"),
        "software": NSLocalizedString("App",
                                      comment: "Localized kind: Software"),
        "song": NSLocalizedString("Song",
                                  comment: "Localized kind: Song"),
        "tv-episode": NSLocalizedString("TV Episode",
                                        comment: "Localized kind: TV Episode"),
    ]
    
    func kindForDisplay() -> String {
        return displayNamesForKind[kind] ?? kind
    }


}

func < (lhs: SearchResult, rhs: SearchResult) -> Bool {
    return lhs.name.localizedStandardCompare(rhs.name) == .orderedAscending
}
    
