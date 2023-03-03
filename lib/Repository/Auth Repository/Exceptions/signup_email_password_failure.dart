class SignUpWithEmailAndPasswordFailure {
  final String msg;

  const SignUpWithEmailAndPasswordFailure(
      [this.msg = "An unknown error occurred."]);

  factory SignUpWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
            'Please enter a stronger password.');
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure('Email is not valid.');
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
            'Account with this email already exists.');
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
            'Operation not allowed.');
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
            'User has been disabled.');
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }
}
