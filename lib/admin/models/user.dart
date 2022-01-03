class UserData {

  String formDate = '';
  String toDate = '';

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
