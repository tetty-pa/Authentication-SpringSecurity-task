package com.epam.esm.exception;

public class InvalidParameterException extends RuntimeException{

    public InvalidParameterException() {
        super();
    }

    public InvalidParameterException(String message) {
        super(message);
    }

}
