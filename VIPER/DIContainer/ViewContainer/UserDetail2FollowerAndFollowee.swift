//
//  UserDetail2FollowerAndFollowee.swift
//  VIPER
//
//  Created by yamaguchi kohei on 2025/01/03.
//

struct FollowerAndFolloweeData : Hashable {
    // "follower" か "followee"
    let type: Bool
    let userId: String
    let path: String
}
