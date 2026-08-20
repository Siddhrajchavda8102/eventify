import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_booking/core/network/dio/api_client.dart';
import 'package:event_booking/features/auth/data/datasource/auth_remote_data_sorce.dart';
import 'package:event_booking/features/auth/data/repository/auth_repository_impl.dart';
import 'package:event_booking/features/auth/domain/repository/auth_repository.dart';
import 'package:event_booking/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:event_booking/features/auth/domain/usecases/login_usecase.dart';
import 'package:event_booking/features/auth/domain/usecases/logout_usecase.dart';
import 'package:event_booking/features/auth/domain/usecases/register_usecase.dart';
import 'package:event_booking/features/booking/data/datasource/booking_remote_data_source.dart';
import 'package:event_booking/features/booking/data/repository/booking_repo_impl.dart';
import 'package:event_booking/features/booking/domain/repository/booking_repo.dart';
import 'package:event_booking/features/booking/domain/usecases/add_booking_usecase.dart';
import 'package:event_booking/features/booking/domain/usecases/cancel_booking_usecase.dart';
import 'package:event_booking/features/booking/domain/usecases/get_bookings_from_id_usecase.dart';
import 'package:event_booking/features/booking/domain/usecases/get_bookings_usecase.dart';
import 'package:event_booking/features/booking/presentation/providers/booking_provider.dart';
import 'package:event_booking/features/event/data/datasource/event_remote_datasource.dart';
import 'package:event_booking/features/event/data/repository/event_repository_impl.dart';
import 'package:event_booking/features/event/domain/repository/event_repository.dart';
import 'package:event_booking/features/event/domain/usecases/get_event_usecase.dart';
import 'package:event_booking/features/event/domain/usecases/get_events_usecase.dart';
import 'package:event_booking/features/event/domain/usecases/update_event_usecase.dart';
import 'package:event_booking/features/event/presentation/providers/event_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../features/auth/presentation/providers/auth_provider.dart';

class AllProviders {
  late final ApiClient apiClient;

  late final FirebaseAuth firebaseAuth;
  late final FirebaseFirestore firebaseFirestore;

  /// DataSources
  late AuthRemoteDataSource authRemoteDataSource;
  late EventRemoteDataSource eventRemoteDataSource;
  late BookingRemoteDataSource bookingRemoteDataSource;

  /// Repo
  late AuthRepository authRepository;
  late EventRepository eventRepository;
  late BookingRepo bookingRepository;

  /// usecases
  late RegisterUsecase registerUsecase;
  late LoginUsecase loginUsecase;
  late GetCurrentUserUsecase getCurrentUserUsecase;
  late LogoutUsecase logoutUsecase;
  late GetEventsUsecase getEventsUsecase;
  late GetEventUsecase getEventUsecase;
  late AddBookingUsecase addBookingUsecase;
  late UpdateEventUseCase updateEventUseCase;
  late GetBookingsUsecase getBookingsUsecase;
  late CancelBookingUsecase cancelBookingUsecase;
  late GetBookingsFromIdUsecase getBookingsFromIdUsecase;

  /// Providers
  late LAuthProvider authProvider;
  late EventProvider eventProvider;
  late BookingProvider bookingProvider;

  AllProviders() {
    apiClient = ApiClient();

    firebaseAuth = FirebaseAuth.instance;
    firebaseFirestore = FirebaseFirestore.instance;

    /// datasources
    authRemoteDataSource = AuthRemoteDataSourceImpl(
      firebaseAuth,
      firebaseFirestore,
    );
    eventRemoteDataSource = EventRemoteDataSourceImpl(
      firestore: firebaseFirestore,
    );
    bookingRemoteDataSource = BookingRemoteDataSourceImpl(
      firestore: firebaseFirestore,
    );

    /// Repos
    authRepository = AuthRepositoryImpl(
      authRemoteDataSource: authRemoteDataSource,
    );
    eventRepository = EventRepositoryImpl(
      eventRemoteDataSource: eventRemoteDataSource,
    );
    bookingRepository = BookingRepoImpl(
      bookingRemoteDataSource: bookingRemoteDataSource,
    );

    /// Usecases
    registerUsecase = RegisterUsecase(authRepository: authRepository);
    loginUsecase = LoginUsecase(authRepository: authRepository);
    logoutUsecase = LogoutUsecase(authRepository: authRepository);
    getCurrentUserUsecase = GetCurrentUserUsecase(
      authRepository: authRepository,
    );
    getEventsUsecase = GetEventsUsecase(repository: eventRepository);
    getEventUsecase = GetEventUsecase(eventRepository: eventRepository);
    addBookingUsecase = AddBookingUsecase(bookingRepo: bookingRepository);
    updateEventUseCase = UpdateEventUseCase(eventRepository: eventRepository);
    getBookingsUsecase = GetBookingsUsecase(bookingRepo: bookingRepository);
    cancelBookingUsecase = CancelBookingUsecase(bookingRepo: bookingRepository);
    getBookingsFromIdUsecase = GetBookingsFromIdUsecase(
      bookingRepo: bookingRepository,
    );

    authProvider = LAuthProvider(
      registerUsecase: registerUsecase,
      loginUsecase: loginUsecase,
      logoutUsecase: logoutUsecase,
      getCurrentUserUsecase: getCurrentUserUsecase,
    );
    eventProvider = EventProvider(
      getEventsUsecase: getEventsUsecase,
      getEventUsecase: getEventUsecase,
      updateEventUseCase: updateEventUseCase,
    );
    bookingProvider = BookingProvider(
      addBookingUsecase: addBookingUsecase,
      getBookingsUsecase: getBookingsUsecase,
      cancelBookingUsecase: cancelBookingUsecase,
      getBookingsFromIdUsecase: getBookingsFromIdUsecase,
    );
  }

  List<SingleChildWidget> getAllProvider() {
    return [
      ChangeNotifierProvider(create: (context) => authProvider),
      ChangeNotifierProvider(create: (context) => eventProvider),
      ChangeNotifierProvider(create: (context) => bookingProvider),
    ];
  }
}
