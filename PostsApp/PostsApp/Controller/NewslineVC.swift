//
//  newslineVC.swift
//  PostsApp
//
//  Created by Андрей on 20.07.2022.
//

import UIKit

class NewslineVC: UITableViewController {
    static let shared = NewslineVC()
    
    var networkManager = NetworkManager()
    var detailNetworkManager = DetailNetworkManager()
    
    var dataSourse = [Post]()
    var postDatailData: PostDetail?
    var eachCellStatus: [Bool] = []
    var labelsSize: [Int] = []
    var detailPostURL = "https://raw.githubusercontent.com/anton-natife/jsons/master/api/posts/111.json"
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.showsVerticalScrollIndicator = false
        downloadNewslinePosts()
    }
    
    func downloadNewslinePosts() {
        networkManager.obtainPost { [weak self] (result) in
            switch result {
            case .success(let posts):
                // возврат результата в главном потоке
                self?.dataSourse = posts
                
                for _ in self!.dataSourse {
                    self?.eachCellStatus.append(true)
                }
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                debugPrint("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func dowloadDetailPostData(urlString: String) {
        detailNetworkManager.obtainPost(url: urlString) { [weak self] (result) in
            switch result {
            case .success(let posts):
                // возврат результата в главном потоке
                self?.postDatailData = posts
                
            case .failure(let error):
                debugPrint("Error: \(error.localizedDescription)")
            }
        }
    }
    
    
    // MARK: Filter Posts
    @IBAction func filterButton(_ sender: UIBarButtonItem) {
        showFilterAlert()
        tableView.reloadData()
    }
    
    func showFilterAlert() {
        let alert = UIAlertController(title: "Sort by:", message: nil, preferredStyle: .alert)
        
        let sortByRating = UIAlertAction(title: "Rating", style: .default) { _ in
            showSotrByRatingAlert()
        }
        let sortByDate = UIAlertAction(title: "Date", style: .default) { _ in
            showSotrByDateAlert()
        }
        let sortByDefault = UIAlertAction(title: "Default", style: .default) { _ in
            self.downloadNewslinePosts()
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alert.addAction(sortByRating)
        alert.addAction(sortByDate)
        alert.addAction(sortByDefault)
        alert.addAction(cancelButton)
        self.present(alert, animated: true, completion: nil)
        
        func showSotrByRatingAlert() {
            let alert = UIAlertController(title: "Sort by:", message: nil, preferredStyle: .alert)
            
            let ascendingButton = UIAlertAction(title: "Ascending", style: .default) { [self] _ in
                self.dataSourse = dataSourse.sorted(by: {$0.likesCount ?? 0 < $1.likesCount ?? 0})
                self.tableView.reloadData()
            }
            
            let descendingButton = UIAlertAction(title: "Descending", style: .default) { [self] _ in
                self.dataSourse = dataSourse.sorted(by: {$0.likesCount ?? 0 > $1.likesCount ?? 0})
                self.tableView.reloadData()
            }
            let cancelButton = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
            
            alert.addAction(ascendingButton)
            alert.addAction(descendingButton)
            alert.addAction(cancelButton)
            self.present(alert, animated: true, completion: nil)
            
        }
        
        func showSotrByDateAlert() {
            let alert = UIAlertController(title: "Sort by:", message: nil, preferredStyle: .alert)
            
            let ascendingButton = UIAlertAction(title: "Ascending", style: .default) { [self] _ in
                self.dataSourse = dataSourse.sorted(by: {$0.timeshamp ?? 0 > $1.timeshamp ?? 0})
                self.tableView.reloadData()
            }
            
            let descendingButton = UIAlertAction(title: "Descending", style: .default) { [self] _ in
                self.dataSourse = dataSourse.sorted(by: {$0.timeshamp ?? 0 < $1.timeshamp ?? 0})
                self.tableView.reloadData()
            }
            let cancelButton = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
            
            alert.addAction(ascendingButton)
            alert.addAction(descendingButton)
            alert.addAction(cancelButton)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    // MARK: Helpers
    
    func getCurrentTimeStampWOMiliseconds(dateToConvert: NSDate) -> String {
        let objDateformat: DateFormatter = DateFormatter()
        objDateformat.dateFormat = "yyyy-MM-dd"
        let strTime: String = objDateformat.string(from: dateToConvert as Date)
        let objUTCDate: NSDate = objDateformat.date(from: strTime)! as NSDate
        let milliseconds: Int64 = Int64(objUTCDate.timeIntervalSince1970)
        let strTimeStamp: String = "\(milliseconds)"
        return strTimeStamp
    }
    
    func countLabelLines(label: UILabel) -> Int {
        let myText = label.text! as NSString
        
        let rect = CGSize(width: label.bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = myText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: label.font!], context: nil)
        
        return Int(ceil(CGFloat(labelSize.height) / label.font.lineHeight))
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourse.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "newslineCell", for: indexPath) as? NewslineCell {
            
            let data = dataSourse[indexPath.row]
            let timeshamp = data.timeshamp ?? 0
            let daysFromPublication = (Int(self.nowTimeStamp)! - timeshamp) / 86400
            
            cell.titleLabel.text = data.title
            cell.subTitleLabel.text = data.previewText
            
            self.labelsSize.append(cell.subTitleLabel.calculateMaxLines())
            
            switch eachCellStatus[indexPath.row] {
            case true:
                if  self.labelsSize[indexPath.row] <= 2 {
                    cell.expandButton.isHidden = true
                    cell.subTitleLabel.numberOfLines = 2
                }
                cell.subTitleLabel.numberOfLines = 2
            case false:
                cell.subTitleLabel.numberOfLines = 0
            }
            
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
            
            cell.updateButtonTitle(expandStatus: self.eachCellStatus[indexPath.row])
            
            cell.onButtonClick = { button in
                self.eachCellStatus[indexPath.row].toggle()
                cell.updateButtonTitle(expandStatus: self.eachCellStatus[indexPath.row])
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            return cell
        }
        
        return NewslineCell()
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postID = dataSourse[indexPath.row].postID

        detailPostURL = "https://raw.githubusercontent.com/anton-natife/jsons/master/api/posts/\(postID!).json"
        dowloadDetailPostData(urlString: detailPostURL)
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailVC

        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            
            if let imageURL = self.postDatailData?.postImage  {
                let url = URL(string: imageURL)
                if let data = try? Data(contentsOf: url!) {
                    detailVC?.postImageView.image = UIImage(data: data)
                }
            }
            
            detailVC?.titleLabel.text = self.postDatailData?.title
            detailVC?.subtitleLabel.text = self.postDatailData?.text
            detailVC?.likesCountLabel.text = "\(self.postDatailData?.likesCount ?? 0)"
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
    
            let date = Date(timeIntervalSince1970:  Double(self.postDatailData?.timeshamp ?? 0))
            dateFormatter.locale = Locale(identifier: "en_UK")
            detailVC?.dateOfPublicationLabel.text = "\(dateFormatter.string(from: date))"
            
            self.navigationController?.pushViewController(detailVC!, animated: true)
        }
        
    }
    
    
}
