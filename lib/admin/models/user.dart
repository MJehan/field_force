class UserData {

  String formDate = '';
  String toDate = '';
  String name = '';

  save() {
   if(formDate == null || toDate == null)
    {
     print('Not Save');
    }
    else {
      print('save');
    }
  }
}
