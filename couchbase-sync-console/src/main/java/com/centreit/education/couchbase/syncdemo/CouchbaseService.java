package com.centreit.education.couchbase.syncdemo;

import com.couchbase.lite.*;
import com.couchbase.lite.replicator.Replication;

import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * @author Сергей Петунин
 * @created 10.04.15 0:54
 */
public class CouchbaseService {

    private String syncGatewayUrl;
    private Database database;
    private Manager manager;
    private Replication push;

    public CouchbaseService(String syncGatewayUrl) {
        this.syncGatewayUrl = syncGatewayUrl;
    }

    public void startup() throws CouchbaseLiteException, IOException {
        manager = new Manager(new JavaContext(), new ManagerOptions());
        database = manager.getDatabase("demo");

        URL url = new URL(syncGatewayUrl);

        push = database.createPushReplication(url);
        push.setContinuous(true);
        push.addChangeListener(event -> System.out.println("push event: " + event));
        push.start();

    }

    public String saveAttachment(InputStream stream) throws CouchbaseLiteException {
        Document document = database.createDocument();
        UnsavedRevision revision = document.createRevision();
        revision.setAttachment("image", "image/png", stream);
        revision.getProperties().put("timestamp_added", DateTimeFormatter.ISO_DATE_TIME.format(LocalDateTime.now()));
        revision.save();
        return document.getId();
    }

    public void shutdown() {
        if (push != null && push.isRunning()) {
            push.goOffline();
        }
        manager.close();
    }

}
