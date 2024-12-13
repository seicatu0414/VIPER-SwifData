//
//  SwiftDataInteractor.swift
//  VIPER
//
//  Created by yamaguchi kohei on 2024/12/05.
//
import SwiftData
import Foundation

protocol SwiftDataInteractorProtocol {
    func fetchLookedUsers(completion: @escaping (Result<[LookedUser],Error>) -> Void) async throws
    func saveUser(id: String?, name: String?, profileImageData: Data?, followeesCount: Int?, followersCount: Int?, lookDate: Date?, completion: @escaping (Result<Void, Error>) -> Void)
    func deleteUser(user: LookedUser, completion: @escaping (Result<Void, Error>) -> Void)
}

class SwiftDataInteractor: SwiftDataInteractorProtocol {
    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    // データを取得
    func fetchLookedUsers(completion: @escaping (Result<[LookedUser],Error>) -> Void) async throws {
        let fetchDescriptor = FetchDescriptor<LookedUser>()
        do {
            let users = try modelContext.fetch(fetchDescriptor)
            completion(.success(users))
        } catch {
            print("Error fetching items: \(error)")
            completion(.failure(Errors.swiftDataReadError))
        }
    }

    // データを保存
    func saveUser(id: String?, name: String?, profileImageData: Data?, followeesCount: Int?, followersCount: Int?, lookDate: Date?, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let id = id else {
            print("ID cannot be nil")
            completion(.failure(Errors.swiftDataWriteError))
            return
        }
        
        do {
            // 既存データを取得または新規作成
            let user = try modelContext.findOrInsert(
                matching: #Predicate<LookedUser> { $0.id! == id },
                create: LookedUser(id: id,
                                   name: name,
                                   profileImageData: profileImageData,
                                   followeesCount: followeesCount,
                                   followersCount: followersCount,
                                   lookDate: lookDate)
            )
            
            // プロパティの更新
            user.id = id
            user.name = name
            user.profileImageData = profileImageData
            user.followeesCount = followeesCount
            user.followersCount = followersCount
            user.lookDate = lookDate
            
            // 保存処理
            try modelContext.save()
            completion(.success(()))
        } catch {
            print("Error saving or updating user: \(error)")
            completion(.failure(Errors.swiftDataWriteError))
        }
    }

    // データを削除
    func deleteUser(user: LookedUser, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            modelContext.delete(user)
            try modelContext.save()
            completion(.success(()))
        } catch {
            print("Error deleting item: \(error)")
            completion(.failure(Errors.swiftDataDeleteError))
        }
    }
}

