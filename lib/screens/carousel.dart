import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
// import 'package:assignment/screens/text_item.dart';
import 'package:weading/screens/switch_page_dialog.dart';
import 'package:weading/screens/color_picker_dialog.dart';

class CarouselDemo extends StatefulWidget {
  const CarouselDemo({super.key});

  @override
  _CarouselDemoState createState() => _CarouselDemoState();
}

class _CarouselDemoState extends State<CarouselDemo> {
  int _currentIndex = 0;
  // final CarouselController _controller = CarouselController();
  final List<List<String>> _texts = List.generate(4, (_) => []);
  final List<List<Offset>> _textOffsets = List.generate(4, (_) => []);
  final List<List<String>> _fontFamilies = List.generate(4, (_) => []);
  final List<List<double>> _fontSizes = List.generate(4, (_) => []);
  final List<List<Color>> _textColors = List.generate(4, (_) => []);
  bool _showCustomizeButton = false;
  String _selectedFontFamily = 'Arial';
  double _selectedFontSize = 16.0;
  Color _selectedColor = Colors.black;
  int _selectedTextIndex = 0;

  final List<List<List<String>>> _undoTextStacks = List.generate(4, (_) => []);
  final List<List<List<String>>> _redoTextStacks = List.generate(4, (_) => []);
  final List<List<List<String>>> _undoFontFamilyStacks = List.generate(4, (_) => []);
  final List<List<List<String>>> _redoFontFamilyStacks = List.generate(4, (_) => []);
  final List<List<List<double>>> _undoFontSizeStacks = List.generate(4, (_) => []);
  final List<List<List<double>>> _redoFontSizeStacks = List.generate(4, (_) => []);
  final List<List<List<Color>>> _undoColorStacks = List.generate(4, (_) => []);
  final List<List<List<Color>>> _redoColorStacks = List.generate(4, (_) => []);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 80),
          Expanded(
            child: Stack(
              children: [
                CarouselSlider.builder(
                  itemCount: 4,
                  itemBuilder: (context, index, realIndex) {
                    return _buildPage(index);
                  },
                  // carouselController: _controller,
                  options: CarouselOptions(
                    autoPlay: false,
                    enlargeCenterPage: true,
                    aspectRatio: 9 / 14,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                        _showCustomizeButton = false;
                      });
                    },
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      // _controller.previousPage();
                    },
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () {
                      // _controller.nextPage();
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              4,
                  (index) => Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                  _currentIndex == index ? Colors.blueAccent : Colors.grey,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 80,
            color: Colors.yellow[50],
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: _undo,
                    icon: Icon(Icons.undo),
                    color: Colors.black,
                  ),
                  IconButton(
                    onPressed: _redo,
                    icon: Icon(Icons.redo),
                    color: Colors.black,
                  ),
                  IconButton(
                    onPressed: () {
                      _showAddTextDialog(context);
                    },
                    icon: Icon(Icons.add_circle_outline),
                    iconSize: 28,
                    color: Colors.black,
                  ),
                  if (_showCustomizeButton)
                    IconButton(
                      onPressed: () {
                        _showCustomizeDialog(context);
                      },
                      icon: Icon(Icons.edit),
                      iconSize: 28,
                      color: Colors.black,
                    ),
                  IconButton(
                    onPressed: () {
                      _switchPages(_currentIndex);
                    },
                    icon: Icon(Icons.switch_left),
                    iconSize: 28,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(int index) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 18),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.yellow.withOpacity(0.5),
                Colors.green.withOpacity(0.8)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(child: Text('')),
        ),
        for (var i = 0; i < _texts[index].length; i++)
          Positioned(
            left: _textOffsets[index][i].dx,
            top: _textOffsets[index][i].dy,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _showCustomizeButton = true;
                  _selectedFontFamily = _fontFamilies[index][i];
                  _selectedFontSize = _fontSizes[index][i];
                  _selectedColor = _textColors[index][i];
                  _selectedTextIndex = i;
                });
              },
              child: Draggable(
                child: Text(
                  _texts[index][i],
                  style: TextStyle(
                    fontFamily: _fontFamilies[index][i],
                    fontSize: _fontSizes[index][i],
                    color: _textColors[index][i],
                  ),
                ),
                feedback: Text(_texts[index][i]),
                onDraggableCanceled: (
                    velocity, offset) {
                  setState(() {
                    _textOffsets[index][i] = offset;
                  });
                },
              ),
            ),
          ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Image.asset(
            'assets/wedding-arch.png',
            fit: BoxFit.contain,
            height: 200,
            width: 100,
          ),
        ),
      ],
    );
  }

  void _undo() {
    setState(() {
      for (int i = 0; i <_undoTextStacks.length; i++) {
        if (_undoTextStacks[i].isNotEmpty) {
          var textAction = _undoTextStacks[i].removeLast
            ();
          var fontFamilyAction = _undoFontFamilyStacks[i].removeLast();
          var fontSizeAction = _undoFontSizeStacks[i].removeLast();
          var colorAction = _undoColorStacks[i].removeLast();
          _redoTextStacks[i].add(textAction);
          _redoFontFamilyStacks[i].add(fontFamilyAction);
          _redoFontSizeStacks[i].add(fontSizeAction);
          _redoColorStacks[i].add(colorAction);

          _texts[i] = textAction;
          _fontFamilies[i] = fontFamilyAction;
          _fontSizes[i] = fontSizeAction;
          _textColors[i] = colorAction;
        }
      }
    });
  }

  void _redo() {
    setState(() {
      for (int i = 0; i < _redoTextStacks.length; i++) {
        if (_redoTextStacks[i].isNotEmpty) {
          var textAction = _redoTextStacks[i].removeLast();
          var fontFamilyAction = _redoFontFamilyStacks[i].removeLast();
          var fontSizeAction = _redoFontSizeStacks[i].removeLast();
          var colorAction = _redoColorStacks[i].removeLast();
          _undoTextStacks[i].add(textAction);
          _undoFontFamilyStacks[i].add(fontFamilyAction);
          _undoFontSizeStacks[i].add(fontSizeAction);
          _undoColorStacks[i].add(colorAction);

          _texts[i] = textAction;
          _fontFamilies[i] = fontFamilyAction;
          _fontSizes[i] = fontSizeAction;
          _textColors[i] = colorAction;
        }
      }
    });
  }

  void _switchPages(int currentIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int targetIndex = currentIndex;
        return SwitchPageDialog(
          currentIndex: currentIndex,
          onIndexChanged: (index) {
            targetIndex = index;
          },
          onConfirm: () {
            if (targetIndex >= 0 && targetIndex < _texts.length) {
              Navigator.of(context).pop();
              setState(() {
                // Swap texts
                List<String> tempTexts = _texts[currentIndex];
                _texts[currentIndex] = _texts[targetIndex];
                _texts[targetIndex] = tempTexts;
                // Swap text offsets
                List<Offset> tempOffsets = _textOffsets[currentIndex];
                _textOffsets[currentIndex] = _textOffsets[targetIndex];
                _textOffsets[targetIndex] = tempOffsets;

                // Swap font families
                List<String> tempFontFamilies = _fontFamilies[currentIndex];
                _fontFamilies[currentIndex] = _fontFamilies[targetIndex];
                _fontFamilies[targetIndex] = tempFontFamilies;

                // Swap font sizes
                List<double> tempFontSizes = _fontSizes[currentIndex];
                _fontSizes[currentIndex] = _fontSizes[targetIndex];
                _fontSizes[targetIndex] = tempFontSizes;

                // Swap text colors
                List<Color> tempColors = _textColors[currentIndex];
                _textColors[currentIndex] = _textColors[targetIndex];
                _textColors[targetIndex] = tempColors;

                // Swap undo stacks
                List<List<String>> tempUndoTextStacks =
                _undoTextStacks[currentIndex];
                _undoTextStacks[currentIndex] = _undoTextStacks[targetIndex];
                _undoTextStacks[targetIndex] = tempUndoTextStacks;

                List<List<String>> tempRedoTextStacks =
                _redoTextStacks[currentIndex];
                _redoTextStacks[currentIndex] = _redoTextStacks[targetIndex];
                _redoTextStacks[targetIndex] = tempRedoTextStacks;

                List<List<String>> tempUndoFontFamilyStacks =
                _undoFontFamilyStacks[currentIndex];
                _undoFontFamilyStacks[currentIndex] =
                _undoFontFamilyStacks[targetIndex];
                _undoFontFamilyStacks[targetIndex] =
                    tempUndoFontFamilyStacks;

                List<List<String>> tempRedoFontFamilyStacks =
                _redoFontFamilyStacks[currentIndex];
                _redoFontFamilyStacks[currentIndex] =
                _redoFontFamilyStacks[targetIndex];
                _redoFontFamilyStacks[targetIndex] =
                    tempRedoFontFamilyStacks;

                List<List<double>> tempUndoFontSizeStacks =
                _undoFontSizeStacks[currentIndex];
                _undoFontSizeStacks[currentIndex] =
                _undoFontSizeStacks[targetIndex];
                _undoFontSizeStacks[targetIndex] =
                    tempUndoFontSizeStacks;

                List<List<double>> tempRedoFontSizeStacks =
                _redoFontSizeStacks[currentIndex];
                _redoFontSizeStacks[currentIndex] =
                _redoFontSizeStacks[targetIndex];
                _redoFontSizeStacks[targetIndex] =
                    tempRedoFontSizeStacks;

                List<List<Color>> tempUndoColorStacks =
                _undoColorStacks[currentIndex];
                _undoColorStacks[currentIndex] = _undoColorStacks[targetIndex];
                _undoColorStacks[targetIndex] = tempUndoColorStacks;

                List<List<Color>> tempRedoColorStacks =
                _redoColorStacks[currentIndex];
                _redoColorStacks[currentIndex] = _redoColorStacks[targetIndex];
                _redoColorStacks[targetIndex] = tempRedoColorStacks;
              });
            }
          },
        );
      },
    );
  }

  void _showAddTextDialog(BuildContext context) {
    TextEditingController _textFieldController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add Text"),
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: "Enter your text"),
          ),
          actions: [
            TextButton(
              child: Text("Add"),
              onPressed: () {
                setState(() {
                  var newText = _textFieldController.text;
                  _texts[_currentIndex].add(newText);
                  _textOffsets[_currentIndex].add(Offset(150, 300));
                  _fontFamilies[_currentIndex].add(_selectedFontFamily);
                  _fontSizes[_currentIndex].add(_selectedFontSize);
                  _textColors[_currentIndex].add(_selectedColor);
                  // Add action to the undo stack
                  _undoTextStacks[_currentIndex]
                      .add(List.from(_texts[_currentIndex]));
                  _undoFontFamilyStacks[_currentIndex].add(
                      List.from(_fontFamilies[_currentIndex]));
                  _undoFontSizeStacks[_currentIndex]
                      .add(List.from(_fontSizes[_currentIndex]));
                  _undoColorStacks[_currentIndex]
                      .add(List.from(_textColors[_currentIndex]));

                  _showCustomizeButton = false;
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showCustomizeDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Customize Text"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (text) {
                    setState(() {
                      _texts[_currentIndex][_selectedTextIndex] = text;
                    });
                  },
                  controller: TextEditingController(
                    text: _texts[_currentIndex][_selectedTextIndex],
                  ),
                  decoration: InputDecoration(
                    labelText: 'Text',
                    hintText: 'Enter your text',
                  ),
                ),
                DropdownButtonFormField<String>(
                  value: _selectedFontFamily,
                  items: <String>[
                    'Arial',
                    'Roboto',
                    'Times New Roman',
                    'Courier',
                    'Georgia'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _selectedFontFamily = value!;
                      _fontFamilies[_currentIndex][_selectedTextIndex] =
                          _selectedFontFamily;
                    });
                  },
                ),
                Slider(
                  value: _selectedFontSize,
                  min: 10.0,
                  max: 50.0,
                  divisions: 40,
                  label: _selectedFontSize.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _selectedFontSize = value;
                      _fontSizes[_currentIndex][_selectedTextIndex] =
                          _selectedFontSize;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    _showColorPicker(context);
                  },
                  child: Text('Choose Color'),
                ),
              ],
            ),
            actions: [
              TextButton(
                child: Text("Save"),
                onPressed: () {
                  setState(() {
                    _showCustomizeButton = false;
                    _undoTextStacks[_currentIndex]
                        .add(List.from(_texts[_currentIndex]));
                    _undoFontFamilyStacks[_currentIndex].add(
                        List.from(_fontFamilies[_currentIndex]));
                    _undoFontSizeStacks[_currentIndex]
                        .add(List.from(_fontSizes[_currentIndex]));
                    _undoColorStacks[_currentIndex]
                        .add(List.from(_textColors[_currentIndex]));
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
    );
  }

  void _showColorPicker(BuildContext context) {
    Color pickerColor = _selectedColor;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ColorPickerDialog(
          pickerColor: pickerColor,
          onColorChanged: (Color color) {
            pickerColor = color;
          },
          onConfirm: () {
            setState(() {
              _selectedColor = pickerColor;
              _textColors[_currentIndex][_selectedTextIndex] = _selectedColor;
            });
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}


