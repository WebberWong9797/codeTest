//
//  appleAlbumDataModel.swift
//  appleAlbum
//
//  Created by Webber Wong on 11/3/2022.
//

import Foundation
enum collectionExplicitnessType{
    case notExplicit
    case Explicit
}
enum collectionType{
    case Album
}
enum wrapperType{
    case collection
}

struct appleAlbum {
    var amgArtistId: Int?
    var artistId: Int?
    var artistName: String?
    var artistViewUrl: String?
    var artworkUrl100: String?
    var artworkUrl60: String?
    var collectionCensoredName: String?
    var collectionExplicitness: collectionExplicitnessType?
    var collectionId: Int?
    var collectionName: String?
    var collectionPrice: Double?
    var collectionType: collectionType?
    var collectionViewUrl: String?
    var contentAdvisoryRating: collectionExplicitnessType?
    var copyright: String?
    var country: String?
    var currency: String?
    var primaryGenreName: String?
    var releaseDate: Date?
    var trackCount: Int?
    var wrapperType: wrapperType?
}
