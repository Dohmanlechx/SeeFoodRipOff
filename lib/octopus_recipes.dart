import 'package:flutter/material.dart';

class OctopusRecipes extends StatelessWidget {
  const OctopusRecipes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Octopus Recipes"),
      ),
      body: ListView(
        children: const [
          OctopusRecipe(
            title: "Grilled Octopus with Sausage",
            body:"Cut the octopus into bite-size chunks and spicy chorizo sausage in proportion. Then, alternating between octopus and chorizo, thread them on bamboo or metal skewers. Add onions, peppers, or cherry tomatoes in between, if you like. Brush lightly with olive oil, then grill. Because both octopus and chorizo are fully cooked it will not take long to finish them on a hot grill.",
          ),
          OctopusRecipe(
            title: "Octopus On Salad",
            body: "Our fully cooked octopus is a great addition to almost any type of salad, whether leafy greens, chopped tomato and onion, or citrus. Serve it cold or sear briefly to heat through and give a pleasant caramelization to the surface. Octopus appears in salads in many cuisines, so you can adapt to your liking. Try it with hijiki seaweed and cucumbers, add to a citrus salad with fennel, top a warm potato salad with chopped octopus, or marinate with avocado, peppers, olive oil, and lemon juice.",
          ),
          OctopusRecipe(
            title: "Pasta Perfection with Octopus",
            body: "Any pasta will do - sturdy strozzapreti, linguine, fusilli - as octopus will work nicely in a variety of Mediterranean dishes. Fold chopped octopus into an herb-infused tomato sauce and warm together with cooked pasta to make a classic frutti di mare, or serve alongside pasta dressed simply with lemon, high-quality olive oil (try Green Fruity Jean Reno Reserve) and a garnish of fresh parsley.",
          ),
          OctopusRecipe(
            title: "Easy Marinated Octopus",
            body: "The simplest way to enjoy our fully cooked octopus is to briefly marinate the pieces in olive oil, lemon, a little garlic, rosemary, thyme, or the fresh herbs of your choice. After just 30 minutes the octopus will take on the flavor and can be served as is with olives, feta cheese, sliced onions, or on a bed of greens.",
          ),
          OctopusRecipe(
            title: "Simple Seared Octopus",
            body: "Heating the octopus before serving gives it a flavorful finish. Cut into bite-sized pieces, or leave whole if you prefer, then sear briefly on each side. Use duck fat, olive oil, butter, or the fat of your choice. Remove from the pan and sprinkle with salt, pepper, smoked paprika, or piment d’Espelette.",
          ),
          OctopusRecipe(
            title: "Octopus Tapas",
            body: "It’s simple to make tapas as they do in the northwestern region of Spain. Pulpo Gallego is a famous dish from Galicia, in which tender slices of octopus are served on cooked potato wedges, topped with olive oil, salt, and a dusting of Spanish smoked paprika. Allow the octopus to come to room temperature before placing on the potatoes, and serve on a wooden plate for an authentic, traditional touch.",
          ),
          OctopusRecipe(
            title: "Octopus Ceviche",
            body: "Ceviche is a South American classic - raw seafood that is “cooked” by marinating in sharp citrus juice. Our cooked octopus can be sliced thinly, then placed with sliced red onions in a bowl, then marinated with freshly squeezed lime juice, chile peppers (to taste), chopped cilantro, olive oil, salt, and pepper. After a few hours in the refrigerator, the ceviche is ready to serve. Add in our gulf white shrimp and jumbo dry sea scallops for an appetizer worthy of a special occasion.",
          ),
          OctopusRecipe(
            title: "Portuguese-style Octopus with Potatoes",
            body: "This is a traditional way to prepare octopus in Portugal, where it is often served on Christmas Eve. Roast salted potatoes - in slices, or halved if they are small - for about 30 minutes, then add octopus tentacles cut into good-sized chunks, drizzle with quality olive oil, add cloves of garlic and some bay leaves, sprinkle with white pepper, and then bake until the octopus is warmed through and browned.",
          ),
          OctopusRecipe(
            title: "Seafood Pizza",
            body: "Octopus is a good addition to a seafood pizza, along with classics like anchovies and shrimp. Make your own dough, or use store-bought for convenience, and slather on a thick tomato sauce, then evenly spread sliced or chopped octopus, shrimp, and any other seafood you like. Add onions, oregano, and basil, but no mozzarella on this one. Fire it up in a hot oven.",
          ),
          OctopusRecipe(
            title: "Stir-Fried Octopus",
            body: "Use octopus as the protein in a vegetable stir-fry - with peppers, onions, asparagus, or green beans. When sauteed with ginger, soy, garlic, or gochujang chili paste, octopus takes on a whole new flavor. Serve with rice and sprinkle sesame seeds on top.",
          ),
        ],
      ),
    );
  }
}

class OctopusRecipe extends StatelessWidget {
  final String title;
  final String body;

  const OctopusRecipe({
    required this.title,
    required this.body,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Card(
        child: Column(
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(body)
          ],
        ),
      ),
    );
  }
}
