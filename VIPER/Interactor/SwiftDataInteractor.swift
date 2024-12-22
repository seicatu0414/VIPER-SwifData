//
//  SwiftDataInteractor.swift
//  VIPER
//
//  Created by yamaguchi kohei on 2024/12/05.
//
import SwiftData
import Foundation
// SwiftDataはメインスレッドで操作推奨外すとWarning
@MainActor
protocol SwiftDataInteractorProtocol {
    func fetchLookedUsers() async throws -> [LookedUser]
    func saveUser(id: String?, name: String?, profileImageData: Data?, followeesCount: Int?, followersCount: Int?, lookDate: Date?) async throws
    func deleteUser(user: LookedUser, completion: @escaping (Result<Void, Error>) -> Void)
}

class SwiftDataInteractor: SwiftDataInteractorProtocol {
    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    // データを取得
    func fetchLookedUsers() async throws ->[LookedUser]  {
        let fetchDescriptor = FetchDescriptor<LookedUser>()
        do {
            let users = try modelContext.fetch(fetchDescriptor)
            return users
        } catch {
            print("Error fetching items: \(error)")
            throw Errors.swiftDataReadError
        }
    }

    // データを保存
    func saveUser(id: String?, name: String?, profileImageData: Data?, followeesCount: Int?, followersCount: Int?, lookDate: Date?) async throws {
        guard let id = id else {
            print("ID cannot be nil")
            return
        }
        
        do {
            // 既存データを取得または新規作成
            // matchingでアンラップしてはいけない（これ起因でエラーに落ちてた）
            let user = try modelContext.findOrInsert(
                matching: #Predicate<LookedUser> { $0.id == id },
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
            try await SharedModelContainer.shared.saveContext() // 通知をトリガー
        } catch {
            throw Errors.swiftDataWriteError
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

