package com.qkl.utils;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JpaUtil {

    private static EntityManagerFactory factory;

    static {

        try {

            factory = Persistence.createEntityManagerFactory("QKL");

        } catch (Exception e) {

            e.printStackTrace();

        }

    }

    public static EntityManager getEntityManager() {

        return factory.createEntityManager();

    }

    public static void close() {

        if (factory != null) {

            factory.close();

        }

    }

}