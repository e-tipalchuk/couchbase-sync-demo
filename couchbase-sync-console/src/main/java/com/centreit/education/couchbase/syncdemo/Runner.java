/*
 * (c) Центр ИТ, 2015. Все права защищены.
 */
package com.centreit.education.couchbase.syncdemo;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;

/**
 * @author Сергей Петунин
 * @created 10.04.15 0:54
 */
public class Runner {

    public static void main(String... args) throws Exception {

        CouchbaseService service = new CouchbaseService("http://localhost:4984/demo/");

        try (BufferedReader reader = new BufferedReader(new InputStreamReader(System.in))) {
            while (true) {
                String[] tokens = reader.readLine().split("\\s");
                switch (tokens[0]) {
                    case "start":
                        service.startup();
                        System.out.println("CBL started");
                        break;
                    case "attach":
                        try (InputStream stream = new URL(tokens[1]).openStream()) {
                            String id = service.saveAttachment(stream);
                            System.out.println("Saved image with id = " + id);
                        }
                        break;
                    case "exit":
                        service.shutdown();
                        System.out.println("CBL shut down");
                        return;
                }
            }
        }

    }

}
