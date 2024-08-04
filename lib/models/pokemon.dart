class PokemonListData {
  int? count;
  String? next;
  String? previous;
  List<PokemonListResult>? results;

  PokemonListData({this.count, this.next, this.previous, this.results});

  PokemonListData.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <PokemonListResult>[];
      json['results'].forEach((v) {
        results!.add(PokemonListResult.fromJson(v));
      });
    }
  }

  PokemonListData copyWith({
    int? count,
    String? next,
    String? previous,
    List<PokemonListResult>? results,
  }) {
    return PokemonListData(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }
}

class PokemonListResult {
  String? name;
  String? url;

  PokemonListResult({this.name, this.url});

  PokemonListResult.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }
}

class Pokemon {
  List<Abilities>? abilities;
  int? height;
  int? id;
  List<Moves>? moves;
  String? name;
  Ability? species;
  Sprites? sprites;
  List<Stats>? stats;
  int? weight;

  Pokemon(
      {this.abilities,
        this.height,
        this.id,
        this.moves,
        this.name,
        this.species,
        this.sprites,
        this.stats,
        this.weight});

  Pokemon.fromJson(Map<String, dynamic> json) {
    if (json['abilities'] != null) {
      abilities = <Abilities>[];
      json['abilities'].forEach((v) {
        abilities!.add(Abilities.fromJson(v));
      });
    }
    height = json['height'];
    id = json['id'];
    if (json['moves'] != null) {
      moves = <Moves>[];
      json['moves'].forEach((v) {
        moves!.add(Moves.fromJson(v));
      });
    }
    name = json['name'];
    species =
    json['species'] != null ? Ability.fromJson(json['species']) : null;
    sprites =
    json['sprites'] != null ? Sprites.fromJson(json['sprites']) : null;
    if (json['stats'] != null) {
      stats = <Stats>[];
      json['stats'].forEach((v) {
        stats!.add(Stats.fromJson(v));
      });
    }
    weight = json['weight'];
  }
}

class Abilities {
  Ability? ability;
  bool? isHidden;
  int? slot;

  Abilities({this.ability, this.isHidden, this.slot});

  Abilities.fromJson(Map<String, dynamic> json) {
    ability =
    json['ability'] != null ? Ability.fromJson(json['ability']) : null;
    isHidden = json['is_hidden'];
    slot = json['slot'];
  }
}

class Moves {
  Ability? move;

  Moves({this.move});

  Moves.fromJson(Map<String, dynamic> json) {
    move = json['move'] != null ? Ability.fromJson(json['move']) : null;
  }
}

class Ability {
  String? name;
  String? url;

  Ability({this.name, this.url});

  Ability.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }
}

class Sprites {
  String? backDefault;
  String? backFemale;
  String? backShiny;
  String? backShinyFemale;
  String? frontDefault;
  String? frontFemale;
  String? frontShiny;
  String? frontShinyFemale;

  Sprites({
    this.backDefault,
    this.backFemale,
    this.backShiny,
    this.backShinyFemale,
    this.frontDefault,
    this.frontFemale,
    this.frontShiny,
    this.frontShinyFemale,
  });

  Sprites.fromJson(Map<String, dynamic> json) {
    backDefault = json['back_default'];
    backFemale = json['back_female'];
    backShiny = json['back_shiny'];
    backShinyFemale = json['back_shiny_female'];
    frontDefault = json['front_default'];
    frontFemale = json['front_female'];
    frontShiny = json['front_shiny'];
    frontShinyFemale = json['front_shiny_female'];
  }
}

class Stats {
  int? baseStat;
  int? effort;
  Ability? stat;

  Stats({this.baseStat, this.effort, this.stat});

  Stats.fromJson(Map<String, dynamic> json) {
    baseStat = json['base_stat'];
    effort = json['effort'];
    stat = json['stat'] != null ? Ability.fromJson(json['stat']) : null;
  }
}