import 'dart:io';

class User {
  int age;
  int no;
  double user_total;

  User(this.age, this.no, this.user_total);

  int calc_discount(User user){
    int discount = 0;
    if(user.age < 18){
      discount = 10;
    }
    else if(18 <= user.age && user.age <= 60){
      discount = 5;
    }
    else if(60 < user.age){
      discount = 15;
    }
    return discount;
  }
}

class Product {
  String product_name;
  double price;

  Product(this.price, this.product_name);
}

class ShoppingCart {
  List<Product> product_list;
  double cart_total;

  ShoppingCart(this.product_list, this.cart_total);

  bool add_product(ShoppingCart cart, String product_name, double price){
    Product new_product = Product(price, product_name);
    try{
      cart.product_list.add(new_product);
      return true;
    }
    catch(Error){
      print("Failed to add product!: $Error");
      return false;
    }
  }

  double calc_total(ShoppingCart cart, User user){
    var x = 0;
    double temp = 0;
    double total = 0;
    while(x < cart.product_list.length){
      temp = cart.product_list[x].price;
      total = total + temp;
      x++;
    }
    cart.cart_total = total;
    var final_total = (total * (100 - user.calc_discount(user))) / 100;
    user.user_total = final_total;
    return final_total;
  }
}

void main(){
  print("\n⚠ ⚠ ⚠ Please press F11 to enter the fullscreen mode... ⚠ ⚠ ⚠ ");
  ShoppingCart cart = ShoppingCart([], 0);
  User new_user = User(0, 1, 0);

  print("\n\n\n`7MM\"\"\"YMM                  .g8\"\"\"bgd     db      `7MM\"\"\"Mq. MMP\"\"MM\"\"YMM \n"
      "  MM    `7                .dP'     `M    ;MM:       MM   `MM.P'   MM   `7 \n"
      "  MM   d                  dM'       `   ,V^MM.      MM   ,M9      MM      \n"
      "  MMmmMM                  MM           ,M  `MM      MMmmdM9       MM      \n"
      "  MM   Y  ,     mmmmm     MM.          AbmmmqMA     MM  YM.       MM      \n"
      "  MM     ,M               `Mb.     ,' A'     VML    MM   `Mb.     MM      \n"
      ".JMMmmmmMMM                 `\"bmmmd'.AMA.   .AMMA..JMML. .JMM.  .JMML.    \n\n\n");

  print("Please enter your age:");
  String? age_input = stdin.readLineSync();
  int age = int.parse(age_input!);
  new_user.age = age;
  print("Congratulations, you have won a %${new_user.calc_discount(new_user)} discount.");

  var choice;
  while(true){
    print("\n\n\nHi, welcome to e-cart app. Please make a choice...");

    print(" ______________________________________________\n"
          "/                                              \\\n"
          "| Add prdouct with custom name and price. -> a |\n"
          "|______________________________________________|\n"
          "|                                              |\n"
          "| Exit the program. -> q                       |\n"
          "\\______________________________________________/\n");

    choice = stdin.readLineSync();

    if(choice == "a"){
      print("Please write the product name: ");
      String? name_input = stdin.readLineSync();

      print("Please write the product price: ");
      String? price_input = stdin.readLineSync();
      double price = double.parse(price_input!);

      if(name_input != null && name_input.isNotEmpty){
        String name = name_input;
        cart.add_product(cart, name, price);
      }
      else{
        print("Incorrect entry.");
      }

      print("\n\n\nCart total: ${cart.calc_total(cart, new_user)}\n");

      var y = 0;
      print("Product List:");
      while(y < cart.product_list.length){
        print("${y+1}\. Product Name: ${cart.product_list[y].product_name}, Price: ${cart.product_list[y].price}");
        y++;
      }
    }
    else if(choice == "q"){
      exit(1);
    }
    else{
      print("Incorrect choice, please try again.");
    }
  }
}