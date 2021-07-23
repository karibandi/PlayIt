//
//  ExploreViewController.swift
//  RizzleCodeChallenge
//
//  Created by Surendra Karibandi on 18/07/21.
//

import UIKit

class ExploreViewController: UIViewController {

    
    var videoData:VideoStack = VideoStack()
    var nodesData = [[Node]]()
    var sectionTitle: [String]!
    
    @IBOutlet weak var tableForSections: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        fetchDataFromFile()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleNavigationTitle(title: "Explore")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handleNavigationTitle(title: "")

    }
    
    func handleNavigationTitle(title:String) {
        self.navigationItem.title = title

    }
    
    func fetchDataFromFile() {
        NetworkManager<[VideoLibrary]>().fetch(url: baseURL!) { results in
            switch results{
            case .success(let response):

                guard let serverData = response else { return }
                self.videoData = serverData
                self.sectionTitle = self.videoData.map{$0.title}
                DispatchQueue.main.async {
                    self.tableForSections.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.displayAlert(message: error.localizedDescription)
                }
            }
        }
    }
    
    func moveToPlayerScreen(index: Int, data: [Node]?)  {
        
        let playerView = storyboard?.instantiateViewController(withIdentifier: "PlayerScreenController") as! PlayerScreenController
        playerView.videoContent = data!
        playerView.indexToShow = index
        self.navigationController?.pushViewController(playerView, animated: true)
                
    }

}

extension ExploreViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionData = sectionTitle else {
            return 0
        }
        return sectionData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "sectioncell", for: indexPath) as? TableSectionsCell else {return UITableViewCell()}
        cell.sectionTitleLabel.text = sectionTitle[indexPath.row]
        cell.nodeData = videoData[indexPath.row].nodes
        cell.didSelectClosure = { [weak self] index, data in
            if let index = index, let data = data {
                self?.moveToPlayerScreen(index: index, data: data)
            }
        }
        return cell
    }
}

extension ExploreViewController: UITableViewDelegate{   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 227
    }
}


extension ExploreViewController{
    func displayAlert(message: String) {
        let alert = UIAlertController(title: "Oops!!", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
