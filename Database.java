import java.util.HashMap;
import java.util.Map;

public class Database {
  public static final Map<String, String> teamNameAndIDHash = new HashMap<String, String>();
  public static final Map<String, String> playerNameAndIDHash = new HashMap<String, String>();

  static {
    // ******* START OF TEAM NAME AND IDs *******
    // EASTERN CONFFERENCE
    // South East
    teamNameAndIDHash.put("Wizards", "583ec8d4-fb46-11e1-82cb-f4ce4684ea4c");
    teamNameAndIDHash.put("Hornets", "583ec97e-fb46-11e1-82cb-f4ce4684ea4c");
    teamNameAndIDHash.put("Hawks", "583ecb8f-fb46-11e1-82cb-f4ce4684ea4c");
    teamNameAndIDHash.put("Heat", "583ecea6-fb46-11e1-82cb-f4ce4684ea4c");
    teamNameAndIDHash.put("Magic", "583ed157-fb46-11e1-82cb-f4ce4684ea4c");

    // Atlantic
    teamNameAndIDHash.put("Knicks", "583ec70e-fb46-11e1-82cb-f4ce4684ea4c");
    teamNameAndIDHash.put("76ers", "583ec87d-fb46-11e1-82cb-f4ce4684ea4c");
    teamNameAndIDHash.put("Nets", "583ec9d6-fb46-11e1-82cb-f4ce4684ea4c");
    teamNameAndIDHash.put("Celtics", "583eccfa-fb46-11e1-82cb-f4ce4684ea4c");
    teamNameAndIDHash.put("Raptors", "583ecda6-fb46-11e1-82cb-f4ce4684ea4c");

    // Central
    teamNameAndIDHash.put("Bulls", "583ec5fd-fb46-11e1-82cb-f4ce4684ea4c");
    teamNameAndIDHash.put("Cavaliers", "583ec773-fb46-11e1-82cb-f4ce4684ea4c");
    teamNameAndIDHash.put("Pacers", "583ec7cd-fb46-11e1-82cb-f4ce4684ea4c");
    teamNameAndIDHash.put("Pistons", "583ec928-fb46-11e1-82cb-f4ce4684ea4c");
    teamNameAndIDHash.put("Bucks", "583ecefd-fb46-11e1-82cb-f4ce4684ea4c");

    // WESTERN CONFERENCE
    // North West
    teamNameAndIDHash.put("Timberwolves", "583eca2f-fb46-11e1-82cb-f4ce4684ea4c");
    teamNameAndIDHash.put("Jazz", "583ece50-fb46-11e1-82cb-f4ce4684ea4c");
    teamNameAndIDHash.put("Thunder", "583ecfff-fb46-11e1-82cb-f4ce4684ea4c");
    teamNameAndIDHash.put("Trail Blazers", "583ed056-fb46-11e1-82cb-f4ce4684ea4c");
    teamNameAndIDHash.put("Nuggets", "583ed102-fb46-11e1-82cb-f4ce4684ea4c");

    // South West
    teamNameAndIDHash.put("Grizzlies", "583eca88-fb46-11e1-82cb-f4ce4684ea4c");
    teamNameAndIDHash.put("Rockets", "583ecb3a-fb46-11e1-82cb-f4ce4684ea4c");
    teamNameAndIDHash.put("Pelicans", "583ecc9a-fb46-11e1-82cb-f4ce4684ea4c");
    teamNameAndIDHash.put("Spurs", "583ecd4f-fb46-11e1-82cb-f4ce4684ea4c");
    teamNameAndIDHash.put("Mavericks", "583ecf50-fb46-11e1-82cb-f4ce4684ea4c");

    // Pacific
    teamNameAndIDHash.put("Warriors", "583ec825-fb46-11e1-82cb-f4ce4684ea4c");
    teamNameAndIDHash.put("Lakers", "583ecae2-fb46-11e1-82cb-f4ce4684ea4c");
    teamNameAndIDHash.put("Clippers", "583ecdfb-fb46-11e1-82cb-f4ce4684ea4c");
    teamNameAndIDHash.put("Suns", "583ecfa8-fb46-11e1-82cb-f4ce4684ea4c");
    teamNameAndIDHash.put("Kings", "583ed0ac-fb46-11e1-82cb-f4ce4684ea4c");
    // ******* END OF TEAM NAME AND IDs *******
    //*** Adding players for testing *** 
    playerNameAndIDHash.put("Stephen Curry", "8ec91366-faea-4196-bbfd-b8fab7434795");
    playerNameAndIDHash.put("Lebron James", "0afbe608-940a-4d5d-a1f7-468718c67d91");
  }

  @Override
    public String toString() {
    String result = "";
    result += teamNameAndIDHash.toString();
    return result;
  }
}

