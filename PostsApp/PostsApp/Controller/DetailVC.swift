import UIKit

class DetailVC: UIViewController {
    
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()

        return scrollView
    }()
    
    var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    var postImageView: UIImageView = {
        let image = UIImage(named: "without_Internet.png")
        var postImageView = UIImageView(image: image)
        postImageView.contentMode = .scaleAspectFit
        return postImageView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Heavy", size: 20)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Heavy", size: 18)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()
    
    var likeImage: UIImageView = {
        let image = UIImage(named: "like.png")
        var likeImage = UIImageView(image: image)
        likeImage.contentMode = .scaleAspectFit
        return likeImage
    }()
    
    var likesCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Medium", size: 16)
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        return label
    }()
    
    var dateOfPublicationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir Medium", size: 16)
        label.textColor = .secondaryLabel
        label.numberOfLines = 1
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setContentView()
        setScrollView()
        setCinstraints()
    }
    
    func setContentView() {
        contentView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        contentView.addSubview(postImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(likeImage)
        contentView.addSubview(likesCountLabel)
        contentView.addSubview(dateOfPublicationLabel)
    }
    func setScrollView() {
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.addSubview(contentView)
        scrollView.contentSize = self.contentView.bounds.size
        scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(scrollView)
    }

    func setCinstraints() {
        [
            postImageView,
            titleLabel,
            subtitleLabel,
            likeImage,
            likesCountLabel,
            dateOfPublicationLabel
        ].forEach({$0.translatesAutoresizingMaskIntoConstraints = false})

        [
            postImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            postImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            postImageView.heightAnchor.constraint(equalToConstant: view.frame.size.width),
            postImageView.widthAnchor.constraint(equalToConstant: view.frame.size.width)
        ].forEach({$0.isActive = true})

        [
            titleLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ].forEach({$0.isActive = true})

        [
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ].forEach({$0.isActive = true})

        [
            likeImage.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20),
            likeImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            likeImage.widthAnchor.constraint(equalToConstant: 20),
            likeImage.heightAnchor.constraint(equalToConstant: 20)
        ].forEach({$0.isActive = true})

        [
            likesCountLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20),
            likesCountLabel.leadingAnchor.constraint(equalTo: likeImage.trailingAnchor, constant: 5),
            likesCountLabel.heightAnchor.constraint(equalToConstant: 20),
        ].forEach({$0.isActive = true})

        [
            dateOfPublicationLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20),
            dateOfPublicationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            likesCountLabel.heightAnchor.constraint(equalToConstant: 20)
        ].forEach({$0.isActive = true})

    }
  
    func updateContentViewFrame() {
        let postImageViewHeight = view.frame.size.width
        let titleLabelHeight = titleLabel.frame.size.height
        let subtitleLabelHeight = subtitleLabel.frame.size.height

        let height = postImageViewHeight + titleLabelHeight + subtitleLabelHeight + 100
        contentView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: height)
        
        scrollView.contentSize = self.contentView.bounds.size
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateContentViewFrame()
    }

    
    
}
