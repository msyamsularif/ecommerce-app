import 'package:ecommerce_app/core/utils/colors_style.dart';
import 'package:ecommerce_app/models/user_model.dart';
import 'package:ecommerce_app/view_models/auth/auth_cubit.dart';
import 'package:ecommerce_app/views/widget/ct_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfilePage extends StatefulWidget {
  static const String routName = '/edit-profile';
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final AuthCubit _authCubit;
  late UserModel? _userModel;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    _authCubit = context.read<AuthCubit>();
    _userModel = _authCubit.state.user;

    _nameController.text = _userModel?.name ?? '';
    _usernameController.text = _userModel?.username ?? '';
    _emailController.text = _userModel?.email ?? '';
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor3,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Edit Profile'),
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(
            Icons.close,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            splashRadius: 25,
            icon: Icon(
              Icons.check,
              color: primaryColor,
            ),
          ),
        ],
      ),
      body: _content(),
    );
  }

  Widget _content() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(defaultMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: whiteColor,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: _userModel?.profilePhotoUrl == null
                    ? const AssetImage('assets/image_profile.png')
                    : NetworkImage(_userModel!.profilePhotoUrl!)
                        as ImageProvider,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          SizedBox(height: defaultMargin),
          CTTextField.underLineBorder(
            controller: _nameController,
            contentPadding: const EdgeInsets.symmetric(vertical: 4),
            title: 'Name',
            hintText: 'Your Name',
          ),
          const SizedBox(height: 24),
          CTTextField.underLineBorder(
            controller: _usernameController,
            contentPadding: const EdgeInsets.symmetric(vertical: 4),
            title: 'Username',
            hintText: 'Your Username',
          ),
          const SizedBox(height: 24),
          CTTextField.underLineBorder(
            controller: _emailController,
            contentPadding: const EdgeInsets.symmetric(vertical: 4),
            title: 'Email Address',
            hintText: 'Your Email Address',
          ),
        ],
      ),
    );
  }
}
