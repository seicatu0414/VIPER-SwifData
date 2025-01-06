//
//  FllowerAndFolloweePresenter.swift
//  VIPER
//
//  Created by yamaguchi kohei on 2024/12/28.
//

import Foundation
import SwiftUICore

protocol FllowerAndFolloweePresenterProtocol: ObservableObject {
//    // followeesと共通のListを使う為UserProtcolに準拠した何かと抽象度を高める
//    var followers : [SearchUserFollower] { get }
//    // followeesと共通のListを使う為UserProtcolに準拠した何かと抽象度を高める
//    var followees : [SearchUserFollowee] { get }
    var followers: [SearchUserFollower] { get }
    var followees: [SearchUserFollowee] { get }
    func fetchFollowers() async throws
    func fetchFollowees() async throws
    func fetchImageData(profileImageURL: String) async throws -> Data
}

class FllowerAndFolloweePresenter: FllowerAndFolloweePresenterProtocol {
    @Published var followers: [SearchUserFollower] = [SearchUserFollower]()
    @Published var followees: [SearchUserFollowee] = [SearchUserFollowee]()
//    @Published var followers: [SearchUserFollower] = [SearchUserFollower]()
//    @Published var followees: [SearchUserFollowee] = [SearchUserFollowee]()
    private var apiInteractor: APIInteractorProtocol
    private var router:FllowerAndFolloweeRouterProtocol
    private var userIdStr : String = ""
    
    init(apiInteractor: APIInteractorProtocol,router:FllowerAndFolloweeRouterProtocol,userIdStr: String) {
        self.apiInteractor = apiInteractor
        self.router = router
        self.userIdStr = userIdStr
    }
    
    @MainActor
    func fetchFollowers() async throws {
        let followers = try await apiInteractor.sendFollowersApi(userId: userIdStr)
        self.followers = followers
//        self.followers = followers.map { follower in
//                User(
//                    id: follower.id,
//                    name: follower.name,
//                    followersCount: follower.followersCount,
//                    followeesCount: follower.followeesCount,
//                    profileImageURL: follower.profileImageURL
//                )
//        }
    }
    @MainActor
    func fetchFollowees() async throws {
        let followees = try await apiInteractor.sendFolloweesApi(userId: userIdStr)
        self.followees = followees
//        self.followees = followees.map { followees in
//                User(
//                    id: followees.id,
//                    name: followees.name,
//                    followersCount: followees.followersCount,
//                    followeesCount: followees.followeesCount,
//                    profileImageURL: followees.profileImageURL
//                )
//        }
    }
    
    func fetchImageData(profileImageURL: String) async throws -> Data {
        let imageData = try await apiInteractor.sendGetIconData(url: profileImageURL)
        return imageData
     }
}
