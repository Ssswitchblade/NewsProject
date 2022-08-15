//
//  OpenNewsViewController.swift
//  NewsProject
//
//  Created by Admin on 29.07.2022.
//

import UIKit
import SDWebImage

class OpenNewsViewController: UIViewController {

    let imageView = UIImageView()
    let titleLabel = UILabel()
    let newsLabel = UITextView()
    
    var titleString: String
    var image: URL
    var news: String
    
    init(title: String, image: URL, news: String) {
        self.news = news
        self.image = image
        self.titleString = title
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(imageView)
        view.addSubview(newsLabel)
        setupData()
        setupUI()
    }
    
    private func setupData() {
        self.imageView.sd_setImage(with: image, placeholderImage: UIImage(named: "Homer"))
        self.titleLabel.text = self.titleString
        self.newsLabel.text = self.news
    }
    
    private func setupUI() {
        let safeArea = self.view.safeAreaLayoutGuide
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        newsLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: self.view.bounds.height/8),
            
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            imageView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            imageView.heightAnchor.constraint(equalToConstant: self.view.bounds.height/5),
            
            newsLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            newsLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            newsLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            newsLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}
