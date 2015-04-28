public class NBAGameSummary {
  private String gameTitle;
  private String gameStatus;
  private String gameScheduled;
  private String gameAttendance;
  private String gameClock;
  private String gameQuarter;
  
  // ***** START HOME ****
  // Home Team Data
  private String homeTeamName;
  private String homeTeamID;

  // Quarterly Points
  private int homeQuarterOnePoints;
  private int homeQuarterTwoPoints;
  private int homeQuarterThreePoints;
  private int homeQuarterFourPoints;

  // Team Statistics
  private String homeMinutes;
  private int homeFieldGoalsMade;
  private int homeFieldGoalsAtt;
  private float homeFieldGoalsPct;
  private int homeThreePointsMade;
  private int homeThreePointsAtt;
  private float homeThreePointsPct;
  private int homeTwoPointsMade;
  private int homeTwoPointsAtt;
  private float homeTwoPointsPct;
  private int homeBlockedAtt;
  private int homeFreeThrowsMade;
  private int homeFreeThrowsAtt;
  private float homeFreeThrowsPct;
  private int homeOffensiveRebounds;
  private int homeDefensiveRebounds;
  private int homeRebounds;
  private int homeAssists;
  private int homeTurnovers;
  private int homeSteals;
  private int homeBlocks;
  private float homeAssistsTurnoverRatio;
  private int homePersonalFouls;
  private int homePoints;
  private int homeTeamTurnovers;
  private int homeTeamRebounds;
  private int homeFlagrantFouls;
  private int homePlayerTechFouls;
  private int homeTeamTechFouls;
  private int homeCoachTechFouls;
  // ***** END HOME ****
  
  // ***** START AWAY ****
  // Away Team Data
  private String awayTeamName;
  private String awayTeamID;

  // Quarterly Points
  private int awayQuarterOnePoints;
  private int awayQuarterTwoPoints;
  private int awayQuarterThreePoints;
  private int awayQuarterFourPoints;

  // Team Statistics
  private String awayMinutes;
  private int awayFieldGoalsMade;
  private int awayFieldGoalsAtt;
  private float awayFieldGoalsPct;
  private int awayThreePointsMade;
  private int awayThreePointsAtt;
  private float awayThreePointsPct;
  private int awayTwoPointsMade;
  private int awayTwoPointsAtt;
  private float awayTwoPointsPct;
  private int awayBlockedAtt;
  private int awayFreeThrowsMade;
  private int awayFreeThrowsAtt;
  private float awayFreeThrowsPct;
  private int awayOffensiveRebounds;
  private int awayDefensiveRebounds;
  private int awayRebounds;
  private int awayAssists;
  private int awayTurnovers;
  private int awaySteals;
  private int awayBlocks;
  private float awayAssistsTurnoverRatio;
  private int awayPersonalFouls;
  private int awayPoints;
  private int awayTeamTurnovers;
  private int awayTeamRebounds;
  private int awayFlagrantFouls;
  private int awayPlayerTechFouls;
  private int awayTeamTechFouls;
  private int awayCoachTechFouls;
  // ***** END AWAY ****

  public NBAGameSummary() {
    this.homeTeamName = "";
    this.homeTeamID = "";
    this.homeQuarterOnePoints = 0;
    this.homeQuarterTwoPoints = 0;
    this.homeQuarterThreePoints = 0;
    this.homeQuarterFourPoints = 0;
    this.homeMinutes = "";
    this.homeFieldGoalsMade = 0;
    this.homeFieldGoalsAtt = 0;
    this.homeFieldGoalsPct = 0;
    this.homeThreePointsMade = 0;
    this.homeThreePointsAtt = 0;
    this.homeThreePointsPct = 0;
    this.homeTwoPointsMade = 0;
    this.homeTwoPointsAtt = 0;
    this.homeTwoPointsPct = 0;
    this.homeBlockedAtt = 0;
    this.homeFreeThrowsMade = 0;
    this.homeFreeThrowsAtt = 0;
    this.homeFreeThrowsPct = 0;
    this.homeOffensiveRebounds = 0;
    this.homeDefensiveRebounds = 0;
    this.homeRebounds = 0;
    this.homeAssists = 0;
    this.homeTurnovers = 0;
    this.homeSteals = 0;
    this.homeBlocks = 0;
    this.homeAssistsTurnoverRatio = 0;
    this.homePersonalFouls = 0;
    this.homePoints = 0;
    this.homeTeamTurnovers = 0;
    this.homeTeamRebounds = 0;
    this.homeFlagrantFouls = 0;
    this.homePlayerTechFouls = 0;
    this.homeTeamTechFouls = 0;
    this.homeCoachTechFouls = 0;
    this.awayTeamName = "";
    this.awayTeamID = "";
    this.awayQuarterOnePoints = 0;
    this.awayQuarterTwoPoints = 0;
    this.awayQuarterThreePoints = 0;
    this.awayQuarterFourPoints = 0;
    this.awayMinutes = "";
    this.awayFieldGoalsMade = 0;
    this.awayFieldGoalsAtt = 0;
    this.awayFieldGoalsPct = 0;
    this.awayThreePointsMade = 0;
    this.awayThreePointsAtt = 0;
    this.awayThreePointsPct = 0;
    this.awayTwoPointsMade = 0;
    this.awayTwoPointsAtt = 0;
    this.awayTwoPointsPct = 0;
    this.awayBlockedAtt = 0;
    this.awayFreeThrowsMade = 0;
    this.awayFreeThrowsAtt = 0;
    this.awayFreeThrowsPct = 0;
    this.awayOffensiveRebounds = 0;
    this.awayDefensiveRebounds = 0;
    this.awayRebounds = 0;
    this.awayAssists = 0;
    this.awayTurnovers = 0;
    this.awaySteals = 0;
    this.awayBlocks = 0;
    this.awayAssistsTurnoverRatio = 0;
    this.awayPersonalFouls = 0;
    this.awayPoints = 0;
    this.awayTeamTurnovers = 0;
    this.awayTeamRebounds = 0;
    this.awayFlagrantFouls = 0;
    this.awayPlayerTechFouls = 0;
    this.awayTeamTechFouls = 0;
    this.awayCoachTechFouls = 0;
  }

    public NBAGameSummary(String gameTitle, String gameStatus, String gameScheduled, String gameAttendance, String gameClock, String gameQuarter, String homeTeamName, String homeTeamID, int homeQuarterOnePoints, int homeQuarterTwoPoints, int homeQuarterThreePoints, int homeQuarterFourPoints, String homeMinutes, int homeFieldGoalsMade, int homeFieldGoalsAtt, float homeFieldGoalsPct, int homeThreePointsMade, int homeThreePointsAtt, float homeThreePointsPct, int homeTwoPointsMade, int homeTwoPointsAtt, float homeTwoPointsPct, int homeBlockedAtt, int homeFreeThrowsMade, int homeFreeThrowsAtt, float homeFreeThrowsPct, int homeOffensiveRebounds, int homeDefensiveRebounds, int homeRebounds, int homeAssists, int homeTurnovers, int homeSteals, int homeBlocks, float homeAssistsTurnoverRatio, int homePersonalFouls, int homePoints, int homeTeamTurnovers, int homeTeamRebounds, int homeFlagrantFouls, int homePlayerTechFouls, int homeTeamTechFouls, int homeCoachTechFouls, String awayTeamName, String awayTeamID, int awayQuarterOnePoints, int awayQuarterTwoPoints, int awayQuarterThreePoints, int awayQuarterFourPoints, String awayMinutes, int awayFieldGoalsMade, int awayFieldGoalsAtt, float awayFieldGoalsPct, int awayThreePointsMade, int awayThreePointsAtt, float awayThreePointsPct, int awayTwoPointsMade, int awayTwoPointsAtt, float awayTwoPointsPct, int awayBlockedAtt, int awayFreeThrowsMade, int awayFreeThrowsAtt, float awayFreeThrowsPct, int awayOffensiveRebounds, int awayDefensiveRebounds, int awayRebounds, int awayAssists, int awayTurnovers, int awaySteals, int awayBlocks, float awayAssistsTurnoverRatio, int awayPersonalFouls, int awayPoints, int awayTeamTurnovers, int awayTeamRebounds, int awayFlagrantFouls, int awayPlayerTechFouls, int awayTeamTechFouls, int awayCoachTechFouls) {
        this.gameTitle = gameTitle;
        this.gameStatus = gameStatus;
        this.gameScheduled = gameScheduled;
        this.gameAttendance = gameAttendance;
        this.gameClock = gameClock;
        this.gameQuarter = gameQuarter;
        this.homeTeamName = homeTeamName;
        this.homeTeamID = homeTeamID;
        this.homeQuarterOnePoints = homeQuarterOnePoints;
        this.homeQuarterTwoPoints = homeQuarterTwoPoints;
        this.homeQuarterThreePoints = homeQuarterThreePoints;
        this.homeQuarterFourPoints = homeQuarterFourPoints;
        this.homeMinutes = homeMinutes;
        this.homeFieldGoalsMade = homeFieldGoalsMade;
        this.homeFieldGoalsAtt = homeFieldGoalsAtt;
        this.homeFieldGoalsPct = homeFieldGoalsPct;
        this.homeThreePointsMade = homeThreePointsMade;
        this.homeThreePointsAtt = homeThreePointsAtt;
        this.homeThreePointsPct = homeThreePointsPct;
        this.homeTwoPointsMade = homeTwoPointsMade;
        this.homeTwoPointsAtt = homeTwoPointsAtt;
        this.homeTwoPointsPct = homeTwoPointsPct;
        this.homeBlockedAtt = homeBlockedAtt;
        this.homeFreeThrowsMade = homeFreeThrowsMade;
        this.homeFreeThrowsAtt = homeFreeThrowsAtt;
        this.homeFreeThrowsPct = homeFreeThrowsPct;
        this.homeOffensiveRebounds = homeOffensiveRebounds;
        this.homeDefensiveRebounds = homeDefensiveRebounds;
        this.homeRebounds = homeRebounds;
        this.homeAssists = homeAssists;
        this.homeTurnovers = homeTurnovers;
        this.homeSteals = homeSteals;
        this.homeBlocks = homeBlocks;
        this.homeAssistsTurnoverRatio = homeAssistsTurnoverRatio;
        this.homePersonalFouls = homePersonalFouls;
        this.homePoints = homePoints;
        this.homeTeamTurnovers = homeTeamTurnovers;
        this.homeTeamRebounds = homeTeamRebounds;
        this.homeFlagrantFouls = homeFlagrantFouls;
        this.homePlayerTechFouls = homePlayerTechFouls;
        this.homeTeamTechFouls = homeTeamTechFouls;
        this.homeCoachTechFouls = homeCoachTechFouls;
        this.awayTeamName = awayTeamName;
        this.awayTeamID = awayTeamID;
        this.awayQuarterOnePoints = awayQuarterOnePoints;
        this.awayQuarterTwoPoints = awayQuarterTwoPoints;
        this.awayQuarterThreePoints = awayQuarterThreePoints;
        this.awayQuarterFourPoints = awayQuarterFourPoints;
        this.awayMinutes = awayMinutes;
        this.awayFieldGoalsMade = awayFieldGoalsMade;
        this.awayFieldGoalsAtt = awayFieldGoalsAtt;
        this.awayFieldGoalsPct = awayFieldGoalsPct;
        this.awayThreePointsMade = awayThreePointsMade;
        this.awayThreePointsAtt = awayThreePointsAtt;
        this.awayThreePointsPct = awayThreePointsPct;
        this.awayTwoPointsMade = awayTwoPointsMade;
        this.awayTwoPointsAtt = awayTwoPointsAtt;
        this.awayTwoPointsPct = awayTwoPointsPct;
        this.awayBlockedAtt = awayBlockedAtt;
        this.awayFreeThrowsMade = awayFreeThrowsMade;
        this.awayFreeThrowsAtt = awayFreeThrowsAtt;
        this.awayFreeThrowsPct = awayFreeThrowsPct;
        this.awayOffensiveRebounds = awayOffensiveRebounds;
        this.awayDefensiveRebounds = awayDefensiveRebounds;
        this.awayRebounds = awayRebounds;
        this.awayAssists = awayAssists;
        this.awayTurnovers = awayTurnovers;
        this.awaySteals = awaySteals;
        this.awayBlocks = awayBlocks;
        this.awayAssistsTurnoverRatio = awayAssistsTurnoverRatio;
        this.awayPersonalFouls = awayPersonalFouls;
        this.awayPoints = awayPoints;
        this.awayTeamTurnovers = awayTeamTurnovers;
        this.awayTeamRebounds = awayTeamRebounds;
        this.awayFlagrantFouls = awayFlagrantFouls;
        this.awayPlayerTechFouls = awayPlayerTechFouls;
        this.awayTeamTechFouls = awayTeamTechFouls;
        this.awayCoachTechFouls = awayCoachTechFouls;
    }

    /**
     * @return the gameTitle
     */
    public String getGameTitle() {
        return gameTitle;
    }

    /**
     * @param gameTitle the gametitle to set
     */
    public void setGametitle(String gameTitle) {
        this.gameTitle = gameTitle;
    }

    /**
     * @return the gameStatus
     */
    public String getGameStatus() {
        return gameStatus;
    }

    /**
     * @param gameStatus the gameStatus to set
     */
    public void setGameStatus(String gameStatus) {
        this.gameStatus = gameStatus;
    }

    /**
     * @return the gameScheduled
     */
    public String getGameScheduled() {
        return gameScheduled;
    }

    /**
     * @param gameScheduled the gameScheduled to set
     */
    public void setGameScheduled(String gameScheduled) {
        this.gameScheduled = gameScheduled;
    }

    /**
     * @return the gameAttendance
     */
    public String getGameAttendance() {
        return gameAttendance;
    }

    /**
     * @param gameAttendance the gameAttendance to set
     */
    public void setGameAttendance(String gameAttendance) {
        this.gameAttendance = gameAttendance;
    }

    /**
     * @return the gameClock
     */
    public String getGameClock() {
        return gameClock;
    }

    /**
     * @param gameClock the gameClock to set
     */
    public void setGameClock(String gameClock) {
        this.gameClock = gameClock;
    }

    /**
     * @return the gameQuarter
     */
    public String getGameQuarter() {
        return gameQuarter;
    }

    /**
     * @param gameQuarter the gameQuarter to set
     */
    public void setGameQuarter(String gameQuarter) {
        this.gameQuarter = gameQuarter;
    }

    /**
     * @return the homeTeamName
     */
    public String getHomeTeamName() {
        return homeTeamName;
    }

    /**
     * @param homeTeamName the homeTeamName to set
     */
    public void setHomeTeamName(String homeTeamName) {
        this.homeTeamName = homeTeamName;
    }

    /**
     * @return the homeTeamID
     */
    public String getHomeTeamID() {
        return homeTeamID;
    }

    /**
     * @param homeTeamID the homeTeamID to set
     */
    public void setHomeTeamID(String homeTeamID) {
        this.homeTeamID = homeTeamID;
    }

    /**
     * @return the homeQuarterOnePoints
     */
    public int getHomeQuarterOnePoints() {
        return homeQuarterOnePoints;
    }

    /**
     * @param homeQuarterOnePoints the homeQuarterOnePoints to set
     */
    public void setHomeQuarterOnePoints(int homeQuarterOnePoints) {
        this.homeQuarterOnePoints = homeQuarterOnePoints;
    }

    /**
     * @return the homeQuarterTwoPoints
     */
    public int getHomeQuarterTwoPoints() {
        return homeQuarterTwoPoints;
    }

    /**
     * @param homeQuarterTwoPoints the homeQuarterTwoPoints to set
     */
    public void setHomeQuarterTwoPoints(int homeQuarterTwoPoints) {
        this.homeQuarterTwoPoints = homeQuarterTwoPoints;
    }

    /**
     * @return the homeQuarterThreePoints
     */
    public int getHomeQuarterThreePoints() {
        return homeQuarterThreePoints;
    }

    /**
     * @param homeQuarterThreePoints the homeQuarterThreePoints to set
     */
    public void setHomeQuarterThreePoints(int homeQuarterThreePoints) {
        this.homeQuarterThreePoints = homeQuarterThreePoints;
    }

    /**
     * @return the homeQuarterFourPoints
     */
    public int getHomeQuarterFourPoints() {
        return homeQuarterFourPoints;
    }

    /**
     * @param homeQuarterFourPoints the homeQuarterFourPoints to set
     */
    public void setHomeQuarterFourPoints(int homeQuarterFourPoints) {
        this.homeQuarterFourPoints = homeQuarterFourPoints;
    }

    /**
     * @return the homeMinutes
     */
    public String getHomeMinutes() {
        return homeMinutes;
    }

    /**
     * @param homeMinutes the homeMinutes to set
     */
    public void setHomeMinutes(String homeMinutes) {
        this.homeMinutes = homeMinutes;
    }

    /**
     * @return the homeFieldGoalsMade
     */
    public int getHomeFieldGoalsMade() {
        return homeFieldGoalsMade;
    }

    /**
     * @param homeFieldGoalsMade the homeFieldGoalsMade to set
     */
    public void setHomeFieldGoalsMade(int homeFieldGoalsMade) {
        this.homeFieldGoalsMade = homeFieldGoalsMade;
    }

    /**
     * @return the homeFieldGoalsAtt
     */
    public int getHomeFieldGoalsAtt() {
        return homeFieldGoalsAtt;
    }

    /**
     * @param homeFieldGoalsAtt the homeFieldGoalsAtt to set
     */
    public void setHomeFieldGoalsAtt(int homeFieldGoalsAtt) {
        this.homeFieldGoalsAtt = homeFieldGoalsAtt;
    }

    /**
     * @return the homeFieldGoalsPct
     */
    public float getHomeFieldGoalsPct() {
        return homeFieldGoalsPct;
    }

    /**
     * @param homeFieldGoalsPct the homeFieldGoalsPct to set
     */
    public void setHomeFieldGoalsPct(float homeFieldGoalsPct) {
        this.homeFieldGoalsPct = homeFieldGoalsPct;
    }

    /**
     * @return the homeThreePointsMade
     */
    public int getHomeThreePointsMade() {
        return homeThreePointsMade;
    }

    /**
     * @param homeThreePointsMade the homeThreePointsMade to set
     */
    public void setHomeThreePointsMade(int homeThreePointsMade) {
        this.homeThreePointsMade = homeThreePointsMade;
    }

    /**
     * @return the homeThreePointsAtt
     */
    public int getHomeThreePointsAtt() {
        return homeThreePointsAtt;
    }

    /**
     * @param homeThreePointsAtt the homeThreePointsAtt to set
     */
    public void setHomeThreePointsAtt(int homeThreePointsAtt) {
        this.homeThreePointsAtt = homeThreePointsAtt;
    }

    /**
     * @return the homeThreePointsPct
     */
    public float getHomeThreePointsPct() {
        return homeThreePointsPct;
    }

    /**
     * @param homeThreePointsPct the homeThreePointsPct to set
     */
    public void setHomeThreePointsPct(float homeThreePointsPct) {
        this.homeThreePointsPct = homeThreePointsPct;
    }

    /**
     * @return the homeTwoPointsMade
     */
    public int getHomeTwoPointsMade() {
        return homeTwoPointsMade;
    }

    /**
     * @param homeTwoPointsMade the homeTwoPointsMade to set
     */
    public void setHomeTwoPointsMade(int homeTwoPointsMade) {
        this.homeTwoPointsMade = homeTwoPointsMade;
    }

    /**
     * @return the homeTwoPointsAtt
     */
    public int getHomeTwoPointsAtt() {
        return homeTwoPointsAtt;
    }

    /**
     * @param homeTwoPointsAtt the homeTwoPointsAtt to set
     */
    public void setHomeTwoPointsAtt(int homeTwoPointsAtt) {
        this.homeTwoPointsAtt = homeTwoPointsAtt;
    }

    /**
     * @return the homeTwoPointsPct
     */
    public float getHomeTwoPointsPct() {
        return homeTwoPointsPct;
    }

    /**
     * @param homeTwoPointsPct the homeTwoPointsPct to set
     */
    public void setHomeTwoPointsPct(float homeTwoPointsPct) {
        this.homeTwoPointsPct = homeTwoPointsPct;
    }

    /**
     * @return the homeBlockedAtt
     */
    public int getHomeBlockedAtt() {
        return homeBlockedAtt;
    }

    /**
     * @param homeBlockedAtt the homeBlockedAtt to set
     */
    public void setHomeBlockedAtt(int homeBlockedAtt) {
        this.homeBlockedAtt = homeBlockedAtt;
    }

    /**
     * @return the homeFreeThrowsMade
     */
    public int getHomeFreeThrowsMade() {
        return homeFreeThrowsMade;
    }

    /**
     * @param homeFreeThrowsMade the homeFreeThrowsMade to set
     */
    public void setHomeFreeThrowsMade(int homeFreeThrowsMade) {
        this.homeFreeThrowsMade = homeFreeThrowsMade;
    }

    /**
     * @return the homeFreeThrowsAtt
     */
    public int getHomeFreeThrowsAtt() {
        return homeFreeThrowsAtt;
    }

    /**
     * @param homeFreeThrowsAtt the homeFreeThrowsAtt to set
     */
    public void setHomeFreeThrowsAtt(int homeFreeThrowsAtt) {
        this.homeFreeThrowsAtt = homeFreeThrowsAtt;
    }

    /**
     * @return the homeFreeThrowsPct
     */
    public float getHomeFreeThrowsPct() {
        return homeFreeThrowsPct;
    }

    /**
     * @param homeFreeThrowsPct the homeFreeThrowsPct to set
     */
    public void setHomeFreeThrowsPct(float homeFreeThrowsPct) {
        this.homeFreeThrowsPct = homeFreeThrowsPct;
    }

    /**
     * @return the homeOffensiveRebounds
     */
    public int getHomeOffensiveRebounds() {
        return homeOffensiveRebounds;
    }

    /**
     * @param homeOffensiveRebounds the homeOffensiveRebounds to set
     */
    public void setHomeOffensiveRebounds(int homeOffensiveRebounds) {
        this.homeOffensiveRebounds = homeOffensiveRebounds;
    }

    /**
     * @return the homeDefensiveRebounds
     */
    public int getHomeDefensiveRebounds() {
        return homeDefensiveRebounds;
    }

    /**
     * @param homeDefensiveRebounds the homeDefensiveRebounds to set
     */
    public void setHomeDefensiveRebounds(int homeDefensiveRebounds) {
        this.homeDefensiveRebounds = homeDefensiveRebounds;
    }

    /**
     * @return the homeRebounds
     */
    public int getHomeRebounds() {
        return homeRebounds;
    }

    /**
     * @param homeRebounds the homeRebounds to set
     */
    public void setHomeRebounds(int homeRebounds) {
        this.homeRebounds = homeRebounds;
    }

    /**
     * @return the homeAssists
     */
    public int getHomeAssists() {
        return homeAssists;
    }

    /**
     * @param homeAssists the homeAssists to set
     */
    public void setHomeAssists(int homeAssists) {
        this.homeAssists = homeAssists;
    }

    /**
     * @return the homeTurnovers
     */
    public int getHomeTurnovers() {
        return homeTurnovers;
    }

    /**
     * @param homeTurnovers the homeTurnovers to set
     */
    public void setHomeTurnovers(int homeTurnovers) {
        this.homeTurnovers = homeTurnovers;
    }

    /**
     * @return the homeSteals
     */
    public int getHomeSteals() {
        return homeSteals;
    }

    /**
     * @param homeSteals the homeSteals to set
     */
    public void setHomeSteals(int homeSteals) {
        this.homeSteals = homeSteals;
    }

    /**
     * @return the homeBlocks
     */
    public int getHomeBlocks() {
        return homeBlocks;
    }

    /**
     * @param homeBlocks the homeBlocks to set
     */
    public void setHomeBlocks(int homeBlocks) {
        this.homeBlocks = homeBlocks;
    }

    /**
     * @return the homeAssistsTurnoverRatio
     */
    public float getHomeAssistsTurnoverRatio() {
        return homeAssistsTurnoverRatio;
    }

    /**
     * @param homeAssistsTurnoverRatio the homeAssistsTurnoverRatio to set
     */
    public void setHomeAssistsTurnoverRatio(float homeAssistsTurnoverRatio) {
        this.homeAssistsTurnoverRatio = homeAssistsTurnoverRatio;
    }

    /**
     * @return the homePersonalFouls
     */
    public int getHomePersonalFouls() {
        return homePersonalFouls;
    }

    /**
     * @param homePersonalFouls the homePersonalFouls to set
     */
    public void setHomePersonalFouls(int homePersonalFouls) {
        this.homePersonalFouls = homePersonalFouls;
    }

    /**
     * @return the homePoints
     */
    public int getHomePoints() {
        return homePoints;
    }

    /**
     * @param homePoints the homePoints to set
     */
    public void setHomePoints(int homePoints) {
        this.homePoints = homePoints;
    }

    /**
     * @return the homeTeamTurnovers
     */
    public int getHomeTeamTurnovers() {
        return homeTeamTurnovers;
    }

    /**
     * @param homeTeamTurnovers the homeTeamTurnovers to set
     */
    public void setHomeTeamTurnovers(int homeTeamTurnovers) {
        this.homeTeamTurnovers = homeTeamTurnovers;
    }

    /**
     * @return the homeTeamRebounds
     */
    public int getHomeTeamRebounds() {
        return homeTeamRebounds;
    }

    /**
     * @param homeTeamRebounds the homeTeamRebounds to set
     */
    public void setHomeTeamRebounds(int homeTeamRebounds) {
        this.homeTeamRebounds = homeTeamRebounds;
    }

    /**
     * @return the homeFlagrantFouls
     */
    public int getHomeFlagrantFouls() {
        return homeFlagrantFouls;
    }

    /**
     * @param homeFlagrantFouls the homeFlagrantFouls to set
     */
    public void setHomeFlagrantFouls(int homeFlagrantFouls) {
        this.homeFlagrantFouls = homeFlagrantFouls;
    }

    /**
     * @return the homePlayerTechFouls
     */
    public int getHomePlayerTechFouls() {
        return homePlayerTechFouls;
    }

    /**
     * @param homePlayerTechFouls the homePlayerTechFouls to set
     */
    public void setHomePlayerTechFouls(int homePlayerTechFouls) {
        this.homePlayerTechFouls = homePlayerTechFouls;
    }

    /**
     * @return the homeTeamTechFouls
     */
    public int getHomeTeamTechFouls() {
        return homeTeamTechFouls;
    }

    /**
     * @param homeTeamTechFouls the homeTeamTechFouls to set
     */
    public void setHomeTeamTechFouls(int homeTeamTechFouls) {
        this.homeTeamTechFouls = homeTeamTechFouls;
    }

    /**
     * @return the homeCoachTechFouls
     */
    public int getHomeCoachTechFouls() {
        return homeCoachTechFouls;
    }

    /**
     * @param homeCoachTechFouls the homeCoachTechFouls to set
     */
    public void setHomeCoachTechFouls(int homeCoachTechFouls) {
        this.homeCoachTechFouls = homeCoachTechFouls;
    }

    /**
     * @return the awayTeamName
     */
    public String getAwayTeamName() {
        return awayTeamName;
    }

    /**
     * @param awayTeamName the awayTeamName to set
     */
    public void setAwayTeamName(String awayTeamName) {
        this.awayTeamName = awayTeamName;
    }

    /**
     * @return the awayTeamID
     */
    public String getAwayTeamID() {
        return awayTeamID;
    }

    /**
     * @param awayTeamID the awayTeamID to set
     */
    public void setAwayTeamID(String awayTeamID) {
        this.awayTeamID = awayTeamID;
    }

    /**
     * @return the awayQuarterOnePoints
     */
    public int getAwayQuarterOnePoints() {
        return awayQuarterOnePoints;
    }

    /**
     * @param awayQuarterOnePoints the awayQuarterOnePoints to set
     */
    public void setAwayQuarterOnePoints(int awayQuarterOnePoints) {
        this.awayQuarterOnePoints = awayQuarterOnePoints;
    }

    /**
     * @return the awayQuarterTwoPoints
     */
    public int getAwayQuarterTwoPoints() {
        return awayQuarterTwoPoints;
    }

    /**
     * @param awayQuarterTwoPoints the awayQuarterTwoPoints to set
     */
    public void setAwayQuarterTwoPoints(int awayQuarterTwoPoints) {
        this.awayQuarterTwoPoints = awayQuarterTwoPoints;
    }

    /**
     * @return the awayQuarterThreePoints
     */
    public int getAwayQuarterThreePoints() {
        return awayQuarterThreePoints;
    }

    /**
     * @param awayQuarterThreePoints the awayQuarterThreePoints to set
     */
    public void setAwayQuarterThreePoints(int awayQuarterThreePoints) {
        this.awayQuarterThreePoints = awayQuarterThreePoints;
    }

    /**
     * @return the awayQuarterFourPoints
     */
    public int getAwayQuarterFourPoints() {
        return awayQuarterFourPoints;
    }

    /**
     * @param awayQuarterFourPoints the awayQuarterFourPoints to set
     */
    public void setAwayQuarterFourPoints(int awayQuarterFourPoints) {
        this.awayQuarterFourPoints = awayQuarterFourPoints;
    }

    /**
     * @return the awayMinutes
     */
    public String getAwayMinutes() {
        return awayMinutes;
    }

    /**
     * @param awayMinutes the awayMinutes to set
     */
    public void setAwayMinutes(String awayMinutes) {
        this.awayMinutes = awayMinutes;
    }

    /**
     * @return the awayFieldGoalsMade
     */
    public int getAwayFieldGoalsMade() {
        return awayFieldGoalsMade;
    }

    /**
     * @param awayFieldGoalsMade the awayFieldGoalsMade to set
     */
    public void setAwayFieldGoalsMade(int awayFieldGoalsMade) {
        this.awayFieldGoalsMade = awayFieldGoalsMade;
    }

    /**
     * @return the awayFieldGoalsAtt
     */
    public int getAwayFieldGoalsAtt() {
        return awayFieldGoalsAtt;
    }

    /**
     * @param awayFieldGoalsAtt the awayFieldGoalsAtt to set
     */
    public void setAwayFieldGoalsAtt(int awayFieldGoalsAtt) {
        this.awayFieldGoalsAtt = awayFieldGoalsAtt;
    }

    /**
     * @return the awayFieldGoalsPct
     */
    public float getAwayFieldGoalsPct() {
        return awayFieldGoalsPct;
    }

    /**
     * @param awayFieldGoalsPct the awayFieldGoalsPct to set
     */
    public void setAwayFieldGoalsPct(float awayFieldGoalsPct) {
        this.awayFieldGoalsPct = awayFieldGoalsPct;
    }

    /**
     * @return the awayThreePointsMade
     */
    public int getAwayThreePointsMade() {
        return awayThreePointsMade;
    }

    /**
     * @param awayThreePointsMade the awayThreePointsMade to set
     */
    public void setAwayThreePointsMade(int awayThreePointsMade) {
        this.awayThreePointsMade = awayThreePointsMade;
    }

    /**
     * @return the awayThreePointsAtt
     */
    public int getAwayThreePointsAtt() {
        return awayThreePointsAtt;
    }

    /**
     * @param awayThreePointsAtt the awayThreePointsAtt to set
     */
    public void setAwayThreePointsAtt(int awayThreePointsAtt) {
        this.awayThreePointsAtt = awayThreePointsAtt;
    }

    /**
     * @return the awayThreePointsPct
     */
    public float getAwayThreePointsPct() {
        return awayThreePointsPct;
    }

    /**
     * @param awayThreePointsPct the awayThreePointsPct to set
     */
    public void setAwayThreePointsPct(float awayThreePointsPct) {
        this.awayThreePointsPct = awayThreePointsPct;
    }

    /**
     * @return the awayTwoPointsMade
     */
    public int getAwayTwoPointsMade() {
        return awayTwoPointsMade;
    }

    /**
     * @param awayTwoPointsMade the awayTwoPointsMade to set
     */
    public void setAwayTwoPointsMade(int awayTwoPointsMade) {
        this.awayTwoPointsMade = awayTwoPointsMade;
    }

    /**
     * @return the awayTwoPointsAtt
     */
    public int getAwayTwoPointsAtt() {
        return awayTwoPointsAtt;
    }

    /**
     * @param awayTwoPointsAtt the awayTwoPointsAtt to set
     */
    public void setAwayTwoPointsAtt(int awayTwoPointsAtt) {
        this.awayTwoPointsAtt = awayTwoPointsAtt;
    }

    /**
     * @return the awayTwoPointsPct
     */
    public float getAwayTwoPointsPct() {
        return awayTwoPointsPct;
    }

    /**
     * @param awayTwoPointsPct the awayTwoPointsPct to set
     */
    public void setAwayTwoPointsPct(float awayTwoPointsPct) {
        this.awayTwoPointsPct = awayTwoPointsPct;
    }

    /**
     * @return the awayBlockedAtt
     */
    public int getAwayBlockedAtt() {
        return awayBlockedAtt;
    }

    /**
     * @param awayBlockedAtt the awayBlockedAtt to set
     */
    public void setAwayBlockedAtt(int awayBlockedAtt) {
        this.awayBlockedAtt = awayBlockedAtt;
    }

    /**
     * @return the awayFreeThrowsMade
     */
    public int getAwayFreeThrowsMade() {
        return awayFreeThrowsMade;
    }

    /**
     * @param awayFreeThrowsMade the awayFreeThrowsMade to set
     */
    public void setAwayFreeThrowsMade(int awayFreeThrowsMade) {
        this.awayFreeThrowsMade = awayFreeThrowsMade;
    }

    /**
     * @return the awayFreeThrowsAtt
     */
    public int getAwayFreeThrowsAtt() {
        return awayFreeThrowsAtt;
    }

    /**
     * @param awayFreeThrowsAtt the awayFreeThrowsAtt to set
     */
    public void setAwayFreeThrowsAtt(int awayFreeThrowsAtt) {
        this.awayFreeThrowsAtt = awayFreeThrowsAtt;
    }

    /**
     * @return the awayFreeThrowsPct
     */
    public float getAwayFreeThrowsPct() {
        return awayFreeThrowsPct;
    }

    /**
     * @param awayFreeThrowsPct the awayFreeThrowsPct to set
     */
    public void setAwayFreeThrowsPct(float awayFreeThrowsPct) {
        this.awayFreeThrowsPct = awayFreeThrowsPct;
    }

    /**
     * @return the awayOffensiveRebounds
     */
    public int getAwayOffensiveRebounds() {
        return awayOffensiveRebounds;
    }

    /**
     * @param awayOffensiveRebounds the awayOffensiveRebounds to set
     */
    public void setAwayOffensiveRebounds(int awayOffensiveRebounds) {
        this.awayOffensiveRebounds = awayOffensiveRebounds;
    }

    /**
     * @return the awayDefensiveRebounds
     */
    public int getAwayDefensiveRebounds() {
        return awayDefensiveRebounds;
    }

    /**
     * @param awayDefensiveRebounds the awayDefensiveRebounds to set
     */
    public void setAwayDefensiveRebounds(int awayDefensiveRebounds) {
        this.awayDefensiveRebounds = awayDefensiveRebounds;
    }

    /**
     * @return the awayRebounds
     */
    public int getAwayRebounds() {
        return awayRebounds;
    }

    /**
     * @param awayRebounds the awayRebounds to set
     */
    public void setAwayRebounds(int awayRebounds) {
        this.awayRebounds = awayRebounds;
    }

    /**
     * @return the awayAssists
     */
    public int getAwayAssists() {
        return awayAssists;
    }

    /**
     * @param awayAssists the awayAssists to set
     */
    public void setAwayAssists(int awayAssists) {
        this.awayAssists = awayAssists;
    }

    /**
     * @return the awayTurnovers
     */
    public int getAwayTurnovers() {
        return awayTurnovers;
    }

    /**
     * @param awayTurnovers the awayTurnovers to set
     */
    public void setAwayTurnovers(int awayTurnovers) {
        this.awayTurnovers = awayTurnovers;
    }

    /**
     * @return the awaySteals
     */
    public int getAwaySteals() {
        return awaySteals;
    }

    /**
     * @param awaySteals the awaySteals to set
     */
    public void setAwaySteals(int awaySteals) {
        this.awaySteals = awaySteals;
    }

    /**
     * @return the awayBlocks
     */
    public int getAwayBlocks() {
        return awayBlocks;
    }

    /**
     * @param awayBlocks the awayBlocks to set
     */
    public void setAwayBlocks(int awayBlocks) {
        this.awayBlocks = awayBlocks;
    }

    /**
     * @return the awayAssistsTurnoverRatio
     */
    public float getAwayAssistsTurnoverRatio() {
        return awayAssistsTurnoverRatio;
    }

    /**
     * @param awayAssistsTurnoverRatio the awayAssistsTurnoverRatio to set
     */
    public void setAwayAssistsTurnoverRatio(float awayAssistsTurnoverRatio) {
        this.awayAssistsTurnoverRatio = awayAssistsTurnoverRatio;
    }

    /**
     * @return the awayPersonalFouls
     */
    public int getAwayPersonalFouls() {
        return awayPersonalFouls;
    }

    /**
     * @param awayPersonalFouls the awayPersonalFouls to set
     */
    public void setAwayPersonalFouls(int awayPersonalFouls) {
        this.awayPersonalFouls = awayPersonalFouls;
    }

    /**
     * @return the awayPoints
     */
    public int getAwayPoints() {
        return awayPoints;
    }

    /**
     * @param awayPoints the awayPoints to set
     */
    public void setAwayPoints(int awayPoints) {
        this.awayPoints = awayPoints;
    }

    /**
     * @return the awayTeamTurnovers
     */
    public int getAwayTeamTurnovers() {
        return awayTeamTurnovers;
    }

    /**
     * @param awayTeamTurnovers the awayTeamTurnovers to set
     */
    public void setAwayTeamTurnovers(int awayTeamTurnovers) {
        this.awayTeamTurnovers = awayTeamTurnovers;
    }

    /**
     * @return the awayTeamRebounds
     */
    public int getAwayTeamRebounds() {
        return awayTeamRebounds;
    }

    /**
     * @param awayTeamRebounds the awayTeamRebounds to set
     */
    public void setAwayTeamRebounds(int awayTeamRebounds) {
        this.awayTeamRebounds = awayTeamRebounds;
    }

    /**
     * @return the awayFlagrantFouls
     */
    public int getAwayFlagrantFouls() {
        return awayFlagrantFouls;
    }

    /**
     * @param awayFlagrantFouls the awayFlagrantFouls to set
     */
    public void setAwayFlagrantFouls(int awayFlagrantFouls) {
        this.awayFlagrantFouls = awayFlagrantFouls;
    }

    /**
     * @return the awayPlayerTechFouls
     */
    public int getAwayPlayerTechFouls() {
        return awayPlayerTechFouls;
    }

    /**
     * @param awayPlayerTechFouls the awayPlayerTechFouls to set
     */
    public void setAwayPlayerTechFouls(int awayPlayerTechFouls) {
        this.awayPlayerTechFouls = awayPlayerTechFouls;
    }

    /**
     * @return the awayTeamTechFouls
     */
    public int getAwayTeamTechFouls() {
        return awayTeamTechFouls;
    }

    /**
     * @param awayTeamTechFouls the awayTeamTechFouls to set
     */
    public void setAwayTeamTechFouls(int awayTeamTechFouls) {
        this.awayTeamTechFouls = awayTeamTechFouls;
    }

    /**
     * @return the awayCoachTechFouls
     */
    public int getAwayCoachTechFouls() {
        return awayCoachTechFouls;
    }

    /**
     * @param awayCoachTechFouls the awayCoachTechFouls to set
     */
    public void setAwayCoachTechFouls(int awayCoachTechFouls) {
        this.awayCoachTechFouls = awayCoachTechFouls;
    }
  
}


