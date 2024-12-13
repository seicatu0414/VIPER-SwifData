//
//  APIInteractor.swift
//  VIPER
//
//  Created by yamaguchi kohei on 2024/12/05.
import SwiftData
import Foundation

protocol APIInteractorProtocol {
    // 非同期メソッドでは、completionクロージャの代わりにasync/awaitを活用する設計が推奨
    func sendUserApi(userId: String) async throws -> SearchUser
    func sendUserItemsApi(userId: String) async throws -> [SearchUserItems]
    func sendFolloweesApi(userId: String) async throws -> [SearchUserFollowee]
    func sendFollowersApi(userId: String) async throws -> [SearchUserFollowers]
    func sendGetIconData(url: String) async throws -> Data
}

class APIInteractor: APIInteractorProtocol {
    // https://qiita.com/api/v2/users/user_id
    // User情報に紐づくAPIにGetする
    func sendUserApi(userId: String) async throws -> SearchUser {
        // URL作成
        let url = URL(string: Urls.MainUrl.rawValue + userId)!
        let (data, err) = try await URLSession.shared.data(from: url)
        do {
            return try JSONDecoder().decode(SearchUser.self, from: data)
        } catch {
            let errNum = err.hashValue
            throw Errors.networkError(errNum)
        }
    }
    
    // https://qiita.com/api/v2/users/user_id/items
    // User情報に紐づくItemsAPIにGetする
    func sendUserItemsApi(userId: String) async throws -> [SearchUserItems] {
        // URL作成
        let url = URL(string: Urls.MainUrl.rawValue + userId + Urls.Items.rawValue)!
        let (data, err) = try await URLSession.shared.data(from: url)
        do {
            return try JSONDecoder().decode([SearchUserItems].self, from: data)
        } catch {
            let errNum = err.hashValue
            throw Errors.networkError(errNum)
        }
    }
    
    // https://qiita.com/api/v2/users/:user_id/followees
    // FolloweeAPIをGetする
    func sendFolloweesApi(userId: String) async throws -> [SearchUserFollowee] {
        // URL作成
        let url = URL(string: Urls.MainUrl.rawValue + userId + Urls.Followees.rawValue)!
        let (data, err) = try await URLSession.shared.data(from: url)
        do {
            return try JSONDecoder().decode([SearchUserFollowee].self, from: data)
        } catch {
            let errNum = err.hashValue
            throw Errors.networkError(errNum)
        }
    }
    
    // https://qiita.com/api/v2/users/:user_id/followers
    // FollowerAPIをGetする
    func sendFollowersApi(userId: String) async throws -> [SearchUserFollowers] {
        // URL作成
        let url = URL(string: Urls.MainUrl.rawValue + userId + Urls.Followers.rawValue)!
        let (data, err) = try await URLSession.shared.data(from: url)
        do {
            return try JSONDecoder().decode([SearchUserFollowers].self, from: data)
        } catch {
            let errNum = err.hashValue
            throw Errors.networkError(errNum)
        }
    }
    // アイコンの取得
    func sendGetIconData(url: String) async throws -> Data {
        let url = URL(string: url)!
        let (data, err) = try await URLSession.shared.data(from: url)
        // 200以外は成功と認めない
        if err.hashValue == 200 {
            return data
        } else {
            throw Errors.networkError(err.hashValue)
        }
    }
}
