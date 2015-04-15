# Couchbase to Couchbase Lite synchronization demo
- `couchbase-sync-console` — a console Java app that starts a local Couchbase Lite database and syncs it with Couchbase Server on [http://localhost:4984/demo/](http://localhost:4984/demo/). Once started, it accepts the following commands:
  - _start_ — start the replication, 
  - _attach image_url_ — create a new document with attachment from url,
  - _stop_ — stop the replication. 

This app also depends on couchbase-lite-java-native, couchbase-lite-java-core and couchbase-lite-java which aren't on Maven Central repo yet, so you'll have to install them manually to your local repo :o)
- `couchbase-sync-ios` — an iOS app that syncs through the same Sync Gateway [http://localhost:4984/demo/](http://localhost:4984/demo/) and displays the added documents as images in a `UICollectionView`.
- `sync-gateway-config.json` — a config file for Sync Gateway
