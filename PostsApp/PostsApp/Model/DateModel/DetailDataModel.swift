import Foundation

// MARK: - DetailDataModel
struct DetailDataModel: Codable {
    let post: PostDetail?
}

// MARK: - Post
struct PostDetail: Codable {
    let postID, timeshamp: Int?
    let title, text: String?
    let postImage: String?
    let likesCount: Int?

    enum CodingKeys: String, CodingKey {
        case postID = "postId"
        case timeshamp, title, text, postImage
        case likesCount = "likes_count"
    }
}
