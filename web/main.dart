import 'package:angular2/angular2.dart';
import 'package:angular2/di.dart';
import 'package:angular2/router.dart';

// These imports will go away soon:
import 'package:angular2/src/reflection/reflection.dart' show reflector;
import 'package:angular2/src/reflection/reflection_capabilities.dart'
    show ReflectionCapabilities;

void main() {
  // Temporarily needed.
  reflector.reflectionCapabilities = new ReflectionCapabilities();

  bootstrap(AppComp, [
  routerInjectables,

  // The base path of your application
  bind(appBaseHrefToken).toValue('/'),

  // uncomment this if you want to use '#' in your url
  //bind(LocationStrategy).toClass(HashLocationStrategy)
  ]);
}


@Component(
  selector: 'app'
)
@View(
  directives: const [routerDirectives],
  template: '''
 <button (click)="go('home')">home - router.navigate</button>
 <button (click)="go('bar')">bar - router.navigate</button>
 <button (click)="go('foo/99')">foo - router.navigate</button>
 <br>

 <!-- The component templates will be rendered here -->
 <router-outlet></router-outlet>

 <a [router-link]="['./home']">home - router-link</a>
 <a [router-link]="['./bar']">bar - router-link</a>
 <a [router-link]="['./foo', {'id': 99}]">bar - router-link</a>
  '''
)
@RouteConfig(const [
  const Route(path: '/foo/:id', component: FooCmp, as: 'foo'),
  const Route(path: '/bar', component: BarCmp, as: 'bar'),
  const Route(path: '/home', component: HomeComp, as: 'home'),
  const Route(path: '/', component: HomeComp)
])
class AppComp {
  Router router;
  AppComp(this.router);

  go(String path) {
    router.navigate('/$path');
  }
}

@Component(selector: 'foo')
@View(template: '<div>foo {{id}}</div>')
class FooCmp {
  String id;
  FooCmp(RouteParams routeParams) {
    id = routeParams.get("id");
  }
}

@Component(selector: 'bar')
@View(template: '<div>bar</div>')
class BarCmp {}

@Component(selector: 'home')
@View(template: '<div>Hello {{name}}</div>')
class HomeComp {
  String name;
  HomeComp() : name = 'Friend' {}
}