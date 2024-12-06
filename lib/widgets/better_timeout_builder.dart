import 'dart:async';
import 'package:flutter/material.dart';

/// A widget that provides a countdown timer and rebuilds its child
/// with the remaining time.
///
/// The [BetterTimeoutBuilder] is useful for scenarios where you need to
/// display or act on a countdown, such as a timeout for user interaction
/// or updating UI elements at regular intervals.
///
/// The widget rebuilds itself every second, providing the updated
/// [remainingTime] to the [builder] function.
///
/// When the timer reaches zero, an optional [onTimeout] callback is triggered.
class BetterTimeoutBuilder extends StatefulWidget {
  /// The total duration of the timeout.
  final Duration timeout;

  /// Whether the countdown should start automatically when the widget
  /// is initialized.
  ///
  /// Defaults to `true`.
  final bool startOnInit;

  /// A builder function that is called with the [BuildContext],
  /// the current [remainingTime], and a [startTimeout] callback to
  /// restart the timer.
  ///
  /// The [remainingTime] is updated every second.
  final Widget Function(
    BuildContext context,
    Duration remainingTime,
    VoidCallback startTimeout,
  ) builder;

  /// An optional callback that is called when the countdown reaches zero.
  final VoidCallback? onTimeout;

  /// Creates a [BetterTimeoutBuilder].
  ///
  /// - [timeout] is the total duration for the countdown.
  /// - [builder] is the function that rebuilds the widget with the
  ///   remaining time.
  /// - [startOnInit] determines if the timer starts on widget initialization.
  /// - [onTimeout] is an optional callback for when the timer ends.
  const BetterTimeoutBuilder({
    super.key,
    required this.timeout,
    required this.builder,
    this.startOnInit = true,
    this.onTimeout,
  });

  @override
  State<BetterTimeoutBuilder> createState() => _BetterTimeoutBuilderState();
}

class _BetterTimeoutBuilderState extends State<BetterTimeoutBuilder> {
  /// The remaining time for the countdown.
  late Duration remainingTime;

  /// The internal timer used for the countdown.
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Initialize the remaining time based on [startOnInit].
    remainingTime = widget.startOnInit ? widget.timeout : Duration.zero;

    if (widget.startOnInit) {
      startTimeout();
    }
  }

  @override
  void didUpdateWidget(covariant BetterTimeoutBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Restart the timer if the timeout duration changes and [startOnInit] is true.
    if (oldWidget.timeout != widget.timeout && widget.startOnInit) {
      startTimeout();
    }
  }

  /// Starts the countdown timer.
  ///
  /// Cancels any existing timer and resets the [remainingTime].
  void startTimeout() {
    _timer?.cancel();

    setState(() {
      remainingTime = widget.timeout;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime <= const Duration(seconds: 1)) {
        // Timer finished, trigger the [onTimeout] callback and stop the timer.
        timer.cancel();
        widget.onTimeout?.call();

        setState(() {
          remainingTime = Duration.zero;
        });
      } else {
        // Decrease the remaining time by one second.
        setState(() {
          remainingTime -= const Duration(seconds: 1);
        });
      }
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed.
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build the widget using the provided [builder] function.
    return widget.builder(context, remainingTime, startTimeout);
  }
}
