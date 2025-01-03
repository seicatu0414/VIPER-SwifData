//
//  FllowerAndFolloweeRouter.swift
//  VIPER
//
//  Created by yamaguchi kohei on 2025/01/04.
//

import SwiftUI
// Task内で呼ばれるため＠MainActorをプロトコルに付与
// RouterProtcolはNavigation使ってる限りこのアプリでは共通化できそうだが一応別個に書く方針
@MainActor
protocol FllowerAndFolloweeRouterProtocol {
    func pushToUserDetail(userData: SearchUser)
    func popToPreviousView()
}


class FllowerAndFolloweeRouter: FllowerAndFolloweeRouterProtocol {
    @Binding var navigationPath: NavigationPath
    static let userDetailPath: String = "/UserDetail"
    init(navigationPath: Binding<NavigationPath>) {
        _navigationPath = navigationPath
    }
    // プッシュ遷移
    func pushToUserDetail(userData: SearchUser) {

    }
    
    // ポップ遷移
    func popToPreviousView() {

    }
    
}
