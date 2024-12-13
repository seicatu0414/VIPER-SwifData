//
//  Enums.swift
//  VIPER
//
//  Created by yamaguchi kohei on 2024/12/05.
//

enum Urls:String {
    case MainUrl = "https://qiita.com/api/v2/users/"
    case Items = "/items"
    case Followees = "/followees"
    case Followers = "/followers"
}

enum Errors: Error {
    case decodingError
    case networkError(Int)
    case castError
    case swiftDataReadError
    case swiftDataWriteError
    case swiftDataDeleteError
    case containersError
}
