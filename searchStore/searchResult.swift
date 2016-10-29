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
    
    

}

func < (lhs: SearchResult, rhs: SearchResult) -> Bool {
    return lhs.name.localizedStandardCompare(rhs.name) == .orderedAscending
}
    
