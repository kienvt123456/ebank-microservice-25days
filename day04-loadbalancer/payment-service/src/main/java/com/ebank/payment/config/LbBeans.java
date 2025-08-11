package com.ebank.payment.config;
import org.springframework.cloud.client.loadbalancer.LoadBalanced;
import org.springframework.context.annotation.Bean;import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;import org.springframework.web.reactive.function.client.WebClient;
@Configuration
public class LbBeans{
  @Bean @LoadBalanced RestTemplate restTemplate(){return new RestTemplate();}
  @Bean @LoadBalanced WebClient.Builder webClient(){return WebClient.builder();}
}
