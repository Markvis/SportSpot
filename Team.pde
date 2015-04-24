public class Team {

  private int gamesPlayed;
  private int minutes;
  private int fieldGoalsMade;
  private int fieldGoalsAtt;
  private int threePointsMade;
  private int threePointsAtt;
  private int blockedAtt;
  private int freeThrowsMade;
  private int freeThrowsAtt;
  private int offensiveRebounds;
  private int defensiveRebounds;
  private int assists;
  private int turnovers;
  private int steals;
  private int blocks;
  private int personalFouls;
  private int techFouls;
  private int points;
  private int fastBreakPoints;
  private int paintPts;
  private int flagrantFouls;
  private int pointsOffTurnovers;
  private int secondChancePoints;
  private float freeThrowsPct;
  private float twoPointsPct;
  private float threePointsPct;
  private float fieldGoalsPct;
  private int Rebounds;
  private float assistsTurnoverRatio;
  private int twoPointsMade;
  private int twoPointsAtt;

  public Team() {
    gamesPlayed = 0;
    minutes = 0;
    fieldGoalsMade = 0;
    fieldGoalsAtt = 0;
    threePointsMade = 0;
    threePointsAtt = 0;
    blockedAtt = 0;
    freeThrowsMade = 0;
    freeThrowsAtt = 0;
    offensiveRebounds = 0;
    defensiveRebounds = 0;
    assists = 0;
    turnovers = 0;
    steals = 0;
    blocks = 0;
    personalFouls = 0;
    techFouls = 0;
    points = 0;
    fastBreakPoints = 0;
    paintPts = 0;
    flagrantFouls = 0;
    pointsOffTurnovers = 0;
    secondChancePoints = 0;
    freeThrowsPct = 0;
    twoPointsPct = 0;
    threePointsPct = 0;
    fieldGoalsPct = 0;
    Rebounds = 0;
    assistsTurnoverRatio = 0;
    twoPointsMade = 0;
    twoPointsAtt = 0;
  }

  /**
   * @return the gamesPlayed
   */
  public int getGamesPlayed() {
    return gamesPlayed;
  }

  /**
   * @param gamesPlayed the gamesPlayed to set
   */
  public void setGamesPlayed(int gamesPlayed) {
    this.gamesPlayed = gamesPlayed;
  }

  /**
   * @return the minutes
   */
  public int getMinutes() {
    return minutes;
  }

  /**
   * @param minutes the minutes to set
   */
  public void setMinutes(int minutes) {
    this.minutes = minutes;
  }

  /**
   * @return the fieldGoalsMade
   */
  public int getFieldGoalsMade() {
    return fieldGoalsMade;
  }

  /**
   * @param fieldGoalsMade the fieldGoalsMade to set
   */
  public void setFieldGoalsMade(int fieldGoalsMade) {
    this.fieldGoalsMade = fieldGoalsMade;
  }

  /**
   * @return the fieldGoalsAtt
   */
  public int getFieldGoalsAtt() {
    return fieldGoalsAtt;
  }

  /**
   * @param fieldGoalsAtt the fieldGoalsAtt to set
   */
  public void setFieldGoalsAtt(int fieldGoalsAtt) {
    this.fieldGoalsAtt = fieldGoalsAtt;
  }

  /**
   * @return the threePointsMade
   */
  public int getThreePointsMade() {
    return threePointsMade;
  }

  /**
   * @param threePointsMade the threePointsMade to set
   */
  public void setThreePointsMade(int threePointsMade) {
    this.threePointsMade = threePointsMade;
  }

  /**
   * @return the threePointsAtt
   */
  public int getThreePointsAtt() {
    return threePointsAtt;
  }

  /**
   * @param threePointsAtt the threePointsAtt to set
   */
  public void setThreePointsAtt(int threePointsAtt) {
    this.threePointsAtt = threePointsAtt;
  }

  /**
   * @return the blockedAtt
   */
  public int getBlockedAtt() {
    return blockedAtt;
  }

  /**
   * @param blockedAtt the blockedAtt to set
   */
  public void setBlockedAtt(int blockedAtt) {
    this.blockedAtt = blockedAtt;
  }

  /**
   * @return the freeThrowsMade
   */
  public int getFreeThrowsMade() {
    return freeThrowsMade;
  }

  /**
   * @param freeThrowsMade the freeThrowsMade to set
   */
  public void setFreeThrowsMade(int freeThrowsMade) {
    this.freeThrowsMade = freeThrowsMade;
  }

  /**
   * @return the freeThrowsAtt
   */
  public int getFreeThrowsAtt() {
    return freeThrowsAtt;
  }

  /**
   * @param freeThrowsAtt the freeThrowsAtt to set
   */
  public void setFreeThrowsAtt(int freeThrowsAtt) {
    this.freeThrowsAtt = freeThrowsAtt;
  }

  /**
   * @return the offensiveRebounds
   */
  public int getOffensiveRebounds() {
    return offensiveRebounds;
  }

  /**
   * @param offensiveRebounds the offensiveRebounds to set
   */
  public void setOffensiveRebounds(int offensiveRebounds) {
    this.offensiveRebounds = offensiveRebounds;
  }

  /**
   * @return the defensiveRebounds
   */
  public int getDefensiveRebounds() {
    return defensiveRebounds;
  }

  /**
   * @param defensiveRebounds the defensiveRebounds to set
   */
  public void setDefensiveRebounds(int defensiveRebounds) {
    this.defensiveRebounds = defensiveRebounds;
  }

  /**
   * @return the assists
   */
  public int getAssists() {
    return assists;
  }

  /**
   * @param assists the assists to set
   */
  public void setAssists(int assists) {
    this.assists = assists;
  }

  /**
   * @return the turnovers
   */
  public int getTurnovers() {
    return turnovers;
  }

  /**
   * @param turnovers the turnovers to set
   */
  public void setTurnovers(int turnovers) {
    this.turnovers = turnovers;
  }

  /**
   * @return the steals
   */
  public int getSteals() {
    return steals;
  }

  /**
   * @param steals the steals to set
   */
  public void setSteals(int steals) {
    this.steals = steals;
  }

  /**
   * @return the blocks
   */
  public int getBlocks() {
    return blocks;
  }

  /**
   * @param blocks the blocks to set
   */
  public void setBlocks(int blocks) {
    this.blocks = blocks;
  }

  /**
   * @return the personalFouls
   */
  public int getPersonalFouls() {
    return personalFouls;
  }

  /**
   * @param personalFouls the personalFouls to set
   */
  public void setPersonalFouls(int personalFouls) {
    this.personalFouls = personalFouls;
  }

  /**
   * @return the techFouls
   */
  public int getTechFouls() {
    return techFouls;
  }

  /**
   * @param techFouls the techFouls to set
   */
  public void setTechFouls(int techFouls) {
    this.techFouls = techFouls;
  }

  /**
   * @return the points
   */
  public int getPoints() {
    return points;
  }

  /**
   * @param points the points to set
   */
  public void setPoints(int points) {
    this.points = points;
  }

  /**
   * @return the fastBreakPoints
   */
  public int getFastBreakPoints() {
    return fastBreakPoints;
  }

  /**
   * @param fastBreakPoints the fastBreakPoints to set
   */
  public void setFastBreakPoints(int fastBreakPoints) {
    this.fastBreakPoints = fastBreakPoints;
  }

  /**
   * @return the paintPts
   */
  public int getPaintPts() {
    return paintPts;
  }

  /**
   * @param paintPts the paintPts to set
   */
  public void setPaintPts(int paintPts) {
    this.paintPts = paintPts;
  }

  /**
   * @return the flagrantFouls
   */
  public int getFlagrantFouls() {
    return flagrantFouls;
  }

  /**
   * @param flagrantFouls the flagrantFouls to set
   */
  public void setFlagrantFouls(int flagrantFouls) {
    this.flagrantFouls = flagrantFouls;
  }

  /**
   * @return the pointsOffTurnovers
   */
  public int getPointsOffTurnovers() {
    return pointsOffTurnovers;
  }

  /**
   * @param pointsOffTurnovers the pointsOffTurnovers to set
   */
  public void setPointsOffTurnovers(int pointsOffTurnovers) {
    this.pointsOffTurnovers = pointsOffTurnovers;
  }

  /**
   * @return the secondChancePoints
   */
  public int getSecondChancePoints() {
    return secondChancePoints;
  }

  /**
   * @param secondChancePoints the secondChancePoints to set
   */
  public void setSecondChancePoints(int secondChancePoints) {
    this.secondChancePoints = secondChancePoints;
  }

  /**
   * @return the freeThrowsPct
   */
  public float getFreeThrowsPct() {
    return freeThrowsPct;
  }

  /**
   * @param freeThrowsPct the freeThrowsPct to set
   */
  public void setFreeThrowsPct(float freeThrowsPct) {
    this.freeThrowsPct = freeThrowsPct;
  }

  /**
   * @return the twoPointsPct
   */
  public float getTwoPointsPct() {
    return twoPointsPct;
  }

  /**
   * @param twoPointsPct the twoPointsPct to set
   */
  public void setTwoPointsPct(float twoPointsPct) {
    this.twoPointsPct = twoPointsPct;
  }

  /**
   * @return the threePointsPct
   */
  public float getThreePointsPct() {
    return threePointsPct;
  }

  /**
   * @param threePointsPct the threePointsPct to set
   */
  public void setThreePointsPct(float threePointsPct) {
    this.threePointsPct = threePointsPct;
  }

  /**
   * @return the fieldGoalsPct
   */
  public float getFieldGoalsPct() {
    return fieldGoalsPct;
  }

  /**
   * @param fieldGoalsPct the fieldGoalsPct to set
   */
  public void setFieldGoalsPct(float fieldGoalsPct) {
    this.fieldGoalsPct = fieldGoalsPct;
  }

  /**
   * @return the Rebounds
   */
  public int getRebounds() {
    return Rebounds;
  }

  /**
   * @param Rebounds the Rebounds to set
   */
  public void setRebounds(int Rebounds) {
    this.Rebounds = Rebounds;
  }

  /**
   * @return the assistsTurnoverRatio
   */
  public float getAssistsTurnoverRatio() {
    return assistsTurnoverRatio;
  }

  /**
   * @param assistsTurnoverRatio the assistsTurnoverRatio to set
   */
  public void setAssistsTurnoverRatio(float assistsTurnoverRatio) {
    this.assistsTurnoverRatio = assistsTurnoverRatio;
  }

  /**
   * @return the twoPointsMade
   */
  public int getTwoPointsMade() {
    return twoPointsMade;
  }

  /**
   * @param twoPointsMade the twoPointsMade to set
   */
  public void setTwoPointsMade(int twoPointsMade) {
    this.twoPointsMade = twoPointsMade;
  }

  /**
   * @return the twoPointsAtt
   */
  public int getTwoPointsAtt() {
    return twoPointsAtt;
  }

  /**
   * @param twoPointsAtt the twoPointsAtt to set
   */
  public void setTwoPointsAtt(int twoPointsAtt) {
    this.twoPointsAtt = twoPointsAtt;
  }
}