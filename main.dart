import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'نموذج الإدخال',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InputForm(),
    );
  }
}

class InputForm extends StatefulWidget {
  @override
  _InputFormState createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
 
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  

  bool _isChecked = false;
  String _selectedGender = 'ذكر';
  List<String> _selectedInterests = [];
  double _sliderValue = 50.0;
  TimeOfDay _selectedTime = TimeOfDay.now();


  final List<String> _genders = ['ذكر', 'أنثى'];
  final List<String> _interests = ['الرياضة', 'القراءة', 'البرمجة', 'السفر'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('نموذج الإدخال الشامل'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: 'الاسم الكامل',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 16),


              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'كلمة المرور',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              SizedBox(height: 16),


              TextField(
                controller: _dateController,
                readOnly: true,
                onTap: () => _selectDate(context),
                decoration: InputDecoration(
                  labelText: 'تاريخ الميلاد',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
              ),
              SizedBox(height: 16),


              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'الاهتمامات',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Column(
                        children: _interests.map((interest) {
                          return CheckboxListTile(
                            title: Text(interest),
                            value: _selectedInterests.contains(interest),
                            onChanged: (bool? value) {
                              setState(() {
                                if (value!) {
                                  _selectedInterests.add(interest);
                                } else {
                                  _selectedInterests.remove(interest);
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),


              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'الجنس',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Column(
                        children: _genders.map((gender) {
                          return RadioListTile<String>(
                            title: Text(gender),
                            value: gender,
                            groupValue: _selectedGender,
                            onChanged: (String? value) {
                              setState(() {
                                _selectedGender = value!;
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),


              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'مستوى الخبرة: ${_sliderValue.toInt()}%',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Slider(
                        value: _sliderValue,
                        min: 0,
                        max: 100,
                        divisions: 10,
                        onChanged: (double value) {
                          setState(() {
                            _sliderValue = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),


              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Text(
                        'موافقة على الشروط والأحكام',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Switch(
                        value: _isChecked,
                        onChanged: (bool value) {
                          setState(() {
                            _isChecked = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),


              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'الوقت المفضل',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () => _selectTime(context),
                        child: Text('اختر الوقت: ${_selectedTime.format(context)}'),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),


              Center(
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  ),
                  child: Text('  ارسال  '),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }


  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _submitForm() {
    print('=' * 50);
    print('بيانات النموذج المدخلة:');
    print('=' * 50);
    print('الاسم: ${_textController.text}');
    print('كلمة المرور: ${_passwordController.text}');
    print('تاريخ الميلاد: ${_dateController.text}');
    print('الاهتمامات: ${_selectedInterests.join(", ")}');
    print('الجنس: $_selectedGender');
    print('مستوى الخبرة: ${_sliderValue.toInt()}%');
    print('موافقة على الشروط: ${_isChecked ? "نعم" : "لا"}');
    print('الوقت المفضل: ${_selectedTime.format(context)}');
    print('=' * 50);
    

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('تم عرض البيانات في الترمينال بنجاح!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _passwordController.dispose();
    _dateController.dispose();
    super.dispose();
  }
}