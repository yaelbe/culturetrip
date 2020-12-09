//
//  ArticalesViewController.swift
//  culturetrip
//
//  Created by Yael Bilu Eran on 06/11/2020.
//

import UIKit

class ArticalesViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private struct consts {
        static let cellMargine: CGFloat = 16
        static let collectionViewMargine: CGFloat = 8
        static let minCellHeight: CGFloat = 346
    }
    
    // MARK: proprieties
    var viewModel: ArticalesViewModel = ArticalesViewModel()
    let dammyCell = Bundle.main.loadNibNamed(ArticaleCell.identifier, owner: self, options: nil)?.first as! ArticaleCell
    
    var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.size.width
        layout.estimatedItemSize = CGSize(width: width, height: 10)
        return layout
    }()
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(ArticaleCell.nib, forCellWithReuseIdentifier: ArticaleCell.identifier)
        collectionView.collectionViewLayout = layout
        viewModel.onDatafetched = {[weak self] in
            self?.onDatafetched()
        }
        
        viewModel.fetchData()
    }
    
    deinit {
        viewModel.onDatafetched = nil
    }
    
    private func onDatafetched() {
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.dataCount
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticaleCell.identifier, for: indexPath) as? ArticaleCell {
            let article  = viewModel.data(at: indexPath)
            cell.data = article
            return cell
        }
        return UICollectionViewCell()
    }
    
    //Not necessary here
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        layout.estimatedItemSize = CGSize(width: view.bounds.size.width, height: 10)
        super.traitCollectionDidChange(previousTraitCollection)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        layout.estimatedItemSize = CGSize(width: view.bounds.size.width, height: 10)
        layout.invalidateLayout()
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
//    {
//        return CGSize(width:  UIScreen.main.bounds.width - consts.collectionViewMargine*2 , height:consts.minCellHeight + size(for: indexPath))
//    }
    
//    private func size(for indexPath: IndexPath) -> CGFloat {
//
//        if let title = viewModel.data(at: indexPath)?.title?.trimmingCharacters(in: .whitespacesAndNewlines) {
//            let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - consts.collectionViewMargine*2 - consts.cellMargine*2, height: CGFloat.greatestFiniteMagnitude))
//            label.numberOfLines = 0
//            label.lineBreakMode = NSLineBreakMode.byWordWrapping
//            label.font = dammyCell.titleLabel.font
//            label.text = title
//            label.sizeToFit()
//
//            print ("aaa text; \(title) height:\(label.frame.height)")
//            return label.frame.height
//        }
//         return 0
//    }
    
}
