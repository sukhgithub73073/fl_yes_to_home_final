import 'package:yestohome/src/data/blocs/auth_bloc/auth_bloc.dart';
import 'package:yestohome/src/data/blocs/image_pick_bloc/image_pick_bloc.dart';
import 'package:yestohome/src/data/blocs/language_bloc/language_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yestohome/src/data/blocs/location_bloc/location_bloc.dart';
import 'package:yestohome/src/data/blocs/property_bloc/property_bloc.dart';
import 'package:yestohome/src/data/blocs/role_bloc/role_bloc.dart';
import 'package:yestohome/src/enums/role_enum.dart';

class AppBlocProvider extends StatelessWidget {
  final Widget child;
  final bool lazy;

  const AppBlocProvider({
    Key? key,
    required this.child,
    this.lazy = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            lazy: lazy,
            create: (_) =>
                LanguageBloc()..add(ChangeLanguageEvent(locale: "en"))),
        BlocProvider(lazy: lazy, create: (_) => AuthBloc()),
        BlocProvider(lazy: lazy, create: (_) => RoleBloc()),
        BlocProvider(lazy: lazy, create: (_) => LocationBloc()),
        BlocProvider(lazy: lazy, create: (_) => PropertyBloc()),
        BlocProvider(lazy: lazy, create: (_) => ImagePickBloc()),
      ],
      child: child,
    );
  }
}
