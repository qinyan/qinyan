// function PhoneListCtrl($scope, $http) {
//   $http.get('phones/phones.json').success(function(data) {
//     $scope.phones = data;
//     // $scope.phones = data.splice(0, 5);
//   });
//   $scope.orderProp = 'age';

// }
// //PhoneListCtrl.$inject = ['$scope', '$http'];

function AddUserController($scope){
  $scope.message = '';
  $scope.addUser = function(){
    $scope.message = 'Thanks' + $scope.user.first + ', we added you!';
  };
}
// AddUserController.$inject = ['$scope'];

function PhoneListCtrl($scope, Phone) {
  // $http.get('phones/phones.json').success(function(data) {
  //   $scope.phones = data;
  //   // $scope.phones = data.splice(0, 5);
  // });
  $scope.phones = Phone.query();
  $scope.orderProp = 'age';

}
// PhoneListCtrl.$inject = ['$scope'];


// function PhoneDetailCtrl($scope, $routeParams, $http) {
//   $http.get('phones/' + $routeParams.phoneId + '.json').success(function(data) {
//     $scope.phone = data;
//   });
// }
//PhoneDetailCtrl.$inject = ['$scope', '$routeParams', '$http'];

function PhoneDetailCtrl($scope, $routeParams, $http) {
  $http.get('phones/' + $routeParams.phoneId + '.json').success(function(data) {
    $scope.phone = data;
    $scope.mainImageUrl = data.images[0];
  });

 $scope.setImage = function(imageUrl) {
    $scope.mainImageUrl = imageUrl;
  }
}
// PhoneDetailCtrl.$inject = ['$scope', '$routeParams', '$http'];

function InvoiceCntl($scope) {
    $scope.qty = 1;
    $scope.cost = 19.95;
}
// InvoiceCntl.$inject = ['$scope'];

var appModule = angular.module('app', []);
appModule.directive('hello', function() {
  return {restrict: 'E',template: '<div>Hi there</div>', replace: true};
});
