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

        try {
            java.net.http.HttpClient client = java.net.http.HttpClient.newHttpClient();
            java.net.http.HttpRequest request = java.net.http.HttpRequest.newBuilder()
                    .uri(java.net.URI.create("https://wttr.in/Nuremberg?format=3"))
                    .build();
            java.net.http.HttpResponse<String> response = client.send(request, java.net.http.HttpResponse.BodyHandlers.ofString());
            logger.info(response.body());
            return response.body();
        } catch (Exception e) {
            logger.error("Error fetching joke", e);
            return "Failed to fetch joke";
        }

	}

}
