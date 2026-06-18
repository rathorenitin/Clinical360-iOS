//
//  ViewState.swift
//  Clinical360
//
//  Created by Nitin Singh Rathore on 18/06/26.
//

enum ViewState<Result> {
    case loading
    case loaded(Result)
    case empty(String)
    case error(String)
}
