//
//  MyTableViewCell.swift
//  Example2
//
//  Created by Gevorg Hovhannisyan on 30.10.21.
//

import UIKit

class MyTableViewCell: UITableViewCell {


    //MARK: - ID
    static let id = "MyTableViewCell"
    
    
    //MARK: - @IBOutlet
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    //MARK: - Properties
    var models = [Models]()
    var delegate: MainViewControllerProtocol?
    
    func configure(with models: [Models]){
        
        self.models = models
        collectionView.reloadData()
    }
    
    
    //MARK: - LifeCycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //MARK: - Confirm Delegates
        collectionView.dataSource = self
        collectionView.delegate = self
    
        
        //MARK: - DeviceRotated
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
        
        //MARK: - MyCollectionViewCell Register
        collectionView.register(UINib(nibName: MyCollectionViewCell.id, bundle: nil), forCellWithReuseIdentifier: MyCollectionViewCell.id)
    }

    
    //MARK: - RotatedFunc
    @objc func rotated() {
        if UIDevice.current.orientation.isLandscape {
            
            collectionView.collectionViewLayout.invalidateLayout()
        } else {
            
            collectionView.collectionViewLayout.invalidateLayout()
        }
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
extension MyTableViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.frame.width/2, height: self.frame.height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.id, for: indexPath) as! MyCollectionViewCell
        
        if let url = URL(string: models[indexPath.item].imageURL), let data = try? Data(contentsOf: url) {
            
            cell.imageView.image = UIImage(data: data)
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.delegate?.didSelectItemFromCollectionView(model: models[indexPath.item])
    }   
}

// MARK: - MainViewControllerProtocol
extension MyTableViewCell: MainViewControllerProtocol {
    
    func didSelectItemFromCollectionView(model: Models) {
        
        delegate?.didSelectItemFromCollectionView(model: model)
    }
}
