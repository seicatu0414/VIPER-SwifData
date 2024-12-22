//
//  SearchUserPresenter.swift
//  VIPER
//
//  Created by yamaguchi kohei on 2024/12/05.
//

import Foundation

protocol SearchUserPresenterProtocol:ObservableObject {
    var users: [LookedUser] { get }
    // 画面遷移
    func didSelectCell(at indexPath: IndexPath)
    func didTapButton(userIDStr: String)
    func fetchSwiftData() async throws
}

class SearchUserPresenter: SearchUserPresenterProtocol {
    // 一時的な情報保持のためPresenterに保持
    @Published var users: [LookedUser] = [LookedUser]()
    private var apiInteractor: APIInteractorProtocol
    private var swiftDataInteractor: SwiftDataInteractorProtocol
    private var router: SearchUserRouterProtocol
    
    init(apiInteractor: APIInteractorProtocol,
         swiftDataInteractor: SwiftDataInteractorProtocol,
         router: SearchUserRouterProtocol) {
        self.apiInteractor = apiInteractor
        self.swiftDataInteractor = swiftDataInteractor
        self.router = router
    }
    
    // テーブルビュー
    func didSelectCell(at indexPath: IndexPath) {
        let user = self.users[indexPath.row]
        Task {
            do {
                let userData = try await apiInteractor.sendUserApi(userId: user.id!)
                // メインスレッドで画面遷移のためawait
                await self.router.pushToUserDetail(userData: userData)
            } catch {
                print("API通信に失敗: \(error)")
            }
        }
    }
    
    //検索ボタンタップ時
    func didTapButton(userIDStr: String) {
        if userIDStr.isEmpty { return }
        Task {
            do {
                let userData = try await apiInteractor.sendUserApi(userId: userIDStr)
                // メインスレッドで画面遷移のためawait
                await self.router.pushToUserDetail(userData: userData)
            } catch {
                print("API通信に失敗: \(error)")
            }
        }
    }
    // @publishedの更新をするのはMainスレッド推奨のため＠MainActor
    @MainActor
    func fetchSwiftData() async throws {
        self.users = try await self.swiftDataInteractor.fetchLookedUsers()
    }
}
