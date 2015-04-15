//
//  ViewController.swift
//  CouchbaseSyncDemo
//
//  Created by Сергей Петунин on 15.04.15.
//  Copyright (c) 2015 Центр ИТ. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

    private var images: [ImageModel] = []
    
    private var query: CBLLiveQuery?
    
    override func viewDidAppear(animated: Bool) {
        query = CouchbaseService.instance.getImagesLiveQuery()
        query!.addObserver(self, forKeyPath: "rows", options: nil, context: nil)
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if object as? NSObject == query {
            images.removeAll()
            var rows = query!.rows
            while let row = rows.nextRow() {
                images.append(ImageModel(forDocument: row.document))
            }
            collectionView?.reloadData()
        }
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! UICollectionViewCell
        cell.backgroundView = UIImageView(image:images[indexPath.item].image)
        return cell
    }

}

