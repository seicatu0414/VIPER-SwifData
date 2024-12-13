//
//  SwiftDataEntity.swift
//  VIPER
//
//  Created by yamaguchi kohei on 2024/12/05.
//

import Foundation
import SwiftData
// 過去にサーチしたユーザー情報
@Model
class LookedUser:Identifiable {
    var id: String?
    var name: String?
    var profileImageData: Data?
    var followeesCount: Int?
    var followersCount: Int?
    var lookDate:Date?
    init(id: String?, name: String?, profileImageData: Data?, followeesCount: Int?, followersCount: Int?, lookDate: Date?) {
        self.id = id
        self.name = name
        self.profileImageData = profileImageData
        self.followeesCount = followeesCount
        self.followersCount = followersCount
        self.lookDate = lookDate
    }
}
