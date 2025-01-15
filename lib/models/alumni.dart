class Alumni {
  final String name, email, occupation, degree, department, yearOfGraduation;
  final int? id;

  Alumni({required this.name, required this.email, required this.occupation, required this.degree, required this.department, required this.yearOfGraduation, required this.id});
  
  Alumni.dummy({required this.id}):
    name = 'Nwabuike John',
    email = 'Nwabuike@gmail.com',
    occupation = 'Chief Executive Officer, Nitel',
    degree = 'B.Engr',
    department = 'Electronic & Computer Engineering',
    yearOfGraduation = '2022/2023';


}