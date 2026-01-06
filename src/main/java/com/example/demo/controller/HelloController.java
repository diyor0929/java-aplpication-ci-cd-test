package com.example.demo.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @GetMapping("/")
    public String hello() {
<<<<<<< HEAD
        return "Hello CI/CD";
=======
        return "Hello CI/CD";
>>>>>>> 7679cedc6e505fae07ee832005d6803ba6ffab96
    }

    @GetMapping("/health")
    public String health() {
        return "OK";
    }
}
