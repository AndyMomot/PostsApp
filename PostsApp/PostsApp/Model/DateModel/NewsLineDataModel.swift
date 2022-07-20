import Foundation

// MARK: - NewsLineDataModel
struct NewsLineDataModel: Codable {
    let posts: [Post]?
}

// MARK: - Post
struct Post: Codable {
    let postID, timeshamp: Int?
    let title, previewText: String?
    let likesCount: Int?

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case timeshamp, title
        case previewText = "preview_text"
        case likesCount = "likes_count"
    }
}
