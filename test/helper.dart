library test.helper;
import 'package:code_transformers/src/test_harness.dart';
import 'package:barback/barback.dart';
import 'dart:async';
import 'package:test/test.dart';
import 'package:code_transformers/tests.dart' as codet;
import 'package:code_transformers/src/test_harness.dart';
import 'package:stack_trace/stack_trace.dart';

/// Defines a test which invokes [applyTransformers].
testPhases(String testName, List<List<Transformer>> phases,
Map<String, String> inputs, Map<String, String> results,
[List<String> messages,
  codet.StringFormatter formatter = codet.StringFormatter.noTrailingWhitespace]) {
test(testName, () => applyTransformers(phases,
  inputs: inputs,
  results: results,
  messages: messages,
  formatter: formatter));
}

/// Updates the provided transformers with [inputs] as asset inputs then
/// validates that [results] were generated.
///
/// The keys for inputs and results are 'package_name|lib/file.dart'.
/// Only files which are specified in results are validated.
///
/// If [messages] is non-null then this will validate that only the specified
/// messages were generated, ignoring info messages.
Future applyTransformers(List<List<Transformer>> phases,
{Map<String, String> inputs: const {}, Map<String, String> results: const {
}, List<String> messages: const [],
codet.StringFormatter formatter: codet.StringFormatter.noTrailingWhitespace}) {
var helper = new MyTestHelper(phases, inputs, messages, formatter: formatter)
..run();
return helper.checkAll(results).then((_) => helper.tearDown());
}

/// A helper package provider that has files stored in memory, also wraps
/// [Barback] to simply our tests.
class MyTestHelper implements PackageProvider {

/// Maps from an asset string identifier of the form 'package|path' to the
/// file contents.
final Map<String, dynamic> files;
final Iterable<String> packages;
final List<String> messages;
int messagesSeen = 0;
bool errorSeen = false;

Barback barback;
var errorSubscription;
var resultSubscription;
var logSubscription;

final StringFormatter formatter;

Future<Asset> getAsset(AssetId id) {
  var value = files[idToString(id)];
  if (value is String){
    return new Future.value(new Asset.fromString(id, value));
  } else{
    return new Future.value(new Asset.fromBytes(id, value));
  }
}

MyTestHelper(List<List<Transformer>> transformers, Map<String, dynamic> files,
    this.messages, {this.formatter: StringFormatter.noTrailingWhitespace})
    : files = files,
      packages = files.keys.map((s) => idFromString(s).package) {
  barback = new Barback(this);
  for (var p in packages) {
    barback.updateTransformers(p, transformers);
  }

  errorSubscription = barback.errors.listen((e) {
    var trace = null;
    if (e is Error) trace = e.stackTrace;
    if (trace != null) {
      print(Trace.format(trace));
    }
    fail('error running barback: $e');
  });

  resultSubscription = barback.results.listen((result) {
    expect(result.succeeded, !errorSeen, reason: "${result.errors}");
  });

  logSubscription = barback.log.listen((entry) {
    // Ignore info and fine messages.
    if (entry.level == LogLevel.INFO || entry.level == LogLevel.FINE) return;
    if (entry.level == LogLevel.ERROR) errorSeen = true;
    // We only check messages when an expectation is provided.
    if (messages == null) return;

    var msg = '${entry.level.name.toLowerCase()}: ${entry.message}';
    var span = entry.span;
    var spanInfo = span == null
        ? ''
        : ' (${span.sourceUrl} ${span.start.line} ${span.start.column})';
    expect(messagesSeen, lessThan(messages.length),
        reason: 'more messages than expected.\nMessage seen: $msg$spanInfo');
    expect('$msg$spanInfo', messages[messagesSeen++]);
  });
}

void tearDown() {
  errorSubscription.cancel();
  resultSubscription.cancel();
  logSubscription.cancel();
}

/// Tells barback which files have changed, and thus anything that depends on
/// it on should be computed. By default mark all the input files.
void run([Iterable<String> paths]) {
  if (paths == null) paths = files.keys;
  barback.updateSources(paths.map(idFromString));
}

Future<String> operator [](String assetString) {
  return barback
      .getAssetById(idFromString(assetString))
      .then((asset) => asset.readAsString());
}

Future check(String assetIdString, String content) {
  return this[assetIdString].then((value) {
    value = formatter.formatString(value);
    content = formatter.formatString(content);
    expect(value, content, reason: 'Final output of $assetIdString differs.');
  });
}

Future checkAll(Map<String, String> files) {
  return barback.results.first.then((_) {
    if (files == null) return null;
    var futures = [];
    files.forEach((k, v) {
      futures.add(check(k, v));
    });
    return Future.wait(futures);
  }).then((_) {
    // We only check messages when an expectation is provided.
    if (messages == null) return;
    expect(
        messagesSeen, messages.length, reason: 'less messages than expected');
  });
}
}