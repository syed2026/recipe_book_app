import 'package:flutter/material.dart';
import 'recipe.dart';

void main() {
  runApp(RecipeApp());
}

class RecipeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Book',
      theme: ThemeData(primarySwatch: Colors.green),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Recipe> recipes = [
    Recipe(
      name: "Spaghetti Bolognese",
      ingredients: "Pasta, Beef, Tomato Sauce",
      instructions: "1. Boil pasta\n2. Cook beef\n3. Mix with sauce.",
    ),
    Recipe(
      name: "Chicken Curry",
      ingredients: "Chicken, Curry Powder, Coconut Milk",
      instructions: "1. Cook chicken\n2. Add curry powder\n3. Simmer with coconut milk.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Recipe Book")),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(recipes[index].name),
            trailing: IconButton(
              icon: Icon(
                recipes[index].isFavorite ? Icons.favorite : Icons.favorite_border,
                color: recipes[index].isFavorite ? Colors.red : null,
              ),
              onPressed: () {
                setState(() {
                  recipes[index].isFavorite = !recipes[index].isFavorite;
                });
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(recipe: recipes[index]),
                ),
              ).then((_) => setState(() {})); // Refresh favorites
            },
          );
        },
      ),
    );
  }
}

class DetailsScreen extends StatefulWidget {
  final Recipe recipe;

  DetailsScreen({required this.recipe});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.recipe.name)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Ingredients:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text(widget.recipe.ingredients),
            SizedBox(height: 10),
            Text("Instructions:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text(widget.recipe.instructions),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.recipe.isFavorite = !widget.recipe.isFavorite;
                });
              },
              child: Text(widget.recipe.isFavorite ? "Unfavorite" : "Favorite"),
            ),
          ],
        ),
      ),
    );
  }
}
