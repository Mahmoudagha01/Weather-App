 String greeting(){
    var hour  = DateTime.now().hour;
    print(hour);
    if(hour < 12){
      return "Morning";
    }else if(hour < 17){
      return "Afternoon";
    }else{
      return "Evening";
    }
  }
