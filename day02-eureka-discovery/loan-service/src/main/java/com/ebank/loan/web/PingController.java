package com.ebank.loan.web;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class PingController {
    @GetMapping("/hello")
    public String hello() {
        return "loan-service is alive";
    }
}
