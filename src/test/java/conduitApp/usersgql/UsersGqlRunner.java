package conduitApp.usersgql;

import com.intuit.karate.junit5.Karate;

class UsersRunner {

    @Karate.Test
    Karate testUsers() {
        return Karate.run("usersgql").relativeTo(getClass());
    }

}
