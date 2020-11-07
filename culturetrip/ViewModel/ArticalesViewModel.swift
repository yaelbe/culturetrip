//
//  ArticalesViewModel.swift
//  culturetrip
//
//  Created by Yael Bilu Eran on 06/11/2020.
//

import Foundation

class ArticalesViewModel {
    
    private var data: [Article] = [] {
        didSet {
            onDatafetched?()
        }
    }
    var onDatafetched: (() -> ())? = nil
    
    var dataCount: Int {
        return data.count
    }
    
    func data(at index: IndexPath) -> Article? {
        guard 0..<data.count ~= index.row else { return nil }
        return data[index.row]
    }
    
    func fetchData() {
        DataProvider.shared.fetchData { [weak self] result in
            switch result {
            case .success(let articales):
                guard let articales = articales else { return }
                self?.data = articales
            case .failure(let error):
                print("the error \(error)")
            }
        }
    }
}
