class Recipe{
  num id = 0;
  String name = "";
  String image = "https://cdn.shopify.com/s/files/1/0533/2089/files/placeholder-images-image_large.png?format=jpg&quality=90&v=1530129081";

  Recipe({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Recipe.fromJson(Map<String, dynamic> json){
    return Recipe(
      id: json['id'],
      name: json['name'],
      image: json['imagePath'],
    );
  }
}