package com.ebank.payment.web;
import org.springframework.web.bind.annotation.GetMapping;import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;import org.springframework.web.reactive.function.client.WebClient;
@RestController
public class CallLoanController{
  private final RestTemplate rt; private final WebClient.Builder wb;
  public CallLoanController(RestTemplate rt, WebClient.Builder wb){this.rt=rt;this.wb=wb;}
  @GetMapping("/call-loan-rt") public String callLoanRt(){return rt.getForObject("http://loan-service/hello", String.class);}
  @GetMapping("/call-loan-wc") public String callLoanWc(){return wb.build().get().uri("http://loan-service/hello").retrieve().bodyToMono(String.class).block();}
}
