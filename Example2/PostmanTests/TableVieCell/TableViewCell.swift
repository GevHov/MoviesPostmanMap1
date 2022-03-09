//
//  TableViewCell.swift
//  Example2
//
//  Created by Gevorg Hovhannisyan on 22.12.21.
//

import UIKit

final class TableViewCell: UITableViewCell {

    
    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var labelName: UILabel!
    @IBOutlet private weak var labeldescription: UILabel!
    
    var photo: Ads! {
        
        didSet{
            self.labelName.text = self.photo.name
            self.labelName.text = self.photo.description
            self.photoImageView.setImage(imageUrl: self.photo.image)
        }
    }
}
