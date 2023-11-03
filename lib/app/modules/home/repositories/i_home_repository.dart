import 'package:sentinela/app/core/models/complaint_model.dart';
import 'package:sentinela/app/modules/home/exceptions/home_repository_exception.dart';

import '../../../core/fp/either.dart';

abstract interface class IHomeRepository {
  Future<Either<HomeRepositoryException, List<ComplaintModel>>>
      getAllComplaint();
}
