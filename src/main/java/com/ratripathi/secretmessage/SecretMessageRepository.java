package com.ratripathi.secretmessage;

import org.springframework.data.repository.CrudRepository;

// This will be AUTO IMPLEMENTED by Spring into a Bean called secretMessageRepository

public interface SecretMessageRepository extends CrudRepository<SecretMessage, Integer> {

}
