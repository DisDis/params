library params.accessors;

import 'package:params/annotation.dart';

abstract class ParamsModelAccessor<T extends Serialize> extends Accessor<T, dynamic>{
  T create(value);
  T get(value)=> value != null? create(value) : null;
  dynamic set(T value)=> value != null? value.$container$ : null;
}

class DateTimeMillisecondsAccessor extends Accessor<DateTime, int>{
  DateTime get(int value)=> value != null? new DateTime.fromMillisecondsSinceEpoch(value) : null;
  int set(DateTime value)=> value != null? value.millisecondsSinceEpoch : null;
}