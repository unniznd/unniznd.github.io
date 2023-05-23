import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'attendance_event.dart';
import 'attendance_state.dart';
import 'package:prathibha_web/attendance/api/attendace_api.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final AttendanceApiProvider attendanceApiProvider = AttendanceApiProvider();
  AttendanceBloc() : super(AttendanceLoading()) {
    on<FetchAttendance>((event, emit) async {
      emit(AttendanceLoading());
      try {
        final attendanceModel = await attendanceApiProvider.fetchStudentDetails(
          event.branchId,
          event.standard,
          event.division,
          event.q,
          event.statusAttendance,
          event.date,
        );
        if (attendanceModel.errorMsg != null) {
          emit(AttendanceError(errorMsg: attendanceModel.errorMsg!));
        } else {
          emit(AttendanceLoaded(attendanceModel: attendanceModel));
        }
      } catch (e) {
        emit(AttendanceError(errorMsg: e.toString()));
      }
    });
    on<MarkAbsentAttendance>((event, emit) async {
      if (state is AttendanceLoaded) {
        final attendanceModel = (state as AttendanceLoaded).attendanceModel;
        attendanceModel.studentModel![event.index].isMarkingAttendace = true;
        emit(AttendanceLoaded(attendanceModel: attendanceModel));
        final isMarked = await attendanceApiProvider.markAsAbsent(
          event.branchId,
          attendanceModel.studentModel![event.index].admissionNumber,
          event.date,
        );
        attendanceModel.studentModel![event.index].isMarkingAttendace = false;
        if (isMarked) {
          attendanceModel.studentModel![event.index].isAbsent = true;
        } else {
          // ignore: use_build_context_synchronously
          final scaffoldMessenger = ScaffoldMessenger.of(event.context);
          scaffoldMessenger.showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
              width: 700,
              content: Row(
                children: [
                  const HeroIcon(
                    HeroIcons.exclamationCircle,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Failed to mark absent for ${attendanceModel.studentModel![event.index].name}.',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        emit(AttendanceLoaded(attendanceModel: attendanceModel));
      }
    });
    on<MarkPresentAttendance>((event, emit) async {
      if (state is AttendanceLoaded) {
        final attendanceModel = (state as AttendanceLoaded).attendanceModel;
        attendanceModel.studentModel![event.index].isMarkingAttendace = true;
        emit(AttendanceLoaded(attendanceModel: attendanceModel));
        final isMarked = await attendanceApiProvider.markAsPresent(
          event.branchId,
          attendanceModel.studentModel![event.index].admissionNumber,
          event.date,
        );
        attendanceModel.studentModel![event.index].isMarkingAttendace = false;
        if (isMarked) {
          attendanceModel.studentModel![event.index].isAbsent = false;
        } else {
          // ignore: use_build_context_synchronously
          final scaffoldMessenger = ScaffoldMessenger.of(event.context);
          scaffoldMessenger.showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
              width: 700,
              content: Row(
                children: [
                  const HeroIcon(
                    HeroIcons.exclamationCircle,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Failed to mark present for ${attendanceModel.studentModel![event.index].name}.',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        emit(AttendanceLoaded(attendanceModel: attendanceModel));
      }
    });
  }
}
