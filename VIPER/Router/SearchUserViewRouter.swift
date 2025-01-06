//
//  SearchUserViewRouter.swift
//  VIPER
//
//  Created by yamaguchi kohei on 2024/12/06.
//

import SwiftUI
// Task内で呼ばれるため＠MainActorをプロトコルに付与
// RouterProtcolはNavigation使ってる限りこのアプリでは共通化できそうだが一応別個に書く方針
@MainActor
protocol SearchUserRouterProtocol {
    func pushToUserDetail(userData: SearchUser)
    func popToPreviousView()
}


class SearchUserViewRouter: SearchUserRouterProtocol {

    static let userDetailPath: String = "/UserDetail"
    private let navigationState: NavigationState

    init(navigationState: NavigationState) {
        self.navigationState = navigationState
    }
    // プッシュ遷移
    func pushToUserDetail(userData: SearchUser) {
        navigationState.navigationPath.append(userData)
    }
    
    // ポップ遷移(不要っぽい)
    func popToPreviousView() {
        if !navigationState.navigationPath.isEmpty {
            navigationState.navigationPath.removeLast()
        }
    }
    
}
