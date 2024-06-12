

String? generarString(
  int cant,
  List<DateTime> time,
  List<String> days,
) {
  // Check if the lengths of the lists match the value of `cant`
  if (cant != time.length || cant != days.length) {
    return null; // Return null if lengths do not match
  }

  List<String> formattedStrings = [];

  for (int i = 0; i < cant; i++) {
    // Convert days string to binary representation
    String binaryString =
        days[i].split('').map((char) => char == '-' ? '0' : '1').join('');
    // Convert binary string to decimal
    int decimalValue = (int.parse(binaryString, radix: 2));
    String paddedDecimalValue = decimalValue.toString().padLeft(3, '0');    // Format the time as HH:MM
    String formattedTime =
        "${time[i].hour.toString().padLeft(2, '0')}:${time[i].minute.toString().padLeft(2, '0')}";
    // Create the formatted string
    String formattedString = "n$formattedTime n$paddedDecimalValue;";
    String formattedStringNoSpaces = formattedString.replaceAll(' ', '');

    formattedStrings.add(formattedStringNoSpaces);
  }

  // Join all formatted strings into one string
  return formattedStrings.join();
}
