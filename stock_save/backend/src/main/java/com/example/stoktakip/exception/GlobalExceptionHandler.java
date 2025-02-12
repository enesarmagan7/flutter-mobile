package com.example.stoktakip.exception;

import com.example.stoktakip.util.MessageHelper;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(StokNotFoundException.class)
    public ResponseEntity<Map<String, Object>> handleStokNotFoundException(StokNotFoundException ex) {
        Map<String, Object> body = createErrorBody(ex.getMessage(), HttpStatus.NOT_FOUND);
        return new ResponseEntity<>(body, HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler(StokAlreadyExistsException.class)
    public ResponseEntity<Map<String, Object>> handleStokAlreadyExistsException(StokAlreadyExistsException ex) {
        Map<String, Object> body = createErrorBody(ex.getMessage(), HttpStatus.CONFLICT);
        return new ResponseEntity<>(body, HttpStatus.CONFLICT);
    }

    @ExceptionHandler(StokValidationException.class)
    public ResponseEntity<Map<String, Object>> handleStokValidationException(StokValidationException ex) {
        Map<String, Object> body = createErrorBody(ex.getMessage(), HttpStatus.BAD_REQUEST);
        return new ResponseEntity<>(body, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(DatabaseException.class)
    public ResponseEntity<Map<String, Object>> handleDatabaseException(DatabaseException ex) {
        Map<String, Object> body = createErrorBody(ex.getMessage(), HttpStatus.INTERNAL_SERVER_ERROR);
        return new ResponseEntity<>(body, HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<Map<String, Object>> handleGlobalException(Exception ex) {
        Map<String, Object> body = createErrorBody(
            MessageHelper.getUnexpectedErrorMessage(),
            HttpStatus.INTERNAL_SERVER_ERROR
        );
        body.put("error", ex.getMessage());
        return new ResponseEntity<>(body, HttpStatus.INTERNAL_SERVER_ERROR);
    }

    private Map<String, Object> createErrorBody(String message, HttpStatus status) {
        Map<String, Object> body = new HashMap<>();
        body.put("timestamp", LocalDateTime.now());
        body.put("message", message);
        body.put("status", status.value());
        return body;
    }
}
