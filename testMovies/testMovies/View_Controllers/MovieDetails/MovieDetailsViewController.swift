import UIKit
class MovieDetailViewController: UIViewController {
    
 //MARK: - Outlets
    @IBOutlet var starImageViews: [UIImageView]!
    @IBOutlet weak var labelForRating: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieIconImage: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var showMoreButton: UIButton!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var firstTimeShowedLabel: UILabel!
    @IBOutlet weak var stackViewForMovieIconImage: UIStackView!
    @IBOutlet weak var uiViewForMovieIconImage: UIView!
    
    //MARK: - Variables
    
    var selectedImage: UIImage!
    var centralofNewVcImage: UIImage!
    var selectedMovieName: String!
    var selectedOverview: String!
    var isTextExpanded = false
    var genreIds: [String] = []
    var voteCount: Double!
    var formattedVote: String = ""
    var selectedFistTimeShowed: String!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        firstTimeShowedLabel.text = selectedFistTimeShowed
        
        updateRating(rating: voteCount)
        setupFormattedVote()
        labelForRating.text = formattedVote
        labelForRating.font = .boldSystemFont(ofSize: 30)

        createTwoButtonofNavBar()
        movieImage.image = selectedImage
        movieIconImage.image = centralofNewVcImage
        movieNameLabel.text = selectedMovieName
        overviewLabel.numberOfLines = 3
        overviewLabel.text = selectedOverview
        genresLabel.text = genreIds.joined(separator: " | ")
        
        movieIconImage.layer.cornerRadius = 13
        uiViewForMovieIconImage.layer.cornerRadius = 13
        movieIconImage.layer.borderWidth = 3.0
        movieIconImage.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        overviewLabel.layer.shadowColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        overviewLabel.layer.shadowRadius = 3
        overviewLabel.layer.shadowOpacity = 1
        overviewLabel.layer.shadowOffset = CGSize(width: 4, height: 4)
        overviewLabel.layer.masksToBounds = false
        
        if let blurredImage = applyBlur(to: selectedImage, withRadius: 5.0) {
            // Отобразите размытое изображение
            movieImage.image = blurredImage
        }
    }
    //MARK: - Methods
    func setupFormattedVote() {
        // Выполните все необходимые вычисления для voteAverage
               // Например, округлите до ближайшего 0.5
        let roundedVote = String(format: "%.1f", voteCount)
          // Используйте roundedVote в качестве форматированного значения
          formattedVote = roundedVote
        }
    
    func updateRating(rating: Double){
        let normalizedRating = max(0, min(rating/2.0, 5))
        let filledStars = Int(normalizedRating)
        
        for i in  0..<starImageViews.count {
           let isFilled = i < filledStars
            setStarImage(index: i, isFilled: isFilled)
        }
    }
    
    func setStarImage(index: Int, isFilled: Bool){
        let starImageView = starImageViews[index]
        starImageView.image = isFilled ? UIImage(named: "starFill") : UIImage(named: "starEmpty")
    }
    
    func createTwoButtonofNavBar(){
        let leftButton = UIBarButtonItem(title: "", image: UIImage(systemName: "chevron.backward"), target: self, action: #selector(goBack))
        leftButton.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = leftButton
      
        let rightButton = UIBarButtonItem(title: "", image: UIImage(systemName: "arrowshape.turn.up.forward"), target: self, action: #selector(shareButtonTapped))
        rightButton.tintColor = UIColor.black
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func goBack(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func shareButtonTapped(){
        guard let image = selectedImage else {
            return
        }
        guard let name = selectedMovieName else {
            return
        }
        
        let itemsToShare: [Any] = [image, name]
        //Класс с помощью которого мы достаем панель
        let shareController = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
        
        shareController.completionWithItemsHandler = { _, bool, _, _  in
            if bool {
                print("Успешно")
            }
        }
        // отобразить на экране панель
        present(shareController, animated: true, completion: nil)
    }
    
    @IBAction func showMoreButtonTapped(_ sender: Any) {
        isTextExpanded.toggle()
        if isTextExpanded {
            overviewLabel.numberOfLines = 0
            showMoreButton.setTitle("Show Less ↑", for: .normal)
        } else {
            overviewLabel.numberOfLines = 3
            showMoreButton.setTitle("Show More ↓", for: .normal)
        }
    }
    
    func applyBlur(to image: UIImage, withRadius radius: CGFloat) -> UIImage? {
           let context = CIContext(options: nil)
           guard let ciImage = CIImage(image: image) else { return nil }
           // Создайте фильтр размытия
           let filter = CIFilter(name: "CIGaussianBlur")
           filter?.setValue(ciImage, forKey: kCIInputImageKey)
           filter?.setValue(radius, forKey: kCIInputRadiusKey)
           // Получите результат размытия
           if let outputCIImage = filter?.outputImage,
              let cgImage = context.createCGImage(outputCIImage, from: outputCIImage.extent) {
               let blurredImage = UIImage(cgImage: cgImage)
               return blurredImage
           }
           return nil
       }
}
