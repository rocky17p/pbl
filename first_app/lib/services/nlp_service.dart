Map<String, dynamic> extractPrescriptionDetails(String text) {
  final List<Map<String, String>> medicines = [];
  List<String> medicineNames = [];
  List<String> dosages = [];
  List<String> frequencies = [];
  List<String> durations = [];

  List<String> lines = text.split('\n');

  // Debug: Print all lines
  print('═════════ LINES FROM OCR ═════════');
  for (int i = 0; i < lines.length; i++) {
    print('Line $i: "${lines[i].trim()}"');
  }
  print('══════════════════════════════════');

  // Step 1: Extract medicine names
  bool medicineSection = false;
  for (int i = 0; i < lines.length; i++) {
    final line = lines[i].trim();

    if (line.contains("Medicine Name")) {
      medicineSection = true;
      continue;
    }

    if (medicineSection) {
      final medicineMatch =
          RegExp(r'^\d+\)\s+(TAB\.|CAP\.)\s+(.+)$').firstMatch(line);
      if (medicineMatch != null) {
        medicineNames
            .add('${medicineMatch.group(1)} ${medicineMatch.group(2)}');
      } else if (line.contains("Advice Given:")) {
        break; // End of medicine section
      }
    }
  }

  // Step 2: Extract dosages and frequencies
  bool dosageSection = false;
  for (int i = 0; i < lines.length; i++) {
    final line = lines[i].trim();

    if (line.contains("Dosage")) {
      dosageSection = true;
      continue;
    }

    if (dosageSection) {
      if (line.contains(RegExp(r'Morning|Night|Eve|Aft|Moming|Morming',
          caseSensitive: false))) {
        dosages.add(line.replaceAll(RegExp(r'\(.*'), '').trim());

        // Check next line for frequency
        if (i + 1 < lines.length &&
            lines[i + 1].contains(RegExp(r'Before Food|After Food'))) {
          frequencies.add(lines[i + 1].replaceAll(RegExp(r'[()]'), '').trim());
          i++; // Skip processed line
        } else {
          frequencies.add(''); // No frequency found
        }
      } else if (line.contains("Duration")) {
        break; // End of dosage section
      }
    }
  }

  // Step 3: Extract durations
  bool durationSection = false;
  for (int i = 0; i < lines.length; i++) {
    final line = lines[i].trim();

    if (line.contains("Duration")) {
      durationSection = true;
      continue;
    }

    if (durationSection) {
      final durationMatch = RegExp(r'\d+\s+Days?').firstMatch(line);
      if (durationMatch != null) {
        durations.add(durationMatch.group(0)!);
      } else if (line.contains("Date:")) {
        break; // End of duration section
      }
    }
  }

  // Step 4: Combine medicine names, dosages, frequencies, and durations
  for (int i = 0; i < medicineNames.length; i++) {
    medicines.add({
      'name': medicineNames[i],
      'dosage': i < dosages.length ? dosages[i] : '',
      'frequency': i < frequencies.length ? frequencies[i] : '',
      'duration': i < durations.length ? durations[i] : '',
    });
  }

  // Debug: Print extracted medicines
  print('══════ EXTRACTED MEDICINES ══════');
  for (var med in medicines) {
    print(med);
  }
  print('══════════════════════════════════');

  return {
    'medicines': medicines,
  };
}
