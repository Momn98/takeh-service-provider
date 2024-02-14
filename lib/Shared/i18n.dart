import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class S implements WidgetsLocalizations {
  const S();

  static S current = S();

  static const GeneratedLocalizationsDelegate delegate =
      GeneratedLocalizationsDelegate();

  @override
  TextDirection get textDirection => TextDirection.ltr;

  String get appName => 'Takeh';
  String get tapBackAgain => 'Tap back again to exit';
  String get logIn => 'Log In';
  String get signUp => 'Sign Up';
  String get continueGuest => 'Continue Guest';
  String get loginToYourAccount => 'Login To Your Account';
  String get registrationYourAccount => 'Registration Your Account';

  String get jordan => 'Jordan';
  // String get syria => 'Syria';

  String get phoneNumber => 'Phone Number';
  String get phoneNumberNotValid => 'Phone Number Not Valid';
  String get thisFieldRequired => 'This Field Required';
  String get pleaseUpdateApp => 'Please Update App';

  String get home => 'Home';
  String get scan => 'Scan';
  String get support => 'Support';
  String get orders => 'Orders';
  String get profile => 'Profile';

  String get qrCode => 'Qr Code';
  String get myOrders => 'My Orders';

  //
  String get shareApp => 'Share App';
  String get account => 'Account';
  String get settings => 'Settings';
  String get aboutApp => 'About App';
  String get signOut => 'Sign Out';
  String get termsAndCondition => 'Terms & Condition';

  String get shareAppNow => 'Share The App Now';
  String get personalInformation => 'Personal Information';

  String get takeImage => 'Take Image';
  String get gallery => 'Gallery';
  String get camera => 'Camera';
  String get cancel => 'Cancel';
  String get done => 'Done';
  String get fName => 'First Name';
  String get lName => 'Last Name';

  String get weWillNeverShareYourData =>
      'We will not share your personal information, and will use it solely to personalize your experience in this app.';

  String get notifications => 'Notifications';
  String get language => 'Language';
  String get contactUs => 'Contact Us';
  String get privacyPolicy => 'Privacy Policy';
  String get deleteAccount => 'Delete Account';
  //
  String get noNotificationsHere => 'No Notifications Here';
  String get selectLanguage => 'Select Language';
  String get pleaseSelectYourPreferredLanguage =>
      'Please Select Your Preferred Language';

  String get mobileNumber => 'Mobile Number';
  String get email => 'Email';
  String get followUsOn => 'Follow Us On';
  String get moreInfoAboutApp => 'More Info About App';
  String get confirm => 'Confirm';

  String get theDelete => 'Delete Account';

  String get deleteThisAccount => 'Delete this account';
  String get doYouWantToDeleteThisAccount =>
      'Do you want to delete this account?';

  String get deleteParagraph =>
      'Delete your account only if you\'re certain you want to.\nYou will lose all of your prior data if you delete this account.\nThe erased data cannot be used to log into the application again.\nTo use Takeh application, you have to sign up for a new account.\nDue to the fact that it will be permanently removed from our server.\n\n\nIf you need assistance.';
  String get deleteEmail => 'info@takeh.com';
  String get deletePhone => '+962782562016';
  String get doYouWantToContinue => 'Do you want to continue?';
  String get confirmDeleteThisAccount => 'Confirm delete this account';
  String get yes => 'Yes';
  String get no => 'No';
  String get version => 'Version';
  String get copyright => 'Copyright';
  String get allRightsReserved => 'All Rights Reserved';

  String get sorryYourAccountBlocked => 'Sorry Your Account Blocked';
  String get pleaseContactUsToRemoveBlock =>
      'Please Contact Us To Remove Block';

  String get pleaseWait => 'Please Wait';

  String get resendCode => 'Resend Code';
  String get otpVerification => 'OTP Verification';
  String get codeHasBeenSentTo => 'Code Has Been Sent To';
  String get pleaseEnterTheCorrectOtpSentTo =>
      'Please Enter The Correct OTP Sent To';
  String get acceptTerms1 => 'Accept';
  String get acceptTerms2 => 'Terms & condition';

  String get pleaseAcceptTerms => 'Please, Accept Terms and Condition';

  String get enterValidName => 'Enter Valid Name';
  String get updated => 'Updated';

  String get searchForAddress => 'Search For Address';
  String get loading => 'Loading';
  String get searchForYourAddress => 'Search For Your Address';
  String get location => 'Location';
  String get deliverHere => 'Deliver Here';
  String get locationHere => 'Location Here';
  String get skip => 'Skip';

  // String get uploadFrontID => 'Upload Front ID';
  String get uploadFrontVehicle => 'Upload Vehicle Number Front';
  // String get uploadBackID => 'Upload Back ID';
  String get uploadBackVehicle => 'Upload Vehicle Number Back';
  // String get selectFrontID => 'Select Front ID';
  String get selectFrontVehicle => 'Select Vehicle Number Front';
  // String get selectBackID => 'Select Back ID';
  String get selectBackVehicle => 'Select Vehicle Number Back';

  String get uploadFrontDriverLicense => 'Upload Front Driver License';
  String get uploadBackDriverLicense => 'Upload Back Driver License';
  String get selectFrontDriverLicense => 'Select Front Driver License';
  String get selectBackDriverLicense => 'Select Back Driver License';

  String get uploadFrontCarLicense => 'Upload Front Car License';
  String get uploadBackCarLicense => 'Upload Back Car License';
  String get selectFrontCarLicense => 'Select Front Car License';
  String get selectBackCarLicense => 'Select Back Car License';

  String get newOrder => 'New Order';
  String get accept => 'Accept';
  String get time => 'Time';

  String get yourAccountPending => 'Your Account Pending';
  String get pleaseContactUsToActivateYouAccount =>
      'Please Contact Us To Activate You Account';
  String get theReasonOfCancelOrder => 'The Reason Of Cancel Order';
  String get thisFieldIsRequired => 'This Field Is Required';
  String get hello => 'Hello';
  String get addYourDetailsToUseOurApp => 'Add Your Details,\nTo Use Our App';

  String get pleaseRate => 'Please Rate';
  String get rateTheCustomer => 'Rate The Customer';
  String get howIsTheCustomer => 'How Is The Customer';
  String get confirmCancelOrder => 'Confirm Cancel Order';

  String get cancelTheOrder => 'Cancel The Order';
  String get confirmCancelTheOrder => 'Confirm Cancel The Order';

  String get goToCustomer => 'Go To Customer';
  String get arivedToCustomer => 'Arived To Customer';
  String get startOrder => 'Start Order';
  String get confirmStartRide => 'Confirm Start Start';
  String get finishOrder => 'Finish Order';
  String get confirmFinishRide => 'Confirm Finish Ride';
  String get map => 'Map';
  String get findingOrder => 'Finding Order';
  // String get cancel => 'Cancel';

  String get jd => 'JD';
  String get addYourNumberWeWillSendYouOtpCode =>
      'add your number,\nwe will send you otp code';
  String get readOurPrivacyPolicy =>
      'Read our privacy policy, click on okay and continue for the terms and conditions';
  String get okayAndContinue => 'okay and continue';
  String get chickPhoneNumber => 'Chick Phone Number';
  String get weWillChickThisPhoneNumber => 'we will chick this phone number';
  String get isPhoneNumberCorrect =>
      'is phone number correct? or want to change it?';
  String get trueContinue => 'true & continue';
  String get aSmartUserHasJustDownloaded =>
      'a smart user has just downloaded\nour app. Excellent!';
  String get selectYourCountry => 'Select your country';
  String get welcome => 'Welcome :)';
  String get getStarted => 'Let\'s Get Started';
  String get Continue => 'continue';
  String get selectYourCity => 'Select your City';
  String get selectYourWorkService => 'Select Your Work Service';

  String get orderNumber => 'Order Number';
  String get activeOrder => 'Active Order';
  String get historyOrders => 'History Orders';
  String get canceledOrders => 'Canceled Orders';
  String get orderID => 'Order ID';
  String get service => 'Service :';
  String get noOrders => 'No Orders';
  String get discountedAmount => 'Discounted Amount';
  String get paidCash => 'paid Cash';
  String get paidWallet => 'paid Wallet';
  String get thankYouForContactingUs =>
      'Thank you for contacting us, you will be transferred on WhatsApp for direct communication. Official working hours are from 9:00 am - 5:00 pm. Your message will be answered within 24 hours.';

  String get showBalance => 'Show Balance';
  String get availableBalance => 'Available Balance';
  String get userNotFound => 'User Not Found';
  String get phoneNumberNotRejecteredWithAnyUser =>
      'Phone number not Registerd with any user, please sign up to use our app';

  String get pleaseEnableLocationService =>
      'Please Enable location service to find the nearest customer to your location';
  String get appNeedsAccessToYourDevicesLocation =>
      'Takeh needs access to your device location in order to provide accurate customer and ensure a seamless navigation experience. We will only collect and use your location data while the app is running in the background. \nThis allows us to match you with the nearest available customer';
  String get pleaseSelectWorkOption => 'Please Select Work Option';

  String get contactUsTextLong =>
      'Thank you for contacting us, you will be transferred on WhatsApp for direct communication. Official working hours are from 9:00 am - 5:00 pm. Your message will be answered within 24 hours.';
  String get back => 'Back';
  String get password => 'Password';

  //
  String get clickToStartWork => 'You Are Not Active';
  String get clickToTakeBreak => 'You Are Active Now';
  String get min => 'Min';
  String get km => 'Km';
  String get finish => 'Finish';

  //
  String get type => 'Car Type';
  String get model => 'Car Model';
  String get year => 'Car Year';
  String get carNumber => 'Car Number';
  String get carColor => 'Car Color';

  String get pleaseUploadPersonalImage => 'Please Upload Personal Image';

  //
  //
  //
  String get close => 'Close';
  String get noEnoughCashInWalletPleaseRecharge =>
      'No Enough Cash In Wallet, Please Recharge';
  String get required => 'Required';
  String get pleaseAddImage => 'Please Add Image';
  String get cancelReason => 'Cancel Reason';

  String get other => 'Other';
  String get reason1 => 'The Customer Is Late';
  String get reason2 => 'The Customer Does Not Answer His Phone';
  String get reason3 => 'Customer Not Found';

  //
  String get noTransactions => 'No Transactions';
  String get transactionID => 'Transaction ID';
  String get theAmount => 'The Amount';
  String get date => 'Date';

  String get reorderItemDown => throw UnimplementedError();
  String get reorderItemLeft => throw UnimplementedError();
  String get reorderItemRight => throw UnimplementedError();
  String get reorderItemToEnd => throw UnimplementedError();
  String get reorderItemToStart => throw UnimplementedError();
  String get reorderItemUp => throw UnimplementedError();
}

class $ar extends S {
  const $ar();

  @override
  TextDirection get textDirection => TextDirection.rtl;

  @override
  String get appName => 'تكة';
  @override
  String get tapBackAgain => 'انقر مرة اخرى للخروج';
  @override
  String get logIn => 'تسجيل الدخول';
  @override
  String get signUp => 'تسجيل';
  @override
  String get continueGuest => 'الدخول كزائر';
  @override
  String get loginToYourAccount => 'تسجيل الدخول الى الحساب';
  @override
  String get registrationYourAccount => 'تسجيل حسابك';
  @override
  String get jordan => 'الاردن';
  // @override
  // String get syria => 'سوريا';
  @override
  String get phoneNumber => 'رقم الهاتف';
  @override
  String get phoneNumberNotValid => 'رقم الهاتف غير صحيح';
  @override
  String get thisFieldRequired => 'هذا الحقل مطلوب';
  @override
  String get pleaseUpdateApp => 'الرجاء تحديث التطبيق';
  @override
  String get home => 'الرئيسية';
  @override
  String get scan => 'مسح';
  @override
  String get support => 'الدعم';
  @override
  String get orders => 'الطلبات';
  @override
  String get profile => 'الحساب';
  @override
  String get qrCode => 'رمز الرقمي';
  @override
  String get myOrders => 'طلباتي';
  @override
  String get shareApp => 'مشاركة التطبيق';
  @override
  String get account => 'الحساب';
  @override
  String get settings => 'الاعدادات';
  @override
  String get aboutApp => 'عن التطبيق';
  @override
  String get signOut => 'تسجيل الخروج';
  @override
  String get termsAndCondition => 'الشروط و الاحكام';
  @override
  String get shareAppNow => 'مشاركة التطبيق الآن';
  @override
  String get personalInformation => 'معلوماتك الشخصية';
  @override
  String get takeImage => 'التقاط الصورة';
  @override
  String get gallery => 'المعرض';
  @override
  String get camera => 'الكاميرا';
  @override
  String get cancel => 'الغاء';
  @override
  String get done => 'تم';
  @override
  String get fName => 'الاسم الاول';
  @override
  String get lName => 'اسم العائلة';
  @override
  String get weWillNeverShareYourData =>
      'لن نشارك معلوماتك الشخصية ، وسنستخدمها فقط لتخصيص تجربتك في هذا التطبيق.';
  @override
  String get notifications => 'الاشعارات';
  @override
  String get language => 'اللغة';
  @override
  String get contactUs => 'تواصل معنا';
  @override
  String get privacyPolicy => 'السياسة والخصوصية';
  @override
  String get deleteAccount => 'حذف الحساب';
  @override
  String get noNotificationsHere => 'لا يوجد اشعارات';
  @override
  String get selectLanguage => 'أختر اللغة';
  @override
  String get pleaseSelectYourPreferredLanguage => 'يرجى تحديد لغتك المفضلة';
  @override
  String get mobileNumber => 'رقم الهاتف';
  @override
  String get email => 'الايميل';
  @override
  String get followUsOn => 'تابعنا هنا';
  @override
  String get moreInfoAboutApp => 'المزيد من المعلومات عن التطبيق';
  @override
  String get confirm => 'تأكيد';
  @override
  String get theDelete => 'حذف الحساب';
  @override
  String get deleteThisAccount => 'حذف هذا الحساب';
  @override
  String get doYouWantToDeleteThisAccount => 'هل تريد حذف هذا الحساب؟';
  @override
  String get deleteParagraph =>
      'احذف حسابك فقط إذا كنت متأكدًا من رغبتك في ذلك , ستفقد جميع بياناتك السابقة إذا قمت بحذف هذا الحساب, لا يمكن استخدام البيانات التي تم مسحها لتسجيل الدخول إلى التطبيق مرة أخرى,  لاستخدام تطبيق Takeh ، يجب عليك التسجيل للحصول على حساب جديد, نظرًا لحقيقة أنه سيتم إزالته نهائيًا من الخادم الخاص بنا إذا كنت بحاجة إلى المساعدة.';
  @override
  String get deleteEmail => 'info@takeh.com';
  @override
  String get deletePhone => '+962782562016';
  @override
  String get doYouWantToContinue => 'هل تريد الاستمرار؟';
  @override
  String get confirmDeleteThisAccount => 'تأكيد حذف هذا الحساب';
  @override
  String get yes => 'نعم';
  @override
  String get no => 'لا';
  @override
  String get version => 'الاصدار';
  @override
  String get copyright => 'Copyright';
  @override
  String get allRightsReserved => 'جميع الحقوق محفوظة';
  @override
  String get sorryYourAccountBlocked => 'عذراً حسابك محظور';
  @override
  String get pleaseContactUsToRemoveBlock => 'الرجاء التواصل معنا لإزالة الحظر';
  @override
  String get pleaseWait => 'الرجاء الانتظار';
  @override
  String get resendCode => 'اعادة ارسال الرمز';
  @override
  String get otpVerification => 'رمز التحقق';
  @override
  String get codeHasBeenSentTo => 'تم ارسال الرمز الى';
  @override
  String get pleaseEnterTheCorrectOtpSentTo =>
      'الرجاء ادخال رمز التحقق المرسل الى';
  @override
  String get acceptTerms1 => 'موافقة';
  @override
  String get acceptTerms2 => 'الشروط والاحكام';
  @override
  String get pleaseAcceptTerms => 'الرجاء، الموافقة على الشروط و الحكام';
  @override
  String get enterValidName => 'ادخل اسم صحيح';
  @override
  String get updated => 'تم التعديل';
  @override
  String get searchForAddress => 'البحث عن عنوان';
  @override
  String get loading => 'تحميل';
  @override
  String get searchForYourAddress => 'ابحث عن عنوانك';
  @override
  String get location => 'الموقع';
  @override
  String get deliverHere => 'التوصيل هنا';
  @override
  String get locationHere => 'الموقع هنا';
  @override
  String get skip => 'تخطى';
  @override
  String get uploadFrontVehicle => 'تحميل لوحة المركبة من الامام';
  // String get uploadFrontID => 'تحميل الهوية من الامام';
  @override
  String get uploadBackVehicle => 'تحميل لوحة المركبة من الخلف';
  // String get uploadBackID => 'تحميل الهوية من الخلف';
  @override
  String get selectFrontVehicle => 'اختيار لوحة المركبة من الامام';
  // String get selectFrontID => 'اختيار الهوية من الامام';
  @override
  String get selectBackVehicle => 'اختيار لوحة المركبة من الخلف';
  // String get selectBackID => 'اختيار الهوية من الخلف';
  @override
  String get uploadFrontDriverLicense => 'تحميل رخصة السائق من الامام';
  @override
  String get uploadBackDriverLicense => 'تحميل رخصة السائق من الخلف';
  @override
  String get selectFrontDriverLicense => 'اختيار رخصة السائق من الامام';
  @override
  String get selectBackDriverLicense => 'اختيار رخصة السائق من الخلف';
  @override
  String get uploadFrontCarLicense => 'تحميل رخصة المركبة من الامام';
  @override
  String get uploadBackCarLicense => 'تحميل رخصة المركبة من الخلف';
  @override
  String get selectFrontCarLicense => 'اختيار رخصة المركبة من الامام';
  @override
  String get selectBackCarLicense => 'اختيار رخصة المركبة من الخلف';
  @override
  String get newOrder => 'طلب جديد';
  @override
  String get accept => 'موافق';
  @override
  String get time => 'الوقت';
  @override
  String get yourAccountPending => 'حسابك معلق';
  @override
  String get pleaseContactUsToActivateYouAccount =>
      'يرجى الاتصال بنا لتفعيل حسابك';
  @override
  String get theReasonOfCancelOrder => 'سبب إلغاء الطلب';
  @override
  String get thisFieldIsRequired => 'هذه الخانة مطلوبه';
  @override
  String get hello => 'مرحباً';
  @override
  String get addYourDetailsToUseOurApp =>
      'أضف التفاصيل الخاصة بك ، لاستخدام التطبيق لدينا';

  @override
  String get pleaseRate => 'الرجاء التقييم';
  @override
  String get rateTheCustomer => 'تقييم الزبون';
  @override
  String get howIsTheCustomer => 'كيف كانت معاملت الزبون';
  @override
  String get confirmCancelOrder => 'تأكيد الغاء الطلب';

  @override
  String get cancelTheOrder => 'الغاء الطلب';
  @override
  String get confirmCancelTheOrder => 'تأكيد الغاء الطلب';

  @override
  String get goToCustomer => 'الذهاب الى العميل';
  @override
  String get arivedToCustomer => 'الوصول الى العميل';
  @override
  String get startOrder => 'بدء الطلب';
  @override
  String get confirmStartRide => 'تأكيد بدأ الطلب';
  @override
  String get finishOrder => 'انهاء الطلب';
  @override
  String get confirmFinishRide => 'تأكيد انهاء الطلب';
  @override
  String get map => 'الخريطة';
  @override
  String get findingOrder => 'البحث عن طلبات';
  // @override
  // String get cancel => 'الغاء';
  @override
  String get jd => 'د.أ';
  @override
  String get addYourNumberWeWillSendYouOtpCode =>
      'أضف رقمك ،  سنرسل لك رمز otp';
  @override
  String get readOurPrivacyPolicy =>
      'اقرأ سياسة الخصوصية الخاصة بنا ، وانقر فوق موافق وتابع للشروط والأحكام';
  @override
  String get okayAndContinue => 'الموافقة و الاستمرار';
  @override
  String get chickPhoneNumber => 'التأكد من رقم الهاتف';
  @override
  String get weWillChickThisPhoneNumber => 'سوف نتحقق من رقم الهاتف هذا';
  @override
  String get isPhoneNumberCorrect => 'هل رقم الهاتف صحيح؟ أو تريد تغييره؟';
  @override
  String get trueContinue => 'صحيح ,الاستمرار';
  @override
  String get aSmartUserHasJustDownloaded =>
      'قام مستخدم ذكي بتنزيل  تطبيقنا للتو, ممتاز!';
  @override
  String get selectYourCountry => 'اختيار البلد';
  @override
  String get welcome => 'مرحباً :)';
  @override
  String get getStarted => 'هيا بنا نبدأ';
  @override
  String get Continue => 'استمرار';
  @override
  String get selectYourCity => 'اختر المدينة';
  @override
  String get selectYourWorkService => 'حدد خدمة عملك';

  @override
  String get orderNumber => 'رقم الطلب';
  @override
  String get activeOrder => 'الطلبات الفعالة';
  @override
  String get historyOrders => 'الطلبات السابقة';
  @override
  String get canceledOrders => 'الطلبات الملغية';
  @override
  String get orderID => 'رقم الطلب';
  @override
  String get service => 'الخدمة :';
  @override
  String get noOrders => 'لا يوجد طلبات';
  @override
  String get thankYouForContactingUs =>
      'شكرا لتواصلك معنا ، سيتم نقلك على WhatsApp للتواصل المباشر, ساعات العمل الرسمية من 9:00 ص - 5:00 م. سيتم الرد على رسالتك في غضون 24 ساعة.';

  @override
  String get showBalance => 'مشاهدة الرصيد';
  @override
  String get availableBalance => 'الرصيد المتاح';
  @override
  String get userNotFound => 'المستخدم غير موجود';
  @override
  String get phoneNumberNotRejecteredWithAnyUser =>
      'رقم الهاتف غير مسجل مع أي مستخدم ، يرجى التسجيل لاستخدام التطبيق لدينا';

  @override
  String get pleaseEnableLocationService =>
      'يرجى تمكين خدمة الموقع للعثور على أقرب عميل لموقعك';
  @override
  String get appNeedsAccessToYourDevicesLocation =>
      'يحتاج Takeh إلى الوصول إلى موقع جهازك من أجل توفير عميل دقيق وضمان تجربة تنقل سلسة, سنقوم فقط بجمع واستخدام بيانات موقعك أثناء تشغيل التطبيق في الخلفية, هذا يسمح لنا بمطابقتك مع أقرب عميل متاح';
  @override
  String get pleaseSelectWorkOption => 'الرجاء تحديد خيار العمل';
  @override
  String get contactUsTextLong =>
      'شكرا لتواصلك معنا ، سيتم نقلك على WhatsApp للتواصل المباشر. ساعات العمل الرسمية من 9:00 ص - 5:00 م. سيتم الرد على رسالتك في غضون 24 ساعة.';
  @override
  String get back => 'الرجوع';
  @override
  String get password => 'كلمة المرور';
  @override
  String get clickToStartWork => 'أنت الآن غير متصل';
  @override
  String get clickToTakeBreak => 'أنت متصل الآن';
  @override
  String get finish => 'انهاء';

  @override
  String get type => 'نوع السيارة';
  @override
  String get model => 'موديل السيارة';
  @override
  String get year => 'سنة السيارة';
  @override
  String get carNumber => 'رقم السياره';
  @override
  String get carColor => 'لون السيارة';

  @override
  String get pleaseUploadPersonalImage => 'يرجى تحميل الصورة الشخصية';

  @override
  String get close => 'اغلاق';
  @override
  String get noEnoughCashInWalletPleaseRecharge => 'لا يوجد لديك رصيد كافي';

  @override
  String get required => 'مطلوب';
  @override
  String get pleaseAddImage => 'الرجاء إضافة الصورة';
  @override
  String get cancelReason => 'سبب الإلغاء';

  @override
  String get other => 'أخرى';
  @override
  String get reason1 => 'تأخر العميل';
  @override
  String get reason2 => 'العميل لا يرد على هاتفه';
  @override
  String get reason3 => 'العميل غير موجود';

  @override
  String get discountedAmount => 'قيمة الخصم';
  @override
  String get paidCash => 'دفع نقداَ';
  @override
  String get paidWallet => 'دفع عبر المحفظة';
  @override
  String get noTransactions => 'لا يوجد حركات مالية';
  @override
  String get transactionID => 'رقم الحركة المالية';
  @override
  String get theAmount => 'المبلغ';
  @override
  String get date => 'تاريخ';
}

class $en extends S {
  const $en();
}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<S> {
  const GeneratedLocalizationsDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale('ar', ''),
      Locale('en', ''),
    ];
  }

  //
  //
  //
  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<S> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    final String lang = getLang(locale);

    switch (lang) {
      case 'ar':
        S.current = const $ar();
        return SynchronousFuture<S>(S.current);
      //
      case 'en':
        S.current = const $en();
        return SynchronousFuture<S>(S.current);
      default:
      // NO-OP.
    }

    S.current = const S();
    return SynchronousFuture<S>(S.current);
  }

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => false;
}

String getLang(Locale l) => l.languageCode;
