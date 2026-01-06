package com.example.demo.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    // Root endpoint
    @GetMapping("/")
    public String hello() {
        return "Hello CI/CD"; // Toza text, emoji olib tashlandi
    }

    // Health check endpoint
    @GetMapping("/health")
    public String health() {
        return "OK";
    }
}
