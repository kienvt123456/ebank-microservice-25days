package com.ebank.gateway.security;

import org.springframework.cloud.gateway.filter.GatewayFilterChain;
import org.springframework.cloud.gateway.filter.GlobalFilter;
import org.springframework.core.Ordered;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

@Component
public class JwtAuthFilter implements GlobalFilter, Ordered {
  @Override
  public Mono<Void> filter(ServerWebExchange ex, GatewayFilterChain chain) {
    String p = ex.getRequest().getURI().getPath();
    if (p.startsWith("/actuator") || p.endsWith("/hello")) return chain.filter(ex);
    String h = ex.getRequest().getHeaders().getFirst("Authorization");
    if (h == null || !h.startsWith("Bearer ") || !"dev-token".equals(h.substring(7))) {
      ex.getResponse().setStatusCode(HttpStatus.UNAUTHORIZED);
      return ex.getResponse().setComplete();
    }
    return chain.filter(ex);
  }
  @Override public int getOrder() { return -1; }
}
