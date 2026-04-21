class QuantityRequestModel{
   int quantity;

  QuantityRequestModel({required this.quantity});

  Map<String,dynamic>toJson(){
    return{
      "quantity": quantity
    };
  }

}