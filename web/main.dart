import 'package:angular2/angular2.dart' show Component, View, bind;
import 'package:angular2/bootstrap.dart' show bootstrap;
import 'package:angular2/router.dart'
    show
        APP_BASE_HREF,
        Route,
        RouteConfig,
        RouteParams,
        Router,
        ROUTER_DIRECTIVES,
        ROUTER_BINDINGS;

void main() {
  bootstrap(AppComp, [
    ROUTER_BINDINGS,

    // The base path of your application
    bind(APP_BASE_HREF).toValue('/ng2_dart_router_demo'),

    // uncomment this if you want to use '#' in your url
    //bind(APP_BASE_HREF).toClass(HashLocationStrategy)
  ]);
}

@Component(selector: 'app')
@View(
    directives: const [ROUTER_DIRECTIVES],
    template: '''
 <button (click)="go('home')">home - router.navigate</button>
 <button (click)="go('bar')">bar - router.navigate</button>
 <button (click)="go('foo/99')">foo - router.navigate</button>
 <br>

 <!-- The component templates will be rendered here -->
 <router-outlet></router-outlet>

 <a [router-link]="['./home']">home - router-link</a>
 <a [router-link]="['./bar']">bar - router-link</a>
 <a [router-link]="['./foo', {'id': 99}]">foo - router-link</a>
  ''')
@RouteConfig(const [
  const Route(path: '/foo/:id', component: FooCmp, as: 'foo'),
  const Route(path: '/bar', component: BarCmp, as: 'bar'),
  const Route(path: '/home', component: HomeComp, as: 'home'),
  const Route(path: '/', component: HomeComp)
])
class AppComp {
  Router router;
  AppComp(this.router) {
    router.subscribe((value) {
      print("Route changed to: $value");
    });
  }

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
