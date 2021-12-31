class ShowData
{
  static const String PassionCooking = 'cooking';
  static const String PassionHiking = 'hiking';
  static const String PassionTraveling = 'traveling';

  String project = '';
  String ticketTitle = '';
  String type = '';
  String category = '';
  String priority = '';
  String dueDate = '';
  String targetDate = '';
  String resolutionDate = '';
  String togs = '';
  String details = '';
  String owner = '';
  String assignTO = '';
  Map<String, bool> passions = {
    PassionCooking: false,
    PassionHiking: false,
    PassionTraveling: false,
  };

  ShowData(this.project, this.ticketTitle, this.type, this.category, this.priority, this.dueDate, this.targetDate,
      this.resolutionDate, this.togs, this.details, this.owner, this.assignTO, this.passions);
}