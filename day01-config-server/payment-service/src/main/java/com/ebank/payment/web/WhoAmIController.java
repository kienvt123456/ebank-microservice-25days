package com.ebank.payment.web;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.Map;
@RefreshScope @RestController
public class WhoAmIController {
  @Value("${app.greeting:Hello from payment-service (local)}") String greeting;
  @GetMapping("/whoami") public Map<String,Object> who(){ return Map.of("service","payment-service","greeting",greeting); }
}
