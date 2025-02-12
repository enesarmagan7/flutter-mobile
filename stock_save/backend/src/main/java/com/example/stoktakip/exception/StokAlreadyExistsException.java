package com.example.stoktakip.exception;

public class StokAlreadyExistsException extends RuntimeException {
    public StokAlreadyExistsException(String message) {
        super(message);
    }
}
