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
    func tapToFollower(followers: [SearchUserFollower])
    func tapToFollowee(followees: [SearchUserFollowee])

}

class UserDetailRouter: UserDetailRouterProtocol {
    @Binding var navigationPath: NavigationPath
    static let userDetailPath: String = "/FollowerAndFollowee"
    init(navigationPath: Binding<NavigationPath>) {
        _navigationPath = navigationPath
    }
    // Itemを表示するWebViewにモーダル遷移
    func modalItemWebView(url: String) {
    }
    //  ユーザ検索画面に戻る
    func popToSearchUserView() {
        if !navigationPath.isEmpty {
            navigationPath.removeLast()
        }
    }
    func tapToFollower(followers: [SearchUserFollower]) {

    }
    
    func tapToFollowee(followees: [SearchUserFollowee]) {

    }
}
