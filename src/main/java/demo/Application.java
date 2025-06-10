package demo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;

@SpringBootApplication
@EnableScheduling
public class Application {

    private static final Logger logger = LoggerFactory.getLogger(Application.class);

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

    @Scheduled(fixedRate = 5000)
    public void executeTask() {
        try {
            int times = 1 + (int) (Math.random() * 5);

            for (int i = 0; i < times; i++) {
                java.net.URL url = new java.net.URL("http://localhost:8080/");
                java.net.HttpURLConnection conn = (java.net.HttpURLConnection) url.openConnection();
                conn.setRequestMethod("GET");
                conn.getResponseCode();
                conn.disconnect();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}