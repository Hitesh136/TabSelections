//
//  ViewController.swift
//  Tab Selections
//
//  Created by Hitesh Agarwal on 28/06/17.
//  Copyright © 2017 Finoit Technologies. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var arrAdded = ["Facebook", "Google", "Apple", "Tesla"]
    var arrRemoved = ["Youtube", "Samsung", "LG", "Github"]
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "OptionCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "OptionCollectionViewCell")
        
        collectionView.register(UINib(nibName: "SectionView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "SectionView")
        collectionView.layer.borderColor = UIColor.black.cgColor
        collectionView.layer.borderWidth = 5
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getWidthForCell(withMessage message: String) -> CGFloat {
        
        if let font = UIFont(name: "Helvetica", size: 17.0 ) {
            let fontAttributes = [NSAttributedStringKey.font: font]
            let size = (message as NSString).size(withAttributes: fontAttributes)
            
            var textWidth = size.width
            // 40 = side margins
            textWidth = textWidth + 50;
            return textWidth
        }
        return 0.0
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return arrAdded.count
        }
        return arrRemoved.count
        //        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let cell = SectionView()
        switch kind {
        case UICollectionElementKindSectionHeader:
            let sectionView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "SectionView", for: indexPath) as! SectionView
            if indexPath.section == 0 {
                sectionView.label.text = "Selected"
            }
            else {
                sectionView.label.text = "Suggestion"
            }
            return sectionView
        default:
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OptionCollectionViewCell", for: indexPath) as! OptionCollectionViewCell
            cell.label.text = arrAdded[indexPath.row]
            cell.delegate = self
            cell.index = indexPath.row
            cell.customContentView.backgroundColor = UIColor(red: 249.0/255.0, green:
                117.0/255.0, blue: 31.0/255.0, alpha: 1.0)
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OptionCollectionViewCell", for: indexPath) as! OptionCollectionViewCell
            cell.label.text = arrRemoved[indexPath.row]
            cell.index = indexPath.row
            cell.delegate = self
            cell.customContentView.backgroundColor = UIColor(red: 250.0/255.0, green:
                188.0/255.0, blue: 145.0/255.0, alpha: 1.0)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 40.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let selectedString = arrAdded[indexPath.row]
            arrAdded.remove(at: indexPath.row)
            arrRemoved.append(selectedString)
        }
        else {
            let unselectedString = arrRemoved[indexPath.row]
            arrRemoved.remove(at: indexPath.row)
            arrAdded.append(unselectedString)
        }
        collectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var width: CGFloat = 0.0
        if indexPath.section == 0 {
            width = getWidthForCell(withMessage: arrAdded[indexPath.row])
        }else {
            width = getWidthForCell(withMessage: arrRemoved[indexPath.row])
        }
        
        if width >= UIScreen.main.bounds.width - 30 {
            width = 200
        }
        return CGSize(width: width, height: 50.0)
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


extension ViewController: OptionCollectionViewCellDelegate {
    func passBackAddAction(index: Int) {
        let strAdd = arrAdded[index]
        self.arrAdded.remove(at: index)
        self.arrRemoved.append(strAdd)
        
        collectionView.reloadData()
    }
}
