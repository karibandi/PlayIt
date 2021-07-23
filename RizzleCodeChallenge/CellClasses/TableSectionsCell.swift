//
//  TableSectionsCell.swift
//  RizzleCodeChallenge
//
//  Created by Surendra Karibandi on 18/07/21.
//

import UIKit

typealias DidSelectClosure = ((_ index: Int?, _ videoData: [Node]? ) -> Void)

class TableSectionsCell: UITableViewCell {
    
    @IBOutlet weak var collectionView:UICollectionView!
    @IBOutlet weak var sectionTitleLabel:UILabel!
    
    var didSelectClosure : DidSelectClosure!
    
    var nodeData : [Node]?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension TableSectionsCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.nodeData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as? CollectionCell else {return UICollectionViewCell()}
        let urlForCell = self.nodeData?[indexPath.row].video.encodeURL
        guard let url = URL(string: urlForCell ?? "") ?? dudURL else { return cell }
        cell.thumbNailImage.loadImageFromURLS(imageURL: url, placeholderImage: "videoplayer")
        
        return cell
    }
    
}

extension TableSectionsCell: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellIndex:Int = indexPath.row
        let sectionData = self.nodeData
        didSelectClosure(cellIndex, sectionData)
    }
}

extension TableSectionsCell: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 147.0, height: 192.0)
       }
}
