// M2A2 Kilig: Compatibility Checker. Replace each placeholder body.
// Read README.md for the rules. The tests call these functions directly.
import 'dart:io';

int sharedInterests(List<String> a, List<String> b) {
  final setB = b.map((s) => s.trim().toLowerCase()).toSet();
  return a
      .map((s) => s.trim().toLowerCase())
      .toSet()
      .where((s) => s.isNotEmpty && setB.contains(s))
      .length;
}

int ageGap(int ageA, int ageB) => (ageA - ageB).abs();

int compatibility(
    List<String> interestsA, 
    int ageA, 
    List<String> interestsB, 
    int ageB) {
      var score = (sharedInterests(interestsA, interestsB) * 20).clamp(0, 80);
      if (ageGap(ageA, ageB) <= 3) score += 20;
      return score.clamp(0, 100);
}

bool isMatch(int score) => score >= 60;

List<String> _readList() {
  final line = stdin.readLineSync() ?? '';
  return line
      .split(',')
      .map((s) => s.trim())
      .where((s) => s.isNotEmpty)
      .toList();
}
void main() {
  print('How many pairs?');
  final pairs = int.parse(stdin.readLineSync()!.trim());
  var matches = 0;

  for (var i = 0; i < pairs; i++) {
    print('First character name: ');
    final nameA = stdin.readLineSync()!.trim();
    print('First character age: ');
    final ageA = int.parse(stdin.readLineSync()!.trim());
    print('First character interests: ');
    final interestA = _readList();

    print('Second character name: ');
    final nameB = stdin.readLineSync()!.trim();
    print('First character age: ');
    final ageB = int.parse(stdin.readLineSync()!.trim());
    print('First character interests: ');
    final interestB = _readList();

    final score = compatibility(interestA, ageA, interestB, ageB);
    final matched = isMatch(score);
    if (matched) matches++;

    print('$nameA & $nameB: $score - ${matched ? "It's a match!" : "Keep swiping."}');
  }
  print(matches);
}
