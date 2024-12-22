//
//  SearchUserView.swift
//  VIPER
//
//  Created by yamaguchi kohei on 2024/12/12.
//

import SwiftUI
import SwiftData
// Presenterを疎結合にするためジェネリクス定義
struct SearchUserView<Presenter: SearchUserPresenterProtocol>: View {
    @Binding var navigationPath: NavigationPath
    @EnvironmentObject var sharedModelContainer: SharedModelContainer
    @ObservedObject var presenter: Presenter
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                searchBar
                listTitle
                userList
            }
            .onAppear() {
                Task {
                    try await presenter.fetchSwiftData()
                }
            }
            .navigationTitle("ユーザ検索")
            .onChange(of: sharedModelContainer.dataChangeCnt) { _ in
                // pop遷移がうまく制御できず、onAppearがSwiftDataの更新
                // より早く走ってしまう為modelcontextの更新で再レンダリングを行うために
                // やむなく実装
                // 暇な時に修正案考える
                Task {
                    try await presenter.fetchSwiftData()
                }
            }
            .navigationDestination(for: SearchUser.self) { user in
                UserDetailModuleFactory.createModule(navigationPath: $navigationPath, diContainer: DIContainer.shared, inputData: user)
            }
        }
    }
    
    private var searchBar: some View {
        HStack {
            TextField("ユーザIDを入力", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .frame(height: 44)

            Button(action: {
                presenter.didTapButton(userIDStr: searchText)
            }) {
                Text("検索")
                    .fontWeight(.bold)
                    .frame(maxHeight: .infinity)
                    .padding(.horizontal, 16)
                    .background(Color.qiitaDarkGreen)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .frame(height: 44)
            .padding(5)
        }
        .padding(.top)
    }
    
    private var listTitle: some View {
        GeometryReader { geometry in
            Text("過去閲覧したユーザー")
                .fontWeight(.bold)
                .frame(width: geometry.size.width, height: 30, alignment: .leading)
                .padding(.horizontal, 16)
                .background(Color.secondary)
                .foregroundColor(.white)
        }
        .frame(height: 30)
        
    }

    private var userList: some View {
        List(presenter.users, id: \.id) { user in
            Button(action: {
                if let index = presenter.users.firstIndex(where: { $0.id == user.id }) {
                    presenter.didSelectCell(at: IndexPath(row: index, section: 0))
                }
            }) {
                SearchedUserRow(
                    userImageData: user.profileImageData!,
                    userName: user.name ?? "No Name",
                    userFlowerCnt: "\(user.followersCount ?? 0)",
                    userFloweeCnt: "\(user.followeesCount ?? 0)"
                )
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.plain)
        }
        .listStyle(PlainListStyle())
    }
}

//#Preview {
//    // プレゼンターのダミーデータを注入
//    let dummyPresenter = SearchUserPresenter(
//        apiInteractor: DummyAPIInteractor(),
//        swiftDataInteractor: DummySwiftDataInteractor(),
//        router: DummyRouter()
//    )
//
//    SearchUserView(presenter: dummyPresenter)
//        .modelContainer(for: LookedUser.self, inMemory: true)
//}
