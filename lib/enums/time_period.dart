enum TimePeriod {
  WEEKS4,
  MONTHS6,
  ALLTIME,
}

extension TimePeriodExtension on TimePeriod {
  TimePeriod convert(String tp) {
    if (tp == 'short_term') {
      return TimePeriod.WEEKS4;
    }
    if (tp == 'medium_term') {
      return TimePeriod.MONTHS6;
    } else {
      return TimePeriod.ALLTIME;
    }
  }

  String get name {
    switch (this) {
      case TimePeriod.ALLTIME:
        return "long_term";
      case TimePeriod.MONTHS6:
        return "medium_term";
      case TimePeriod.WEEKS4:
        return "short_term";
    }
  }
}

TimePeriod convertTermToTimePeriod(String tp) {
  if (tp == 'short_term') {
    return TimePeriod.WEEKS4;
  }
  if (tp == 'medium_term') {
    return TimePeriod.MONTHS6;
  } else {
    return TimePeriod.ALLTIME;
  }
}
