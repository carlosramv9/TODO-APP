//Format String to DateTime with PM/AM

String? formatDateTimeAMPM(String date) {
  if (date.isEmpty) return '';
  var dateTime = DateTime.parse(date);
  return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year} ${dateTime.hour > 12 ? (dateTime.hour - 12).toString().padLeft(2, '0') : dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} ${dateTime.hour > 12 ? 'PM' : 'AM'}';
}
