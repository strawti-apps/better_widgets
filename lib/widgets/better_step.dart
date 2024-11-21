import 'package:better_widgets/extensions/better_build_context.dart';
import 'package:better_widgets/widgets/buttons/better_filled_icon_button.dart';
import 'package:flutter/material.dart';

/// A widget that displays a customizable step indicator.
///
/// The `BetterStepIndicator` changes its appearance based on whether it is
/// selected or not. It animates smoothly between its states.
class BetterStepIndicator extends StatelessWidget {
  /// Indicates if the step is selected.
  final bool selected;

  /// Creates a [BetterStepIndicator].
  ///
  /// The [selected] parameter defaults to `false`.
  const BetterStepIndicator({
    super.key,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: selected
            ? context.themeData.colorScheme.primary
            : context.themeData.colorScheme.secondary,
      ),
      width: selected ? 30 : 8,
      height: 8,
    );
  }
}

/// A carousel-based widget for creating step-based navigation.
///
/// [BetterStep] allows users to navigate through a list of children widgets
/// using customizable next/previous buttons and step indicators. It supports
/// callbacks for custom behaviors on finishing the steps.
class BetterStep extends StatefulWidget {
  /// A list of widgets representing each step in the carousel.
  final List<Widget> children;

  /// Custom widget for the "next" button. Defaults to a styled arrow button.
  final Widget? customNextButton;

  /// Custom widget for the "previous" button. Defaults to a styled arrow button.
  final Widget? customPreviousButton;

  /// A function to build custom step indicators.
  ///
  /// The function receives a `selected` boolean to indicate the state of the step.
  final Widget Function(bool selected)? customStepIndicator;

  /// Aligns the step indicators within the carousel layout.
  final Alignment? stepPosition;

  /// An optional external controller for the carousel.
  final CarouselController? controller;

  /// Callback function triggered when the user finishes the steps.
  final Function(BuildContext context)? onFinish;

  /// Creates a [BetterStep] widget.
  ///
  /// The [children] parameter is required and must not be empty.
  ///
  /// Example usage:
  /// ```dart
  /// BetterStep(
  ///   children: [
  ///     StepOne(),
  ///     StepTwo(),
  ///     StepThree(),
  ///   ],
  /// )
  /// ```
  const BetterStep({
    super.key,
    this.children = const [],
    this.customNextButton,
    this.customPreviousButton,
    this.customStepIndicator,
    this.stepPosition,
    this.controller,
    this.onFinish,
  });

  @override
  State<BetterStep> createState() => _BetterStepState();
}

class _BetterStepState extends State<BetterStep> {
  /// Internal controller for the carousel.
  late CarouselController controller;

  /// Tracks the current index of the carousel.
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    // Use the provided controller or create a new one.
    if (widget.controller != null) {
      controller = widget.controller!;
    } else {
      controller = CarouselController();
    }

    setState(() {
      currentIndex = controller.initialItem;
    });

    // Listen to changes in the carousel's position.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.addListener(() {
        double itemExtent = context.mediaQuery.size.width;
        int index = (controller.offset / itemExtent).round();
        if (index != currentIndex) {
          setState(() {
            currentIndex = index;
          });
        }
      });
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Carousel displaying the steps.
        Expanded(
          child: CarouselView(
            controller: controller,
            overlayColor: const WidgetStatePropertyAll(Colors.transparent),
            itemExtent: context.mediaQuery.size.width,
            itemSnapping: true,
            children: widget.children,
          ),
        ),
        // Navigation and indicators.
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Previous button.
              BetterIconFilledButton(
                onPressed: () {
                  if (currentIndex == 0) {
                    return;
                  }
                  final previousPosition =
                      (currentIndex - 1) * context.mediaQuery.size.width;
                  controller.animateTo(
                    previousPosition,
                    curve: Curves.easeInOut,
                    duration: const Duration(milliseconds: 200),
                  );
                },
                icon: const Icon(
                  Icons.arrow_back,
                ),
              ),
              // Step indicators.
              Row(
                children: [
                  ...List.generate(
                    widget.children.length,
                    (index) => Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? 0 : 4,
                        right: index == widget.children.length - 1 ? 0 : 4,
                      ),
                      child: widget.customStepIndicator
                              ?.call(index == currentIndex) ??
                          BetterStepIndicator(
                            selected: index == currentIndex,
                          ),
                    ),
                  )
                ],
              ),
              // Next button.
              BetterIconFilledButton(
                onPressed: () {
                  if (currentIndex == widget.children.length - 1) {
                    if (widget.onFinish != null) {
                      widget.onFinish?.call(context);
                      return;
                    }
                    controller.animateTo(
                      0,
                      curve: Curves.bounceOut,
                      duration: const Duration(milliseconds: 200),
                    );
                    return;
                  }
                  final nextPosition =
                      (currentIndex + 1) * context.mediaQuery.size.width;
                  controller.animateTo(
                    nextPosition,
                    curve: Curves.bounceOut,
                    duration: const Duration(milliseconds: 200),
                  );
                },
                icon: const Icon(
                  Icons.arrow_forward,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
