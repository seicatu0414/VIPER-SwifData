//
//  APIProtcol.swift
//  VIPER
//
//  Created by yamaguchi kohei on 2024/12/28.
//

import Foundation

// followeesとfollowerが共通のListを使う為、データの根幹を担う部分をUserProtocolとして切り出し
protocol UserProtocol: Decodable,Identifiable,Hashable {
    var id: String { get }
    var name: String? { get }
    var followersCount: Int? { get }
    var followeesCount: Int? { get }
    var profileImageURL: String? { get }
}

//struct User:UserProtocol,Identifiable {
//    var id: String
//    var name: String?
//    var followersCount: Int?
//    var followeesCount: Int?
//    var profileImageURL: String?
//    init(id: String, name: String? = nil, followersCount: Int? = nil, followeesCount: Int? = nil, profileImageURL: String? = nil) {
//        self.id = id
//        self.name = name
//        self.followersCount = followersCount
//        self.followeesCount = followeesCount
//        self.profileImageURL = profileImageURL
//    }
//}






