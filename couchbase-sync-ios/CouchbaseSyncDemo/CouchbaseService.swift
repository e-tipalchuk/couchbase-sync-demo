//
//  CouchbaseService.swift
//  CouchbaseSyncDemo
//
//  Created by Сергей Петунин on 15.04.15.
//  Copyright (c) 2015 Центр ИТ. All rights reserved.
//

import Foundation

private let CouchbaseServiceInstance = CouchbaseService()

class CouchbaseService {
    
    class var instance: CouchbaseService {
        return CouchbaseServiceInstance
    }
    
    private let pull: CBLReplication
    private let database: CBLDatabase
    
    private init() {
        
        // создаём или открываем БД
        database = CBLManager.sharedInstance().databaseNamed("demo", error: nil)
        
        // создаём входящую и исходящую репликацию
        let syncGatewayUrl = NSURL(string: "http://localhost:4984/demo/")
        pull = database.createPullReplication(syncGatewayUrl)
        pull.continuous = true;
        pull.start()
        
        // создаём представление со всеми документами в базе
        database.viewNamed("images").setMapBlock({(doc: [NSObject : AnyObject]!, emit: CBLMapEmitBlock!) -> Void in
            emit(doc["timestamp_added"], nil)
            }, version: "1")
    }
    
    func getImagesLiveQuery() -> CBLLiveQuery {
        return database.viewNamed("images").createQuery().asLiveQuery()
    }
    
}