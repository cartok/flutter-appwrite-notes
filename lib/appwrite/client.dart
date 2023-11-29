import 'package:appwrite/appwrite.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// TODO: I should wrap all appwrite requests to catch rate limit execptions. Is it also a problem
// when self hosted? Propably not, only for hackers or If I have bugs. But I should get alerted.
//
// After a few logins and logouts I was permanently locked out:
//   AppwriteException (AppwriteException: general_rate_limit_exceeded, Rate limit for the current
//   endpoint has been exceeded. Please try again after some time. (429))

Client client = Client()
    .setEndpoint('https://cloud.appwrite.io/v1')
    .setProject(dotenv.get('PROJECT_ID'))
    .setSelfSigned(
      status: true,
    );
