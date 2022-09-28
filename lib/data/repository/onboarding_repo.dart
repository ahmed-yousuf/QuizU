import 'package:get/get.dart';
import 'package:quizu/data/model/onboarding_model.dart';
import 'package:quizu/util/images.dart';

class OnBoardingRepo {
  Future<Response> getOnBoardingList() async {
    try {
      List<OnBoardingModel> onBoardingList = [
        OnBoardingModel(Images.onboard_1, 'Test your knowledge',
            'There are thirty different questions to try it.'),
        OnBoardingModel(Images.onboard_2, 'Get knowledge in less time',
            'Test your knowledge in two minutes'),
        OnBoardingModel(Images.onboard_3, 'Compete with friends',
            'Who is the smartest in your group of friends or family?'),
      ];

      Response response = Response(body: onBoardingList, statusCode: 200);
      return response;
    } catch (e) {
      return const Response(
          statusCode: 404, statusText: 'Onboarding data not found');
    }
  }
}
