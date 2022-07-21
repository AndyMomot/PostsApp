import Foundation

enum ObtainPostResult {
    case success(posts: [Post])
    case failure(error: Error)
}

class NetworkManager {
    
    let sessionConfiguration = URLSessionConfiguration.default
    let session = URLSession.shared
    let decoder = JSONDecoder()
    
    func obtainPost(complition: @escaping (ObtainPostResult) -> Void) {
        
        // guard проверяет на ликвидность или на nil
        guard let url = URL(string: "https://raw.githubusercontent.com/anton-natife/jsons/master/api/main.json") else {
            return
        }
        session.dataTask(with: url) { [weak self] data, response, error in
            // data - та самая инфа которую нужно получить (текст, фото, видео)
            // response - это класс, который возвращается с гдобальным ответом на запрос (успех запроса...)
            // error - возможная ошибка
            
            // strongSelf - сильная ссылка на self которая гарантирует выполнение кода
            var result: ObtainPostResult
            
            defer {
                // возврат в главном потоке
                DispatchQueue.main.async {
                    complition(result)
                }
            }
            
            guard let strongSelf = self else {
                
                result = .success(posts: [])
                return
            }
            
            if error == nil, let parsData = data {
                
                guard let posts = try? strongSelf.decoder.decode(NewsLineDataModel.self, from: parsData) else {
                    
                    result = .success(posts: [])
                    return
                }
                
                result = .success(posts: posts.posts ?? [])
                
            } else {
                result = .failure(error: error!)
            }
            
            
            
        }.resume()
        // метод resume() запускает сессию
    }
}
