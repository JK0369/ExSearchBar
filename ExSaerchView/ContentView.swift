//
//  ContentView.swift
//  ExSaerchView
//
//  Created by 김종권 on 2022/09/08.
//

import SwiftUI

struct ContentView: View {
  @State var searchQueryString = ""
  var datas = (0...100).map(String.init).map(SomeData.init)
  var filteredDatas: [SomeData] {
    if searchQueryString.isEmpty {
      return datas
    } else {
      return datas.filter { $0.name.localizedStandardContains(searchQueryString) }
    }
  }
  
  var body: some View {
    NavigationView {
      List(filteredDatas) { data in
        NavigationLink {
          SomeView(name: data.name)
        } label: {
          Text(data.name)
        }
      }
      .listStyle(.plain)
      .navigationTitle("Search Test")
    }
    .searchable(
      text: $searchQueryString,
      placement: .navigationBarDrawer(displayMode: .always),
      prompt: "검색 placholder..."
    )
    .onSubmit(of: .search) {
      print("검색 완료: \(searchQueryString)")
    }
    .onChange(of: searchQueryString) { newValue in
      // viewModel 사용 시 이곳에서 새로운 값 입력
      print("검색 입력: \(newValue)")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

struct SomeView: View {
  var name: String
  
  var body: some View {
    Text(name)
  }
}

struct SomeData: Identifiable {
  var name: String
  var id: String { self.name }
}
