package demo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class Controller {
    
    private static final Logger logger = LoggerFactory.getLogger(Controller.class);

    private int requestCount = 0;

    @GetMapping("/")
	public String index() {
        requestCount++;
        logger.info("Received a request at / - Count: {}", requestCount);
		return "Greetings from Spring Boot!";
	}

}
