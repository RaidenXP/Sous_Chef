class Recipe{
  String name = "";
  String image = "https://cdn.shopify.com/s/files/1/0533/2089/files/placeholder-images-image_large.png?format=jpg&quality=90&v=1530129081";

  Recipe({
    required this.name,
  });

  factory Recipe.fromJson(Map<String, dynamic> json){
    return Recipe(
      name: json['name'],
    );
  }
}