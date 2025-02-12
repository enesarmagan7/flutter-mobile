package com.example.stoktakip.exception;

public class StokNotFoundException extends RuntimeException {
    public StokNotFoundException(String message) {
        super(message);
    }
}
