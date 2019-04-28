void loadMap(ArrayList<String> map, String filename) {
  String[] lines = loadStrings(filename);
  map.clear();
  for (int i = 0 ; i < lines.length; i++) {
    map.add(lines[i]);
  }
}

String mapToString(ArrayList<String> map) {
  String mapStr = "";
  for (int i = 0; i < map.size(); i++) {
    mapStr += map.get(i) + ";";
  }
  return mapStr;
}
