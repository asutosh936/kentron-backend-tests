package com.kentron.api;

import com.intuit.karate.junit5.Karate;

class KarateTests {
    @Karate.Test
    Karate testAll() {
        return Karate.run("classpath:features/auth.feature",
        "classpath:features/activityLogs/activity-logs.feature").relativeTo(getClass());
    }
}
