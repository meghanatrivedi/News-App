//
//  NewsTableviewCell.swift
//  News  App
//
//  Created by Meghna on 04/06/22.
//

import UIKit

class NewstableviewCellViewModel{
    let title : String
    let subtitle :String
    let imageURL: URL?
    var imageData:Data? = nil
    init(title: String, subtitle: String , imageURL:URL?) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL =  imageURL
    }
}

class NewsTableviewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configerData (with viewModels: NewstableviewCellViewModel){
        lblTitle.text = viewModels.title
        lblSubTitle.text = viewModels.subtitle
        if let imageData = viewModels.imageData{
            imageView?.image = UIImage(data: imageData)
        }else if let url = viewModels.imageURL{
            URLSession.shared.dataTask(with: url){ [weak self] data ,_ , error in
                guard let data = data , error == nil else{
                    return
                }
                viewModels.imageData = data
                DispatchQueue.main.async {
                    self?.imageView?.image = UIImage(data: data)

                }
            }.resume()
        }
    }
}


