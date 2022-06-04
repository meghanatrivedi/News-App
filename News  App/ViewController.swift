//
//  ViewController.swift
//  News  App
//
//  Created by Meghna on 04/06/22.
//

import UIKit
import SafariServices

class ViewController: UIViewController {
    
    @IBOutlet weak var tblView: UITableView!
    
    private var viewModels = [NewstableviewCellViewModel]()
    private var article = [Article]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        view.backgroundColor = .systemBackground
        
        
        tblView.delegate = self
        tblView.dataSource = self
        
        tblView.register(UINib(nibName: "NewsTableviewCell", bundle: nil), forCellReuseIdentifier: "NewsTableviewCell")

        
        APICaller.share.getTopStories{ [weak self]  result in
            switch result{
            case .success(let articles):
                
                self?.viewModels = articles.compactMap({
                    NewstableviewCellViewModel(title: $0.title, subtitle: $0.description ?? "No Discription", imageURL: URL(string: $0.urlToImage ?? ""))
                })
                
                
                
                DispatchQueue.main.async {
                    self?.tblView.reloadData()
                }
                break
            case .failure(let error):
                print(error)
            }
        }
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableviewCell", for: indexPath) as! NewsTableviewCell
        cell.configerData(with: viewModels[indexPath.row])
return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected indexparth\(indexPath.row)")
        
        let articles  = article[indexPath.row]
        
        
        guard  let url  = URL(string: articles.url ?? "") else {
            return
        }
        let vc = SFSafariViewController(url: url)
       present(vc,animated: true)
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
        
    }
    
    
}
