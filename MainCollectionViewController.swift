//
//  MainCollectionViewController.swift
//  PinUI
//
//  Created by ktds 22 on 2017. 8. 31..
//  Copyright © 2017년 OliveNetworks, Inc. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

// 이미지를 담을 뷰 선언
var photos:[UIImage]=[UIImage]()

class MainCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes -> 직접만들 셀을 사용하기때문에 주석처리
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        
        photos.append(UIImage(named: "a1")!)
        photos.append(UIImage(named: "a2")!)
        photos.append(UIImage(named: "a3")!)
        photos.append(UIImage(named: "a4")!)
        photos.append(UIImage(named: "a5")!)
        photos.append(UIImage(named: "a6")!)
        photos.append(UIImage(named: "a7")!)
        photos.append(UIImage(named: "a8")!)
        photos.append(UIImage(named: "a9")!)
        photos.append(UIImage(named: "a10")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
        if let photoCell = cell as? PhotoCollectionViewCell{
            photoCell.photoImageView.image=photos[indexPath.row]
        }

        
        return cell
    }
    
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

//cell 관련(소스파일을 분리해도 되지만 편의성을 위해 viewcontroll에 같이 작성)
class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
}


class CollectionViewFlowLayout: UICollectionViewFlowLayout {
    var layoutCache: [UICollectionViewLayoutAttributes]? = nil
    override func prepare() {
        super.prepare()
        // 가로(width)를 2로 나누어 여백을 5로 준 경우, width사이즈가 없을 경우 375를 나눈값으로 적용해라
        let width = (collectionView?.bounds.size.width ?? 375) / 2 - 5
        
        guard layoutCache == nil else { return }
        
        var attrsList: [UICollectionViewLayoutAttributes] = []
        for (index, image) in photos.enumerated() {
            let isOdd = index % 2 == 0
            let attrs = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: index, section: 0))
            let ratio = image.size.height / image.size.width
            let height = width * ratio
            
            var frame = CGRect(x: isOdd ? 0 : width + 10, y: 0, width: width, height: height)
            if index > 1 {
                let upperImage = attrsList[index-2]
                frame.origin.y = upperImage.frame.origin.y + upperImage.frame.size.height + 10
            }
            attrs.frame = frame
            
            attrsList.append(attrs)
        }
        layoutCache = attrsList
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let layoutCache = layoutCache else { return super.layoutAttributesForElements(in: rect) }
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in layoutCache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        
        return layoutAttributes
    }
}

