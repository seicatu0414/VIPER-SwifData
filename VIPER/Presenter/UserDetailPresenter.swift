//
//  UserDetailPresenter.swift
//  VIPER
//
//  Created by yamaguchi kohei on 2024/12/12.
//

import Foundation

protocol UserDetailPresenterProtocol:ObservableObject {
    var userData: SearchUser { get }
    var items: [SearchUserItems] { get }
    var webViewUrlStr: String? { get }
    var imageData:Data { get }
    // 画面遷移
    func didSelectCell(at indexPath: IndexPath)
    func tapFollowerButton()
    func tapFolloweeButton()
    func saveUserData() async throws
    func fetchItemApi() async throws
    func fetchImageData() async throws
}

class UserDetailPresenter: UserDetailPresenterProtocol {
    
    // 一時的な情報保持のためPresenterに保持
    let userData: SearchUser
    @Published var items: [SearchUserItems] = [SearchUserItems]()
    @Published var webViewUrlStr: String? = nil
    var lookingUser:String = ""
    @Published var imageData:Data = Data()
    private var apiInteractor: APIInteractorProtocol
    private var swiftDataInteractor: SwiftDataInteractorProtocol
    private var router: UserDetailRouterProtocol

    
    init(apiInteractor: APIInteractorProtocol,
         swiftDataInteractor: SwiftDataInteractorProtocol,
         router: UserDetailRouterProtocol,
         userData: SearchUser) {
        self.apiInteractor = apiInteractor
        self.swiftDataInteractor = swiftDataInteractor
        self.router = router
        self.userData = userData
    }
    
    // テーブルビュー
    func didSelectCell(at indexPath: IndexPath) {
        let item = self.items[indexPath.row]
        webViewUrlStr = item.url
    }
    
    func tapFollowerButton() {
        Task {
            do {
                await self.router.tapToFollowerAndFollowee(followerOrFollowee: true, userId: userData.id)
            } catch {
                
            }

        }
    }
    
    func tapFolloweeButton() {
        Task {
            do {
                await self.router.tapToFollowerAndFollowee(followerOrFollowee: false, userId: userData.id)

            } catch {
                
            }

        }
    }
    
    // 見ていたユーザーデータの保存(navigationDissmiss時)
    func saveUserData() async throws {
        let date = Date()
            do {
                try await self.swiftDataInteractor.saveUser(id: userData.id, name: userData.name, profileImageData: imageData, followeesCount: userData.followeesCount, followersCount: userData.followersCount, lookDate: date)
                // こいつがめちゃめちゃ悪さしてた。
                //await self.router.popToSearchUserView()
            } catch {
                print("aaaa")
            }
    }

    // @publishedの更新をするのはMainスレッド推奨のため＠MainActor
    @MainActor
    func fetchItemApi() async throws {
        do {
            let items = try await apiInteractor.sendUserItemsApi(userId: userData.id)
            self.items = items
        } catch {
            
        }
    }
    @MainActor
   func fetchImageData() async throws {
       self.imageData = try await apiInteractor.sendGetIconData(url: userData.profileImageURL!)
    }
}

