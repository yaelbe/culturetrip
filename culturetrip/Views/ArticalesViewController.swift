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
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(ArticaleCell.nib, forCellWithReuseIdentifier: ArticaleCell.identifier)
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width:  UIScreen.main.bounds.width - consts.collectionViewMargine*2 , height:consts.minCellHeight + size(for: indexPath))
    }
    
    private func size(for indexPath: IndexPath) -> CGFloat {
        
        if let title = viewModel.data(at: indexPath)?.title?.trimmingCharacters(in: .whitespacesAndNewlines) {
            let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - consts.collectionViewMargine*2 - consts.cellMargine*2, height: CGFloat.greatestFiniteMagnitude))
            label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.byWordWrapping
            label.font = dammyCell.titleLabel.font
            label.text = title
            label.sizeToFit()
            
            print ("aaa text; \(title) height:\(label.frame.height)")
            return label.frame.height
        }
         return 0
    }
    
}
