import Foundation

import Foundation

enum ObtainPostDetailResult {
    case success(posts: PostDetail)
    case failure(error: Error)
}

class DetailNetworkManager {
    
    let sessionConfiguration = URLSessionConfiguration.default
    let session = URLSession.shared
    let decoder = JSONDecoder()
    
    func obtainPost(url: String, complition: @escaping (ObtainPostDetailResult) -> Void) {
        let value = PostDetail.CodingKeys.self
        
        lazy var post = PostDetail(
            postID: Int(value.postID.rawValue),
            timeshamp: Int(value.timeshamp.rawValue),
            title: value.title.rawValue,
            text: value.text.rawValue,
            postImage: value.postImage.rawValue,
            likesCount: Int(value.likesCount.rawValue))
        
        // guard проверяет на ликвидность или на nil
        guard let url = URL(string: url) else {
            return
        }
        session.dataTask(with: url) { [weak self] data, response, error in
            
            // strongSelf - сильная ссылка на self которая гарантирует выполнение кода
            var result: ObtainPostDetailResult
            
            defer {
                // возврат в главном потоке
                DispatchQueue.main.async {
                    complition(result)
                }
            }
            
            guard let strongSelf = self else {
                
                result = .success(posts: post)
                return
            }
            
            if error == nil, let parsData = data {
                
                guard let posts = try? strongSelf.decoder.decode(DetailDataModel.self, from: parsData) else {
                    result = .success(posts: post)
                    return
                }
                
                result = .success(posts: posts.post!)
                
            } else {
                result = .failure(error: error!)
            }

        }.resume()
        // метод resume() запускает сессию
    }
}
