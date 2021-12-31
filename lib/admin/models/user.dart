class UserData {
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
    PassionTraveling: false
  };
  bool newsletter = false;

  save() {
   if(project == null)
    {
     print('Not Save');
    }
    else {
      print('save');
    }
  }
}
