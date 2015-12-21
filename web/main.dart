import 'package:angular2/angular2.dart' show Component, provide;
import 'package:angular2/bootstrap.dart';
import 'package:angular2/router.dart'
    show
        APP_BASE_HREF,
        HashLocationStrategy,
        LocationStrategy,
        ROUTER_PROVIDERS,
        ROUTER_DIRECTIVES,
        ROUTER_PRIMARY_COMPONENT,
        Route,
        RouteConfig,
        RouteParams,
        Router;

void main() {
  bootstrap(AppComp, [
    ROUTER_PROVIDERS,

    //Router primary component
    provide(ROUTER_PRIMARY_COMPONENT, useValue: AppComp),

    // The base path of your application
    provide(APP_BASE_HREF, useValue: '/ng2_dart_router_demo'),

    // uncomment this if you want to use '#' in your url
    provide(LocationStrategy, useClass: HashLocationStrategy)
  ]);
}

@Component(
    selector: 'app',
    directives: const [ROUTER_DIRECTIVES],
    template: '''
 <button (click)="go('home')">home - router.navigate</button>
 <button (click)="go('bar')">bar - router.navigate</button>
 <button (click)="go('foo/99')">foo - router.navigate</button>
 <br>

 <!-- The component templates will be rendered here -->
 <router-outlet></router-outlet>

 <a [routerLink]="['./Home']">home - routerLink</a>
 <a [routerLink]="['./Bar']">bar - routerLink</a>
 <a [routerLink]="['./Foo', {'id': 99}]">foo - routerLink</a>
  ''')
@RouteConfig(const [
  const Route(path: '/foo/:id', component: FooCmp, name: 'Foo'),
  const Route(path: '/bar', component: BarCmp, name: 'Bar'),
  const Route(path: '/home', component: HomeComp, name: 'Home'),
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
    router.navigateByUrl('/$path');
  }
}

@Component(selector: 'bar', template: '<div>bar</div>')
class BarCmp {}

@Component(selector: 'foo', template: '<div>foo {{id}}</div>')
class FooCmp {
  String id;
  FooCmp(RouteParams routeParams) {
    id = routeParams.get("id");
  }
}

@Component(selector: 'home', template: '<div>Hello {{name}}</div>')
class HomeComp {
  String name;
  HomeComp() : name = 'Friend' {}
}
