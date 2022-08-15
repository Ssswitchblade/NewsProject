//
//  ViewController.swift
//  NewsProject
//
//  Created by Admin on 27.07.2022.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
 
    var news = [NewsModel]()
    var tableView = UITableView()
    var model = Model()
    var spinner = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(spinner)
        view.addSubview(tableView)
        
        tableView.isHidden = true
        setupUI()
        loadNews()
        
    }
    
    private func loadNews() {
        spinner.startAnimating()
        Model.shared.getData(completionBlock: { [weak self] output in
            self?.news = output
            self?.updateUI()
        })
    }
    
    private func updateUI() {
        
        DispatchQueue.main.async{
            self.tableView.reloadData()
            self.spinner.stopAnimating()
            self.spinner.isHidden = true
            self.tableView.isHidden = false
        }
    }
    
    private func openNews(model: NewsModel) {
        let vc = OpenNewsViewController(title: model.title, image: model.urlToImage, news: model.description)
        
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(news.count)
        return  news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let model = news[indexPath.row]
        
        cell.configur(news: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        openNews(model: news[indexPath.row])
    }
    
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.translatesAutoresizingMaskIntoConstraints = false
        spinner.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor),
            tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            spinner.heightAnchor.constraint(equalTo: self.view.heightAnchor),
            spinner.widthAnchor.constraint(equalTo: self.view.widthAnchor),
        ])
    }
    
}


