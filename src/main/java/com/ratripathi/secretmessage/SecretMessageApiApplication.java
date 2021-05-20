package com.ratripathi.secretmessage;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
@RequestMapping(path="/api/v1")
public class SecretMessageApiApplication {

  public static void main(String[] args) {
    SpringApplication.run(SecretMessageApiApplication.class, args);
  }

  @GetMapping("/healthcheck")
    public String healthcheck() {
    return String.format("The secret Message API application is healthy!");
  }

}
