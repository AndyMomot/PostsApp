//
//  newslineVC.swift
//  PostsApp
//
//  Created by Андрей on 20.07.2022.
//

import UIKit

class NewslineVC: UITableViewController {
    static let shared = NewslineVC()
    
    func reload() {
        self.tableView.reloadData()
    }
    
    
    
    var networkManager = NetworkManager()
    var dataSourse = [Post]()
    
    let nowTimeStamp: String = {
        let objDateformat: DateFormatter = DateFormatter()
        objDateformat.dateFormat = "yyyy-MM-dd"
        let now = NSDate()
        let strTime: String = objDateformat.string(from: now as Date)
        let objUTCDate: NSDate = objDateformat.date(from: strTime)! as NSDate
        let milliseconds: Int64 = Int64(objUTCDate.timeIntervalSince1970)
        let strTimeStamp: String = "\(milliseconds)"
        return strTimeStamp
    }()
    
    let urlString = "https://raw.githubusercontent.com/anton-natife/jsons/master/api/main.json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableView.automaticDimension
        
        networkManager.obtainPost { [weak self] (result) in
            switch result {
            case .success(let posts):
                // возврат результата в главном потоке
                self?.dataSourse = posts
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                debugPrint("Error: \(error.localizedDescription)")
            }
        }
    }
    
    
    @IBAction func filterButton(_ sender: UIBarButtonItem) {
        self.tableView.reloadData()
        print(dataSourse.count)
    }
    
    func getCurrentTimeStampWOMiliseconds(dateToConvert: NSDate) -> String {
        let objDateformat: DateFormatter = DateFormatter()
        objDateformat.dateFormat = "yyyy-MM-dd"
        let strTime: String = objDateformat.string(from: dateToConvert as Date)
        let objUTCDate: NSDate = objDateformat.date(from: strTime)! as NSDate
        let milliseconds: Int64 = Int64(objUTCDate.timeIntervalSince1970)
        let strTimeStamp: String = "\(milliseconds)"
        return strTimeStamp
    }
    
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourse.count
    }
    
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         if let cell = tableView.dequeueReusableCell(withIdentifier: "newslineCell", for: indexPath) as? NewslineCell {
             cell.cellDelegate = self
             cell.index = indexPath
             
             
             
             let data = dataSourse[indexPath.row]
             let timeshamp = data.timeshamp ?? 0
             let daysFromPublication = (Int(self.nowTimeStamp)! - timeshamp) / 86400
             
             cell.titleLabel.text = data.title
             cell.subTitleLabel.text = data.previewText
             cell.likesCountLabel.text = "\(data.likesCount ?? 0)"
             
             switch daysFromPublication {
             case 0..<30 :
                 cell.dayOfPublicationLabel.text = "\(daysFromPublication) days ago"
             case 30..<366:
                 cell.dayOfPublicationLabel.text = "\(daysFromPublication / 30) months ago"
             case 366..<1825 :
                 cell.dayOfPublicationLabel.text = "\(daysFromPublication / 365) years ago"
             default:
                 break
             }
             
             return cell
         }
         
         return NewslineCell()
     }
    
    
}

extension NewslineVC: TableViewCellDelegate {
    func clickButtonOnCell(index: Int) {
       
    }
    
    
}
