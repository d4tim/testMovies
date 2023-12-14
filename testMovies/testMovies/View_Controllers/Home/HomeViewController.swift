//
//  HomeViewController.swift
//  testMovies
//
//  Created by Дмитрий Тимаров on 11.12.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
       
    
    
    private var movies: [Movies] = []
    private let networkManager = MoviesNetworkManager()
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // var data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        networkManager.fetchNowPlayingMovies { res in
            switch res {
                
            case let .success(moviesResult):
                print(moviesResult)
                self.movies = moviesResult.results
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    // reloadCollection тут должен быть
                }
            case let .failure(error):
                print(error)
            }
        }
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let nib = UINib(nibName: "HomeCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "HomeCollectionViewCell")
        // Do any additional setup after loading the view.
    }
    
    
    
    
    
}

extension HomeViewController: UICollectionViewDelegate , UICollectionViewDataSource {
    
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        
        
        print(movies[indexPath.row].name)
        let url = URL(string: movies[indexPath.row].posterFullPath)
        let data = try?Data(contentsOf: url!)
        cell.imagesOfCollections.image = UIImage(data: data!)
        
        
        
        
        return cell
    }
    
   
    
   
    
    
}


extension HomeViewController: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
               let numberOfItemsPerRow: CGFloat = 3
               let spacingBetweenCells: CGFloat = 17.0 //отступы между нашими картинками по бокам
               let totalSpacing = (numberOfItemsPerRow - 1) * spacingBetweenCells
               let width = (collectionView.bounds.width - totalSpacing) / numberOfItemsPerRow
               let height = width * 1.5
               return CGSize(width: width, height: height)
           }
           
           func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
               return 17.0 // отступы между рядами
           }
           
           func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
               return UIEdgeInsets(top: 1.0, left: 5.0, bottom: 1.0, right: 5.0)
           }
           
           func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
               return 1.0
           }
       }






