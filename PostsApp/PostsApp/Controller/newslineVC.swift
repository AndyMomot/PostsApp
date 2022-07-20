//
//  newslineVC.swift
//  PostsApp
//
//  Created by Андрей on 20.07.2022.
//

import UIKit

class newslineVC: UITableViewController {
    
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
        
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
                return
            }

            guard let data = data else {
                return
            }

            do {
                let post = try JSONDecoder().decode(NewsLineDataModel.self, from: data)
                
                let posts = post.posts
                self.dataSourse = posts ?? []
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
               
                //let seconds = post.posts?.first?.timeshamp!

//                let daysAgo: Int = (Int(self.nowTimeStamp)! - seconds!) / 86400
//
//                switch daysAgo {
//                case 0..<30 :
//                    print("\(daysAgo) days ago")
//                case 30..<366:
//                    print("\(daysAgo / 30) months ago")
//                case 366..<1825 :
//                    print("\(daysAgo / 365) years ago")
//                default:
//                    return
//                }

                // print(self.dateFormatter(date: Date(time)))
            } catch {
                print(error)
            }


        }.resume()
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
         if let cell = tableView.dequeueReusableCell(withIdentifier: "newslineCell", for: indexPath) as? newslineCell {
             
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
         
         return newslineCell()
     }
     
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
