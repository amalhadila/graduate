import 'package:flutter/material.dart';
import 'package:graduation/auth/cach/cach_helper.dart';
import 'package:graduation/auth/core_login/api/end_point.dart';
import 'package:graduation/constants.dart';
import 'package:graduation/features/create_tour.dart/presentation/model/get_all_landmarks_by_govern_model.dart';
import 'package:graduation/features/create_tour.dart/presentation/views/widgets/landmarkdetails.dart';
import 'package:graduation/features/create_tour.dart/presentation/views/widgets/user_lang.dart';
import 'package:dio/dio.dart';
import 'package:graduation/features/landmarks/data/model/landmark_on_cat_model/landmark_on_cat_model.dart';
import 'package:graduation/features/landmarks/presentation/views/info_view.dart';

class LandmarkSelectionScreen extends StatefulWidget {
  final String selectedGovernorate;

  const LandmarkSelectionScreen({Key? key, required this.selectedGovernorate})
      : super(key: key);

  @override
  State<LandmarkSelectionScreen> createState() =>
      _LandmarkSelectionScreenState();
}

class _LandmarkSelectionScreenState extends State<LandmarkSelectionScreen> {
  final _selectedLandmarksNotifier = ValueNotifier<List<Landmark>>([]);

  Future<GetAllLandmarksByGovernModel> getAllLandMarksByGovern(
      BuildContext context, String governorate) async {
    final Dio _dio = Dio();
    try {
      var response = await _dio.get(
          'http://192.168.1.4:8000/api/v1/customizedTour/landmarks/$governorate',
          options: Options(
            headers: {
              'Authorization':
                  'Bearer ${Token}',
            },
          ));
      GetAllLandmarksByGovernModel getAllGovernsModel =
          GetAllLandmarksByGovernModel.fromJson(response.data);
      return getAllGovernsModel;
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Operation Failed"),
          content: Text("An error happened $e, please try again"),
        ),
      );
      throw e; // You may choose to throw the error here or handle it differently
    }
  }

  void addLandmark(Landmark landmark) {
    _selectedLandmarksNotifier.value = [..._selectedLandmarksNotifier.value, landmark];
  }

  void removeLandmark(Landmark landmark) {
    _selectedLandmarksNotifier.value =
        _selectedLandmarksNotifier.value.where((l) => l != landmark).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'What do you want to see?',
          style: TextStyle(color: kmaincolor, fontSize: 19, fontWeight: FontWeight.w700),
        ),
        backgroundColor: kbackgroundcolor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: kmaincolor,
            size: 22,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: 16.0),
            Expanded(
              child: FutureBuilder<GetAllLandmarksByGovernModel>(
                future: getAllLandMarksByGovern(context, widget.selectedGovernorate),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.data.landmarks.isEmpty) {
                    return Center(child: Text('No landmarks found'));
                  } else {
                    final landmarks = snapshot.data!.data.landmarks;
                    return ListView.builder(
                      itemCount: landmarks.length,
                      itemBuilder: (context, index) {
                        final landmark = landmarks[index];
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: shadow,
                          ),
                          child: ListTile(
                            onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Landmarkdetails(
                                
                                
                                name: landmark.name,
                                description: landmark.description,
                                images: landmark.images
                                // Add other necessary fields here
                              ),
                            ),
                          
                        );},
                     
                            leading: const CircleAvatar(
                              backgroundColor: Colors.grey,
                              child: Icon(Icons.location_on, color: Colors.white),
                            ),
                            title: Text(landmark.name, style: TextStyle(color: ksecondcolor)),
                            subtitle: Text(
    landmark.description.length > 100 
        ? landmark.description.substring(0, 100) + '...' 
        : landmark.description,
                              style: TextStyle(color: neutralColor2),
                            ),
                            trailing: IconButton(
                              icon: ValueListenableBuilder(
  valueListenable: _selectedLandmarksNotifier,
  builder: (context, value, child) {
    return _selectedLandmarksNotifier.value.contains(landmark)
       ? Icon(Icons.check_circle, color: ksecondcolor)
        : Icon(Icons.circle_outlined, color: ksecondcolor);
  },
),
                              onPressed: () {
                                print('Button pressed'); 
                                if (_selectedLandmarksNotifier.value.contains(landmark)) {
                                  removeLandmark(landmark);
                                } else {
                                  addLandmark(landmark);
                                }
                              },
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 80),
              child: ElevatedButton(
  onPressed: () {
    if (_selectedLandmarksNotifier.value.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectedLandmarksScreen(
            selectedGovernorate: widget.selectedGovernorate,
            selectedLandmarks: _selectedLandmarksNotifier.value,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select at least one landmark'),
        ),
      );
    }
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: kmaincolor,
    minimumSize: Size.fromHeight(48),
  ),
  child: const Text('Next',
      style: TextStyle(
          color: kbackgroundcolor,
          fontWeight: FontWeight.bold,
          fontSize: 17)),
),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectedLandmarksScreen extends StatefulWidget {
  final String selectedGovernorate;
  final List<Landmark> selectedLandmarks;

  const SelectedLandmarksScreen({
    super.key,
    required this.selectedGovernorate,
    required this.selectedLandmarks,
  });

  @override
  _SelectedLandmarksScreenState createState() =>
      _SelectedLandmarksScreenState();
}

class _SelectedLandmarksScreenState extends State<SelectedLandmarksScreen> {
  void removeLandmark(Landmark landmark) {
    setState(() {
      widget.selectedLandmarks.remove(landmark);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: kmaincolor,
            size: 22,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: kbackgroundcolor,
        title: Text(
          'This is what you chose',
         style: TextStyle(color: kmaincolor,fontSize: 19,fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.selectedLandmarks.length,
                itemBuilder: (context, index) {
                  final landmark = widget.selectedLandmarks[index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: shadow,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.location_on, color: Colors.white),
                      ),
                      title: Text(landmark.name,style: TextStyle(color: kmaincolor,fontSize: 16,fontWeight: FontWeight.w700),),
                      trailing: TextButton(
                        onPressed: () {
                          removeLandmark(landmark);
                        },
                        child: Text(
                          'delete',
                          style: TextStyle(
                              color: kmaincolor, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 80),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LanguageSelectionScreen(
                        selectedGovernorate: widget.selectedGovernorate,
                        landmarks: widget.selectedLandmarks,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kmaincolor,
                  minimumSize: Size.fromHeight(48),

                ),
                child: const Text('Next',
                    style: TextStyle(
                        color: kbackgroundcolor,
                        fontWeight: FontWeight.bold,
                        fontSize: 17)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
