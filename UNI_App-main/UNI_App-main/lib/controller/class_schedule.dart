import 'package:uni/model/entities/class_info.dart';

List getClassScheduleList() {
  return getClassScheduleListMock();
}

List getClassSchedule(var className) {
  return getClassScheduleMock();
}

List getClassScheduleListMock() {
  return [
    'Engenharia de Software',
    'Desenho de Algoritmos',
    'Laboratório de Computadores',
    'Sistemas Operativos',
    'Linguagens e Tecnologias Web',
  ];
}

List getClassScheduleMock() {
  return [
    ClassInfo(2, 'LC', 'DCC-PMAB + PFS', 'B014', 'COMP2313', 'T', 484426,
        5945807, 2, 59400),
    ClassInfo(
        3, 'ES', 'BMCL', 'B307', '3LEIC06', 'TP', 484425, 5945849, 2, 37800),
    ClassInfo(
        3, 'LC', 'PFS', 'B311', '2LEIC10', 'PL', 484426, 5945778, 2, 50400),
    ClassInfo(
        3, 'SO', 'CB', 'B220', '2LEIC01', 'TP', 484378, 5945893, 2, 64800),
    ClassInfo(4, 'LTW', 'AOR + DCC-JPL', 'B002', 'COMP_2313', 'T', 484427,
        5945826, 2, 32400),
    ClassInfo(4, 'Engenharia de Software', 'ASL', 'B115', '3LEIC01', 'T', 0, 0,
        2, 6500),
    ClassInfo(4, 'Engenharia de Software', 'ASL', 'B310', '3LEIC04', 'T', 0, 0,
        1, 3500),
    ClassInfo(5, 'Engenharia de Software', 'AMA+JPF', 'B003', 'COMP3315', 'T',
        0, 0, 2, 3000),
    ClassInfo(5, 'Engenharia de Software', 'AMA+JPF', 'B010', 'COMP2310', 'T',
        484425, 5945818, 2, 30600),
    ClassInfo(6, 'Engenharia de Software', 'HSF', 'B202', 'COMP2308', 'TP', 0,
        0, 2, 4300),
    ClassInfo(6, 'Engenharia de Software', 'AMA', 'B204', 'COMP2317', 'TP', 0,
        0, 2, 6000),
    ClassInfo(6, 'Engenharia de Software', 'AMA', 'B314', '2LEIC02', 'TP', 0, 0,
        2, 5000),
    ClassInfo(6, 'Engenharia de Software', 'DRP', 'B306', 'COMP2309', 'TP', 0,
        0, 1, 4000),
  ];
}
