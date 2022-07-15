import 'package:kaiteki/fediverse/model/user_reference.dart';
import 'package:kaiteki/utils/extensions.dart';
import 'package:kaiteki/utils/text/parsers/text_parser.dart';

class Element {
  final List<Element>? children;

  const Element({this.children});
}

typedef ReplacementElementBuilder = Element Function(String text);

class TextElement extends Element {
  final String? text;
  final TextElementStyle? style;

  const TextElement(
    this.text, {
    this.style,
    List<Element>? children,
  }) : super(children: children);

  List<Element> cut(int index, int length, ReplacementElementBuilder builder) {
    final text = this.text;

    if (text == null) {
      return [];
    }

    String? start, middle, end;

    if (index >= 1) {
      start = text.substring(0, index);
    }

    middle = text.substring(index, index + length);

    final endIndex = index + length;
    if (endIndex < text.length) {
      end = text.substring(endIndex, text.length);
    }

    return [
      if (start != null) TextElement(start),
      builder(middle),
      if (end != null) TextElement(end),
    ];
  }

  TextElement cutAsElement(
    int index,
    int length,
    ReplacementElementBuilder builder,
  ) {
    final children = this.children;
    Iterable<Element> newChildren = cut(index, length, builder);

    if (children != null) {
      newChildren = newChildren.followedBy(children);
    }

    return TextElement(
      null,
      style: style,
      children: newChildren.toList(growable: false),
    );
  }

  @override
  String toString() {
    return "Text ($text)";
  }
}

class TextElementStyle {
  final bool bold;
  final bool italic;
  final TextElementFont font;
  final double scale;
  final bool blur;

  const TextElementStyle({
    this.bold = false,
    this.italic = false,
    this.scale = 1.0,
    this.font = TextElementFont.normal,
    this.blur = false,
  });
}

enum TextElementFont {
  normal,
  monospace,
}

class LinkElement extends Element {
  final Uri destination;

  const LinkElement(
    this.destination, {
    List<Element>? children,
  }) : super(children: children);

  @override
  String toString() {
    return "Link ($destination)";
  }
}

class MentionElement extends Element {
  final UserReference reference;

  const MentionElement(this.reference);

  @override
  String toString() {
    return "Mention";
  }
}

class HashtagElement extends Element {
  final String name;

  const HashtagElement(this.name);

  @override
  String toString() {
    return "Hashtag";
  }
}

class EmojiElement extends Element {
  final String name;

  const EmojiElement(this.name);

  @override
  String toString() {
    return "Emoji (:$name:)";
  }
}

extension ElementExtensions on Element {
  String get allText {
    var initalText = "";
    if (this is TextElement && (this as TextElement).text != null) {
      final elementText = (this as TextElement).text;
      if (elementText != null) {
        initalText = elementText;
      }
    }

    final buffer = StringBuffer(initalText);

    final children = this.children;
    if (children != null) {
      for (final child in children) {
        buffer.write(child.allText);
      }
    }

    return buffer.toString();
  }
}

extension ElementListExtensions on List<Element> {
  List<Element> parseWith(TextParser parser) {
    return map(parser.parseElement).concat().toList();
  }
}
