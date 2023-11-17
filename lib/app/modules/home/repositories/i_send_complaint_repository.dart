import 'dart:io';

import 'package:sentinela/app/core/fp/either.dart';
import 'package:sentinela/app/core/fp/nil.dart';
import 'package:sentinela/app/modules/home/exceptions/send_repository_exception_location.dart';

abstract interface class ISendComplaintRepository {
  Future<Either<SendComplaintRepositoryException, Nil>> sendComplaintByAddres(
      String title, String description, String address, File image);
  Future<Either<SendComplaintRepositoryException, Nil>>
      sendComplaintByLatitudeAndLongitude(
          String title, String description, File image);
}
