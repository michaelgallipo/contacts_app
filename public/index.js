/* global Vue, VueRouter, axios */

var HomePage = {
  template: "#home-page",
  data: function() {
    return {
      message: "Contact App",
      contacts: []
    };
  },
  created: function() {
    axios.get("/api/contacts").then(function(response) {
      this.contacts = response.data;
      console.log(this.contacts);
    }.bind(this));
  },
  methods: {},
  computed: {}
};

var NewContactPage = {
  template: "#new-contact-page",
    data: function() {
      return {
        first_name: "",
        last_name: "",
        middle_name: "",
        city: "",
        email: "",
        cell_phone: "",
        bio: "",
        errors: []
      };
    },
  methods: {
    submit: function() {
      var params = {
        first_name: this.first_name,
        last_name: this.last_name,
        middle_name: this.middle_name,
        city: this.city,
        email: this.email,
        cell_phone: this.cell_phone,
        bio: this.bio
      };
      axios.post("aoi/contacts", params).then(function(response) {
        router.push("/#/");
      })
      .catch(
        function(error) {
          this.errors = error.response.data.errors;

        }.bind(this)
      );
    }
  },
};

var LoginPage = {
  template: "#login-page",
  data: function() {
    return {
      email: "",
      password: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        auth: { email: this.email, password: this.password }
      };
      axios
        .post("/user_token", params)
        .then(function(response) {
          axios.defaults.headers.common["Authorization"] =
            "Bearer " + response.data.jwt;
          localStorage.setItem("jwt", response.data.jwt);
          router.push("/");
        })
        .catch(
          function(error) {
            this.errors = ["Invalid email or password."];
            this.email = "";
            this.password = "";
          }.bind(this)
        );
    }
  }
};

var LogoutPage = {
  template: "<h1>Logout</h1>",
  created: function() {
    axios.defaults.headers.common["Authorization"] = undefined;
    localStorage.removeItem("jwt");
    router.push("/");
  }
};

var SignupPage = {
  template: "#signup-page",
  data: function() {
    return {
      name: "",
      email: "",
      password: "",
      passwordConfirmation: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        name: this.name,
        email: this.email,
        password: this.password,
        password_confirmation: this.passwordConfirmation
      };
      axios
        .post("/users", params)
        .then(function(response) {
          router.push("/login");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    }
  }
};

var router = new VueRouter({
  routes: [
  { path: "/", component: HomePage },
  { path: "/login", component: LoginPage },
  { path: "/logout", component: LogoutPage },
  { path: "/signup", component: SignupPage },
  { path: "/contacts/new", component: NewContactPage },
  ],
  scrollBehavior: function(to, from, savedPosition) {
    return { x: 0, y: 0 };
  }
});

var app = new Vue({
  el: "#vue-app",
  router: router,
  created: function() {
    var jwt = localStorage.getItem("jwt");
    if (jwt) {
      axios.defaults.headers.common["Authorization"] = jwt;
    }
  }
});