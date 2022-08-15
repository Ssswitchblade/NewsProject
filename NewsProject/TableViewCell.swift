//
//  TableViewCell.swift
//  NewsProject
//
//  Created by Admin on 29.07.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var nameNews: UILabel!
    @IBOutlet weak var dateNews: UILabel!
    @IBOutlet weak var imageViewNews: UIImageView!
    @IBOutlet weak var shortNews: UITextView!
    
    let converterDate = DateFormatter()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configur(news: NewsModel) {
        converterDate.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        var date = converterDate.date(from: news.date)!
        converterDate.dateFormat = "HH:mm MM.dd.yyyy"
        let dateString = converterDate.string(from: date)
        print(dateString)
        nameNews.text = news.title
        shortNews.text = news.description
        dateNews.text = dateString
        imageViewNews.sd_setImage(with: news.urlToImage, placeholderImage: UIImage(named: "Homer"))
    }
}
