import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_6/files/user_info.dart';
import 'package:flutter_application_6/models/user.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _invisible = true;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>(); 

  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _jobController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmpasswordController = TextEditingController();

 
 
 
  List<String> countries = [
    'Russia',
    'Ukraine',
    'Belarusia',
    'Uzbekistan',
    'Kazakhstan'
  ];

  String? _selectedCountry;

  final _nameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmpasswordFocus = FocusNode();
  

  User newUser = User();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _jobController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    _nameFocus.dispose();
    _phoneFocus.dispose();
    _passwordFocus.dispose(); 
     _confirmpasswordFocus.dispose();
    super.dispose();
  }

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus,) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Regiser'),
        centerTitle: true,
      ),
      body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              TextFormField(
                focusNode: _nameFocus,
                autofocus: true,
                onFieldSubmitted: (_) {
                  _fieldFocusChange(context, _nameFocus, _phoneFocus);
                },
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  hintText: 'What do people call you?',
                  prefixIcon: Icon(Icons.person),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _nameController.clear();
                    },
                    
                    child: Icon(
                      Icons.delete_outline,
                      color: Colors.black,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
                validator: _validateName,
                onSaved: (value) => newUser.name = value,
              ),
              SizedBox(height: 10),
              TextFormField(
                focusNode: _phoneFocus,
                onFieldSubmitted: (_) {
                  _fieldFocusChange(context, _phoneFocus, _passwordFocus);
                },
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  helperText: 'Phone Format: +7(XXX)XXX-XX-XX',
                  hintText: 'Enter your Phone Number',
                  prefixIcon: Icon(Icons.phone),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _phoneNumberController.clear();
                    },
                    child: Icon(
                      Icons.delete_outline,
                      color: Colors.black,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter(
                      RegExp(
                        r'^[()\d -]{1,20}$',
                      ),
                      allow: true),
                ],
                validator: (value) => _validatePhoneNumber(value!)
                    ? null
                    : 'Phone number must be entered as (###)###-##-##',
                    onSaved: (value) => newUser.phone = value,
              ),
              SizedBox(height: 10),
              SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email Addresss',
                  hintText: 'Enter a your email address',
                  icon: Icon(Icons.mail),
                ),
                keyboardType: TextInputType.emailAddress,
                //  validator: _validateEmail,
                 onSaved: (value) => 
                 newUser.email = value,
               
              ),
              SizedBox(height: 15),
              DropdownButtonFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.map),
                    labelText: 'Country?'),
                items: countries.map((contry) {
                  return DropdownMenuItem(
                  
                    child: Text(contry),
                    value: contry,
                  );
                }).toList(),
                onChanged: (String? country) {
                  print(country);
                  setState(() {
                    _selectedCountry = country;
                    newUser.country = country;
                  });
                },
                value: _selectedCountry,
                
              ),
              SizedBox(height: 15),
              TextFormField(
                focusNode: _passwordFocus,
                controller: _passwordController,
                obscureText: _invisible,
              
                maxLength: 12,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  suffixIcon: IconButton(
                    icon: Icon(
                        _invisible ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _invisible = !_invisible;
                      });
                    },
                  ),
                  icon: Icon(Icons.security),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
                validator: _validatePassword,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _confirmpasswordController,
                obscureText: _invisible,
                maxLength: 12,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  hintText: 'Confirm your password',
                  helperText: 'The password must be from 3 to 12 characters',
                  suffixIcon: IconButton(
                    icon: Icon(
                        _invisible ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _invisible = !_invisible;
                      });
                    },
                  ),
                  icon: Icon(Icons.border_color),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
                validator: _validatePassword,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _jobController,
                decoration: InputDecoration(
                    labelText: 'JOBB',
                    hintText:
                        'Let us know your salary preferences, work schedule',
                    helperText: 'Good luck bro',
                    border: OutlineInputBorder()),
                maxLines: 3,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(100),
                ],
                onSaved: (value) => newUser.job = value,
              ),
              SizedBox(
                height: 15,
              ),
              RaisedButton(
                onPressed: _submitForm,
                color: Colors.amber,
                child:
                    Text('Sumbit Form', style: TextStyle(color: Colors.white)),
              ),
            ],
          )),
    );
  }
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      _showDialog(name: _nameController.text);

      print('Name: ${_nameController.text}',);
      print('PhoneNumber: ${_phoneNumberController.text}');
      print('Email: ${_emailController.text}');
      print('Country: ${_selectedCountry}');
      print('Password: ${_passwordController.text}');
      print('ConfirmPassword: ${_confirmpasswordController.text}');
      print('Job: ${_jobController.text}');
    } else {
      _showMessage(message: 'Form is not valid! Please review and correct');
    }
  }

  String? _validateName(String? value) {
    final _nameExp = RegExp(r'^[A-Za-z ]+$');
    if (value == null) {
      return 'Name is reqired.';
    } else if (!_nameExp.hasMatch(value)) {
      return 'Please enter alphabetical characters.';
    } else {
      return null;
    }
  }

  bool _validatePhoneNumber(String input) {
    final _phoneExp = RegExp(r'^\(\d\d\d\)\d\d\d\-\d\d\-\d\d$');
    return _phoneExp.hasMatch(input);
  }

  String? _validateEmail(String? value) {
    if (value == null) {
      return 'Email cannot be empty';
    } else if (!_emailController.text.contains('@')) {
      return 'Invalid email address';
    } else {
      return null;
    }
  }

  String? _validatePassword(String? value) {
    if (_passwordController.text.length<3) {
      return '3-12 character required for password';
    } else if (_confirmpasswordController.text != _passwordController.text) {
      return 'Password does not match';
    } else {
      return null;
    }
  }



void _showMessage ({required String message}) {
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    duration: Duration(seconds: 4),
    backgroundColor: Colors.red,
    content: Text(message, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600,
    fontSize: 25),),),
);
}


void _showDialog ({required String name}) {
  showDialog(context: context,
  builder: (context) {
    return AlertDialog(
      title: Text('Register successful'),
      content: Text(
        '$name is now a verified register form',
        style: TextStyle(fontWeight: FontWeight.w700,
        fontSize: 18.0),
      ),
      actions: [
        FlatButton(onPressed: () {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) => UserInfo(newUser),),);
        }, 
        child: 
        Text('Verified!', style: TextStyle(color: Colors.green, fontSize: 25),))
      ],
    );
  }); 
}
}
