//
//  ItemWebViewRouter.swift
//  VIPER
//
//  Created by yamaguchi kohei on 2024/12/15.
//

import SwiftUI

// Task内で呼ばれるため＠MainActorをプロトコルに付与
// modal遷移
@MainActor
protocol UserDetailRouterProtocol {
    func modalItemWebView(url: String)
    func popToSearchUserView()
//    func tapToFollower(followers: [SearchUserFollower])
//    func tapToFollowee(followees: [SearchUserFollowee])
    func tapToFollowerAndFollowee(followerOrFollowee:Bool, userId: String)
//    func tapToFollowerAndFollowee(followees: [SearchUserFollowee])

}

class UserDetailRouter: UserDetailRouterProtocol {
    private let navigationState: NavigationState
    static let followerAndFolloweePath: String = "/FollowerAndFollowee"
    
    init(navigationState: NavigationState) {
        self.navigationState = navigationState
    }

    // Itemを表示するWebViewにモーダル遷移(SwiftUIではViewにモーダル遷移のイベントトリガあるため不要)
    func modalItemWebView(url: String) {

    }
    //  ユーザ検索画面に戻る
    func popToSearchUserView() {
        if !navigationState.navigationPath.isEmpty {
            navigationState.navigationPath.removeLast()
        }
    }
    func tapToFollower(followers: [SearchUserFollower]) {
        navigationState.navigationPath.append(followers)
    }
    
    func tapToFollowee(followees: [SearchUserFollowee]) {
        navigationState.navigationPath.append(followees)
    }
    func tapToFollowerAndFollowee(followerOrFollowee:Bool, userId: String) {
        let data = FollowerAndFolloweeData(type: followerOrFollowee, userId: userId, path: UserDetailRouter.followerAndFolloweePath)
        Thread.callStackSymbols.forEach { print($0) } // 呼び出し元を出力
        navigationState.navigationPath.append(data)
    }
    
}
