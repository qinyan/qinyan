function init() {
  Ext.define("Person", {
    Name: '',
    Age: 0,
    Say: function (msg) {
      Ext.Msg.alert(this.Name + " Says:", msg);
    },
    constructor: function (name, age) {
      this.Name = name;
      this.Age = age;
    }
  });
  var Tom = new Person("Tom", 26);
  Tom.Say("你好！");
}

// function init() {
//   var win = Ext.create("Ext.window.Window", {
//       title: '示例窗口',
//       width: 300,
//       height: 200
//   });
//   win.show();
// }
// Ext.onReady(init);

// function init() {
//   Ext.MessageBox.alert("警告框", "Hello ExtJS");
//   // Ext.Msg.alert("警告框", "Hello ExtJS");
// }
// Ext.onReady(init);