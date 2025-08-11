package com.ebank.payment.web;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class PingController {
    @GetMapping("/hello")
    public String hello() {
        return "payment-service is alive";
    }
}
