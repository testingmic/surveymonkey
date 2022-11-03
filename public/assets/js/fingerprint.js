!(function (e) {
  var t = {};
  function n(r) {
    if (t[r]) return t[r].exports;
    var o = (t[r] = { i: r, l: !1, exports: {} });
    return e[r].call(o.exports, o, o.exports, n), (o.l = !0), o.exports;
  }
  (n.m = e),
    (n.c = t),
    (n.d = function (e, t, r) {
      n.o(e, t) || Object.defineProperty(e, t, { enumerable: !0, get: r });
    }),
    (n.r = function (e) {
      "undefined" != typeof Symbol &&
        Symbol.toStringTag &&
        Object.defineProperty(e, Symbol.toStringTag, { value: "Module" }),
        Object.defineProperty(e, "__esModule", { value: !0 });
    }),
    (n.t = function (e, t) {
      if ((1 & t && (e = n(e)), 8 & t)) return e;
      if (4 & t && "object" == typeof e && e && e.__esModule) return e;
      var r = Object.create(null);
      if (
        (n.r(r),
        Object.defineProperty(r, "default", { enumerable: !0, value: e }),
        2 & t && "string" != typeof e)
      )
        for (var o in e)
          n.d(
            r,
            o,
            function (t) {
              return e[t];
            }.bind(null, o)
          );
      return r;
    }),
    (n.n = function (e) {
      var t =
        e && e.__esModule
          ? function () {
              return e.default;
            }
          : function () {
              return e;
            };
      return n.d(t, "a", t), t;
    }),
    (n.o = function (e, t) {
      return Object.prototype.hasOwnProperty.call(e, t);
    }),
    (n.p = ""),
    n((n.s = 9));
})([
  function (e, t, n) {
    "use strict";
    t.a = function (e) {
      var t = this.constructor;
      return this.then(
        function (n) {
          return t.resolve(e()).then(function () {
            return n;
          });
        },
        function (n) {
          return t.resolve(e()).then(function () {
            return t.reject(n);
          });
        }
      );
    };
  },
  function (e, t, n) {
    "use strict";
    t.a = function (e) {
      return new this(function (t, n) {
        if (!e || void 0 === e.length)
          return n(
            new TypeError(
              typeof e +
                " " +
                e +
                " is not iterable(cannot read property Symbol(Symbol.iterator))"
            )
          );
        var r = Array.prototype.slice.call(e);
        if (0 === r.length) return t([]);
        var o = r.length;
        function i(e, n) {
          if (n && ("object" == typeof n || "function" == typeof n)) {
            var a = n.then;
            if ("function" == typeof a)
              return void a.call(
                n,
                function (t) {
                  i(e, t);
                },
                function (n) {
                  (r[e] = { status: "rejected", reason: n }), 0 == --o && t(r);
                }
              );
          }
          (r[e] = { status: "fulfilled", value: n }), 0 == --o && t(r);
        }
        for (var a = 0; a < r.length; a++) i(a, r[a]);
      });
    };
  },
  function (e, t) {
    var n;
    n = (function () {
      return this;
    })();
    try {
      n = n || new Function("return this")();
    } catch (r) {
      "object" == typeof window && (n = window);
    }
    e.exports = n;
  },
  function (e) {
    e.exports = JSON.parse('{"a":"3.3.6"}');
  },
  function (e, t, n) {
    "use strict";
    (function (e) {
      var r = n(0),
        o = n(1),
        i = setTimeout;
      function a(e) {
        return Boolean(e && void 0 !== e.length);
      }
      function c() {}
      function u(e) {
        if (!(this instanceof u))
          throw new TypeError("Promises must be constructed via new");
        if ("function" != typeof e) throw new TypeError("not a function");
        (this._state = 0),
          (this._handled = !1),
          (this._value = void 0),
          (this._deferreds = []),
          h(e, this);
      }
      function l(e, t) {
        for (; 3 === e._state; ) e = e._value;
        0 !== e._state
          ? ((e._handled = !0),
            u._immediateFn(function () {
              var n = 1 === e._state ? t.onFulfilled : t.onRejected;
              if (null !== n) {
                var r;
                try {
                  r = n(e._value);
                } catch (o) {
                  return void d(t.promise, o);
                }
                s(t.promise, r);
              } else (1 === e._state ? s : d)(t.promise, e._value);
            }))
          : e._deferreds.push(t);
      }
      function s(e, t) {
        try {
          if (t === e)
            throw new TypeError("A promise cannot be resolved with itself.");
          if (t && ("object" == typeof t || "function" == typeof t)) {
            var n = t.then;
            if (t instanceof u)
              return (e._state = 3), (e._value = t), void f(e);
            if ("function" == typeof n)
              return void h(
                ((r = n),
                (o = t),
                function () {
                  r.apply(o, arguments);
                }),
                e
              );
          }
          (e._state = 1), (e._value = t), f(e);
        } catch (i) {
          d(e, i);
        }
        var r, o;
      }
      function d(e, t) {
        (e._state = 2), (e._value = t), f(e);
      }
      function f(e) {
        2 === e._state &&
          0 === e._deferreds.length &&
          u._immediateFn(function () {
            e._handled || u._unhandledRejectionFn(e._value);
          });
        for (var t = 0, n = e._deferreds.length; t < n; t++)
          l(e, e._deferreds[t]);
        e._deferreds = null;
      }
      function m(e, t, n) {
        (this.onFulfilled = "function" == typeof e ? e : null),
          (this.onRejected = "function" == typeof t ? t : null),
          (this.promise = n);
      }
      function h(e, t) {
        var n = !1;
        try {
          e(
            function (e) {
              n || ((n = !0), s(t, e));
            },
            function (e) {
              n || ((n = !0), d(t, e));
            }
          );
        } catch (r) {
          if (n) return;
          (n = !0), d(t, r);
        }
      }
      (u.prototype.catch = function (e) {
        return this.then(null, e);
      }),
        (u.prototype.then = function (e, t) {
          var n = new this.constructor(c);
          return l(this, new m(e, t, n)), n;
        }),
        (u.prototype.finally = r.a),
        (u.all = function (e) {
          return new u(function (t, n) {
            if (!a(e)) return n(new TypeError("Promise.all accepts an array"));
            var r = Array.prototype.slice.call(e);
            if (0 === r.length) return t([]);
            var o = r.length;
            function i(e, a) {
              try {
                if (a && ("object" == typeof a || "function" == typeof a)) {
                  var c = a.then;
                  if ("function" == typeof c)
                    return void c.call(
                      a,
                      function (t) {
                        i(e, t);
                      },
                      n
                    );
                }
                (r[e] = a), 0 == --o && t(r);
              } catch (u) {
                n(u);
              }
            }
            for (var c = 0; c < r.length; c++) i(c, r[c]);
          });
        }),
        (u.allSettled = o.a),
        (u.resolve = function (e) {
          return e && "object" == typeof e && e.constructor === u
            ? e
            : new u(function (t) {
                t(e);
              });
        }),
        (u.reject = function (e) {
          return new u(function (t, n) {
            n(e);
          });
        }),
        (u.race = function (e) {
          return new u(function (t, n) {
            if (!a(e)) return n(new TypeError("Promise.race accepts an array"));
            for (var r = 0, o = e.length; r < o; r++)
              u.resolve(e[r]).then(t, n);
          });
        }),
        (u._immediateFn =
          ("function" == typeof e &&
            function (t) {
              e(t);
            }) ||
          function (e) {
            i(e, 0);
          }),
        (u._unhandledRejectionFn = function (e) {
          "undefined" != typeof console &&
            console &&
            console.warn("Possible Unhandled Promise Rejection:", e);
        }),
        (t.a = u);
    }.call(this, n(6).setImmediate));
  },
  function (e, t, n) {
    "use strict";
    (function (e) {
      var t = n(4),
        r = n(0),
        o = n(1),
        i = (function () {
          if ("undefined" != typeof self) return self;
          if ("undefined" != typeof window) return window;
          if (void 0 !== e) return e;
          throw new Error("unable to locate global object");
        })();
      "function" != typeof i.Promise
        ? (i.Promise = t.a)
        : i.Promise.prototype.finally
        ? i.Promise.allSettled || (i.Promise.allSettled = o.a)
        : (i.Promise.prototype.finally = r.a);
    }.call(this, n(2)));
  },
  function (e, t, n) {
    (function (e) {
      var r =
          (void 0 !== e && e) || ("undefined" != typeof self && self) || window,
        o = Function.prototype.apply;
      function i(e, t) {
        (this._id = e), (this._clearFn = t);
      }
      (t.setTimeout = function () {
        return new i(o.call(setTimeout, r, arguments), clearTimeout);
      }),
        (t.setInterval = function () {
          return new i(o.call(setInterval, r, arguments), clearInterval);
        }),
        (t.clearTimeout = t.clearInterval =
          function (e) {
            e && e.close();
          }),
        (i.prototype.unref = i.prototype.ref = function () {}),
        (i.prototype.close = function () {
          this._clearFn.call(r, this._id);
        }),
        (t.enroll = function (e, t) {
          clearTimeout(e._idleTimeoutId), (e._idleTimeout = t);
        }),
        (t.unenroll = function (e) {
          clearTimeout(e._idleTimeoutId), (e._idleTimeout = -1);
        }),
        (t._unrefActive = t.active =
          function (e) {
            clearTimeout(e._idleTimeoutId);
            var t = e._idleTimeout;
            t >= 0 &&
              (e._idleTimeoutId = setTimeout(function () {
                e._onTimeout && e._onTimeout();
              }, t));
          }),
        n(7),
        (t.setImmediate =
          ("undefined" != typeof self && self.setImmediate) ||
          (void 0 !== e && e.setImmediate) ||
          (this && this.setImmediate)),
        (t.clearImmediate =
          ("undefined" != typeof self && self.clearImmediate) ||
          (void 0 !== e && e.clearImmediate) ||
          (this && this.clearImmediate));
    }.call(this, n(2)));
  },
  function (e, t, n) {
    (function (e, t) {
      !(function (e, n) {
        "use strict";
        if (!e.setImmediate) {
          var r,
            o,
            i,
            a,
            c,
            u = 1,
            l = {},
            s = !1,
            d = e.document,
            f = Object.getPrototypeOf && Object.getPrototypeOf(e);
          (f = f && f.setTimeout ? f : e),
            "[object process]" === {}.toString.call(e.process)
              ? (r = function (e) {
                  t.nextTick(function () {
                    h(e);
                  });
                })
              : !(function () {
                  if (e.postMessage && !e.importScripts) {
                    var t = !0,
                      n = e.onmessage;
                    return (
                      (e.onmessage = function () {
                        t = !1;
                      }),
                      e.postMessage("", "*"),
                      (e.onmessage = n),
                      t
                    );
                  }
                })()
              ? e.MessageChannel
                ? (((i = new MessageChannel()).port1.onmessage = function (e) {
                    h(e.data);
                  }),
                  (r = function (e) {
                    i.port2.postMessage(e);
                  }))
                : d && "onreadystatechange" in d.createElement("script")
                ? ((o = d.documentElement),
                  (r = function (e) {
                    var t = d.createElement("script");
                    (t.onreadystatechange = function () {
                      h(e),
                        (t.onreadystatechange = null),
                        o.removeChild(t),
                        (t = null);
                    }),
                      o.appendChild(t);
                  }))
                : (r = function (e) {
                    setTimeout(h, 0, e);
                  })
              : ((a = "setImmediate$" + Math.random() + "$"),
                (c = function (t) {
                  t.source === e &&
                    "string" == typeof t.data &&
                    0 === t.data.indexOf(a) &&
                    h(+t.data.slice(a.length));
                }),
                e.addEventListener
                  ? e.addEventListener("message", c, !1)
                  : e.attachEvent("onmessage", c),
                (r = function (t) {
                  e.postMessage(a + t, "*");
                })),
            (f.setImmediate = function (e) {
              "function" != typeof e && (e = new Function("" + e));
              for (
                var t = new Array(arguments.length - 1), n = 0;
                n < t.length;
                n++
              )
                t[n] = arguments[n + 1];
              var o = { callback: e, args: t };
              return (l[u] = o), r(u), u++;
            }),
            (f.clearImmediate = m);
        }
        function m(e) {
          delete l[e];
        }
        function h(e) {
          if (s) setTimeout(h, 0, e);
          else {
            var t = l[e];
            if (t) {
              s = !0;
              try {
                !(function (e) {
                  var t = e.callback,
                    n = e.args;
                  switch (n.length) {
                    case 0:
                      t();
                      break;
                    case 1:
                      t(n[0]);
                      break;
                    case 2:
                      t(n[0], n[1]);
                      break;
                    case 3:
                      t(n[0], n[1], n[2]);
                      break;
                    default:
                      t.apply(void 0, n);
                  }
                })(t);
              } finally {
                m(e), (s = !1);
              }
            }
          }
        }
      })("undefined" == typeof self ? (void 0 === e ? this : e) : self);
    }.call(this, n(2), n(8)));
  },
  function (e, t) {
    var n,
      r,
      o = (e.exports = {});
    function i() {
      throw new Error("setTimeout has not been defined");
    }
    function a() {
      throw new Error("clearTimeout has not been defined");
    }
    function c(e) {
      if (n === setTimeout) return setTimeout(e, 0);
      if ((n === i || !n) && setTimeout)
        return (n = setTimeout), setTimeout(e, 0);
      try {
        return n(e, 0);
      } catch (t) {
        try {
          return n.call(null, e, 0);
        } catch (t) {
          return n.call(this, e, 0);
        }
      }
    }
    !(function () {
      try {
        n = "function" == typeof setTimeout ? setTimeout : i;
      } catch (e) {
        n = i;
      }
      try {
        r = "function" == typeof clearTimeout ? clearTimeout : a;
      } catch (e) {
        r = a;
      }
    })();
    var u,
      l = [],
      s = !1,
      d = -1;
    function f() {
      s &&
        u &&
        ((s = !1), u.length ? (l = u.concat(l)) : (d = -1), l.length && m());
    }
    function m() {
      if (!s) {
        var e = c(f);
        s = !0;
        for (var t = l.length; t; ) {
          for (u = l, l = []; ++d < t; ) u && u[d].run();
          (d = -1), (t = l.length);
        }
        (u = null),
          (s = !1),
          (function (e) {
            if (r === clearTimeout) return clearTimeout(e);
            if ((r === a || !r) && clearTimeout)
              return (r = clearTimeout), clearTimeout(e);
            try {
              r(e);
            } catch (t) {
              try {
                return r.call(null, e);
              } catch (t) {
                return r.call(this, e);
              }
            }
          })(e);
      }
    }
    function h(e, t) {
      (this.fun = e), (this.array = t);
    }
    function v() {}
    (o.nextTick = function (e) {
      var t = new Array(arguments.length - 1);
      if (arguments.length > 1)
        for (var n = 1; n < arguments.length; n++) t[n - 1] = arguments[n];
      l.push(new h(e, t)), 1 !== l.length || s || c(m);
    }),
      (h.prototype.run = function () {
        this.fun.apply(null, this.array);
      }),
      (o.title = "browser"),
      (o.browser = !0),
      (o.env = {}),
      (o.argv = []),
      (o.version = ""),
      (o.versions = {}),
      (o.on = v),
      (o.addListener = v),
      (o.once = v),
      (o.off = v),
      (o.removeListener = v),
      (o.removeAllListeners = v),
      (o.emit = v),
      (o.prependListener = v),
      (o.prependOnceListener = v),
      (o.listeners = function (e) {
        return [];
      }),
      (o.binding = function (e) {
        throw new Error("process.binding is not supported");
      }),
      (o.cwd = function () {
        return "/";
      }),
      (o.chdir = function (e) {
        throw new Error("process.chdir is not supported");
      }),
      (o.umask = function () {
        return 0;
      });
  },
  function (e, t, n) {
    "use strict";
    n.r(t);
    var r = function () {
      return (r =
        Object.assign ||
        function (e) {
          for (var t, n = 1, r = arguments.length; n < r; n++)
            for (var o in (t = arguments[n]))
              Object.prototype.hasOwnProperty.call(t, o) && (e[o] = t[o]);
          return e;
        }).apply(this, arguments);
    };
    function o(e, t, n, r) {
      return new (n || (n = Promise))(function (o, i) {
        function a(e) {
          try {
            u(r.next(e));
          } catch (t) {
            i(t);
          }
        }
        function c(e) {
          try {
            u(r.throw(e));
          } catch (t) {
            i(t);
          }
        }
        function u(e) {
          var t;
          e.done
            ? o(e.value)
            : ((t = e.value),
              t instanceof n
                ? t
                : new n(function (e) {
                    e(t);
                  })).then(a, c);
        }
        u((r = r.apply(e, t || [])).next());
      });
    }
    function i(e, t) {
      var n,
        r,
        o,
        i,
        a = {
          label: 0,
          sent: function () {
            if (1 & o[0]) throw o[1];
            return o[1];
          },
          trys: [],
          ops: [],
        };
      return (
        (i = { next: c(0), throw: c(1), return: c(2) }),
        "function" == typeof Symbol &&
          (i[Symbol.iterator] = function () {
            return this;
          }),
        i
      );
      function c(i) {
        return function (c) {
          return (function (i) {
            if (n) throw new TypeError("Generator is already executing.");
            for (; a; )
              try {
                if (
                  ((n = 1),
                  r &&
                    (o =
                      2 & i[0]
                        ? r.return
                        : i[0]
                        ? r.throw || ((o = r.return) && o.call(r), 0)
                        : r.next) &&
                    !(o = o.call(r, i[1])).done)
                )
                  return o;
                switch (((r = 0), o && (i = [2 & i[0], o.value]), i[0])) {
                  case 0:
                  case 1:
                    o = i;
                    break;
                  case 4:
                    return a.label++, { value: i[1], done: !1 };
                  case 5:
                    a.label++, (r = i[1]), (i = [0]);
                    continue;
                  case 7:
                    (i = a.ops.pop()), a.trys.pop();
                    continue;
                  default:
                    if (
                      !((o = a.trys),
                      (o = o.length > 0 && o[o.length - 1]) ||
                        (6 !== i[0] && 2 !== i[0]))
                    ) {
                      a = 0;
                      continue;
                    }
                    if (3 === i[0] && (!o || (i[1] > o[0] && i[1] < o[3]))) {
                      a.label = i[1];
                      break;
                    }
                    if (6 === i[0] && a.label < o[1]) {
                      (a.label = o[1]), (o = i);
                      break;
                    }
                    if (o && a.label < o[2]) {
                      (a.label = o[2]), a.ops.push(i);
                      break;
                    }
                    o[2] && a.ops.pop(), a.trys.pop();
                    continue;
                }
                i = t.call(e, a);
              } catch (c) {
                (i = [6, c]), (r = 0);
              } finally {
                n = o = 0;
              }
            if (5 & i[0]) throw i[1];
            return { value: i[0] ? i[1] : void 0, done: !0 };
          })([i, c]);
        };
      }
    }
    Object.create;
    function a() {
      for (var e = 0, t = 0, n = arguments.length; t < n; t++)
        e += arguments[t].length;
      var r = Array(e),
        o = 0;
      for (t = 0; t < n; t++)
        for (var i = arguments[t], a = 0, c = i.length; a < c; a++, o++)
          r[o] = i[a];
      return r;
    }
    Object.create;
    n(5);
    var c = n(3);
    function u(e, t) {
      return new Promise(function (n) {
        return setTimeout(n, e, t);
      });
    }
    function l(e) {
      return e && "function" == typeof e.then;
    }
    function s(e, t) {
      try {
        var n = e();
        l(n)
          ? n.then(
              function (e) {
                return t(!0, e);
              },
              function (e) {
                return t(!1, e);
              }
            )
          : t(!0, n);
      } catch (r) {
        t(!1, r);
      }
    }
    function d(e, t, n) {
      return (
        void 0 === n && (n = 16),
        o(this, void 0, void 0, function () {
          var r, o, a;
          return i(this, function (i) {
            switch (i.label) {
              case 0:
                (r = Date.now()), (o = 0), (i.label = 1);
              case 1:
                return o < e.length
                  ? (t(e[o], o),
                    (a = Date.now()) >= r + n ? ((r = a), [4, u(0)]) : [3, 3])
                  : [3, 4];
              case 2:
                i.sent(), (i.label = 3);
              case 3:
                return ++o, [3, 1];
              case 4:
                return [2];
            }
          });
        })
      );
    }
    function f(e) {
      e.then(void 0, function () {});
    }
    function m(e, t) {
      (e = [e[0] >>> 16, 65535 & e[0], e[1] >>> 16, 65535 & e[1]]),
        (t = [t[0] >>> 16, 65535 & t[0], t[1] >>> 16, 65535 & t[1]]);
      var n = [0, 0, 0, 0];
      return (
        (n[3] += e[3] + t[3]),
        (n[2] += n[3] >>> 16),
        (n[3] &= 65535),
        (n[2] += e[2] + t[2]),
        (n[1] += n[2] >>> 16),
        (n[2] &= 65535),
        (n[1] += e[1] + t[1]),
        (n[0] += n[1] >>> 16),
        (n[1] &= 65535),
        (n[0] += e[0] + t[0]),
        (n[0] &= 65535),
        [(n[0] << 16) | n[1], (n[2] << 16) | n[3]]
      );
    }
    function h(e, t) {
      (e = [e[0] >>> 16, 65535 & e[0], e[1] >>> 16, 65535 & e[1]]),
        (t = [t[0] >>> 16, 65535 & t[0], t[1] >>> 16, 65535 & t[1]]);
      var n = [0, 0, 0, 0];
      return (
        (n[3] += e[3] * t[3]),
        (n[2] += n[3] >>> 16),
        (n[3] &= 65535),
        (n[2] += e[2] * t[3]),
        (n[1] += n[2] >>> 16),
        (n[2] &= 65535),
        (n[2] += e[3] * t[2]),
        (n[1] += n[2] >>> 16),
        (n[2] &= 65535),
        (n[1] += e[1] * t[3]),
        (n[0] += n[1] >>> 16),
        (n[1] &= 65535),
        (n[1] += e[2] * t[2]),
        (n[0] += n[1] >>> 16),
        (n[1] &= 65535),
        (n[1] += e[3] * t[1]),
        (n[0] += n[1] >>> 16),
        (n[1] &= 65535),
        (n[0] += e[0] * t[3] + e[1] * t[2] + e[2] * t[1] + e[3] * t[0]),
        (n[0] &= 65535),
        [(n[0] << 16) | n[1], (n[2] << 16) | n[3]]
      );
    }
    function v(e, t) {
      return 32 === (t %= 64)
        ? [e[1], e[0]]
        : t < 32
        ? [(e[0] << t) | (e[1] >>> (32 - t)), (e[1] << t) | (e[0] >>> (32 - t))]
        : ((t -= 32),
          [
            (e[1] << t) | (e[0] >>> (32 - t)),
            (e[0] << t) | (e[1] >>> (32 - t)),
          ]);
    }
    function p(e, t) {
      return 0 === (t %= 64)
        ? e
        : t < 32
        ? [(e[0] << t) | (e[1] >>> (32 - t)), e[1] << t]
        : [e[1] << (t - 32), 0];
    }
    function y(e, t) {
      return [e[0] ^ t[0], e[1] ^ t[1]];
    }
    function b(e) {
      return (
        (e = y(e, [0, e[0] >>> 1])),
        (e = y((e = h(e, [4283543511, 3981806797])), [0, e[0] >>> 1])),
        (e = y((e = h(e, [3301882366, 444984403])), [0, e[0] >>> 1]))
      );
    }
    function g(e) {
      var t;
      return r(
        {
          name: e.name,
          message: e.message,
          stack:
            null === (t = e.stack) || void 0 === t ? void 0 : t.split("\n"),
        },
        e
      );
    }
    function w(e) {
      return parseInt(e);
    }
    function L(e) {
      return parseFloat(e);
    }
    function k(e, t) {
      return "number" == typeof e && isNaN(e) ? t : e;
    }
    function V(e) {
      return e.reduce(function (e, t) {
        return e + (t ? 1 : 0);
      }, 0);
    }
    function S(e, t) {
      if ((void 0 === t && (t = 1), Math.abs(t) >= 1))
        return Math.round(e / t) * t;
      var n = 1 / t;
      return Math.round(e * n) / n;
    }
    function Z(e) {
      return e && "object" == typeof e && "message" in e ? e : { message: e };
    }
    function W(e) {
      return "function" != typeof e;
    }
    function C(e, t, n) {
      var r = Object.keys(e).filter(function (e) {
          return !(function (e, t) {
            for (var n = 0, r = e.length; n < r; ++n) if (e[n] === t) return !0;
            return !1;
          })(n, e);
        }),
        a = Array(r.length);
      return (
        d(r, function (n, r) {
          a[r] = (function (e, t) {
            var n = new Promise(function (n) {
              var r = Date.now();
              s(e.bind(null, t), function () {
                for (var e = [], t = 0; t < arguments.length; t++)
                  e[t] = arguments[t];
                var o = Date.now() - r;
                if (!e[0])
                  return n(function () {
                    return { error: Z(e[1]), duration: o };
                  });
                var i = e[1];
                if (W(i))
                  return n(function () {
                    return { value: i, duration: o };
                  });
                n(function () {
                  return new Promise(function (e) {
                    var t = Date.now();
                    s(i, function () {
                      for (var n = [], r = 0; r < arguments.length; r++)
                        n[r] = arguments[r];
                      var i = o + Date.now() - t;
                      if (!n[0]) return e({ error: Z(n[1]), duration: i });
                      e({ value: n[1], duration: i });
                    });
                  });
                });
              });
            });
            return (
              f(n),
              function () {
                return n.then(function (e) {
                  return e();
                });
              }
            );
          })(e[n], t);
        }),
        function () {
          return o(this, void 0, void 0, function () {
            var e, t, n, o, c, l;
            return i(this, function (s) {
              switch (s.label) {
                case 0:
                  for (e = {}, t = 0, n = r; t < n.length; t++)
                    (o = n[t]), (e[o] = void 0);
                  (c = Array(r.length)),
                    (l = function () {
                      var t;
                      return i(this, function (n) {
                        switch (n.label) {
                          case 0:
                            return (
                              (t = !0),
                              [
                                4,
                                d(r, function (n, r) {
                                  if (!c[r])
                                    if (a[r]) {
                                      var o = a[r]().then(function (t) {
                                        return (e[n] = t);
                                      });
                                      f(o), (c[r] = o);
                                    } else t = !1;
                                }),
                              ]
                            );
                          case 1:
                            return n.sent(), t ? [2, "break"] : [4, u(1)];
                          case 2:
                            return n.sent(), [2];
                        }
                      });
                    }),
                    (s.label = 1);
                case 1:
                  return [5, l()];
                case 2:
                  if ("break" === s.sent()) return [3, 4];
                  s.label = 3;
                case 3:
                  return [3, 1];
                case 4:
                  return [4, Promise.all(c)];
                case 5:
                  return s.sent(), [2, e];
              }
            });
          });
        }
      );
    }
    function j() {
      var e = window,
        t = navigator;
      return (
        V([
          "MSCSSMatrix" in e,
          "msSetImmediate" in e,
          "msIndexedDB" in e,
          "msMaxTouchPoints" in t,
          "msPointerEnabled" in t,
        ]) >= 4
      );
    }
    function F() {
      var e = window,
        t = navigator;
      return (
        V([
          "webkitPersistentStorage" in t,
          "webkitTemporaryStorage" in t,
          0 === t.vendor.indexOf("Google"),
          "webkitResolveLocalFileSystemURL" in e,
          "BatteryManager" in e,
          "webkitMediaStream" in e,
          "webkitSpeechGrammar" in e,
        ]) >= 5
      );
    }
    function x() {
      var e = window,
        t = navigator;
      return (
        V([
          "ApplePayError" in e,
          "CSSPrimitiveValue" in e,
          "Counter" in e,
          0 === t.vendor.indexOf("Apple"),
          "getStorageUpdates" in t,
          "WebKitMediaKeys" in e,
        ]) >= 4
      );
    }
    function I() {
      var e = window;
      return (
        V([
          "safari" in e,
          !("DeviceMotionEvent" in e),
          !("ongestureend" in e),
          !("standalone" in navigator),
        ]) >= 3
      );
    }
    function M() {
      var e = document;
      return (
        e.exitFullscreen ||
        e.msExitFullscreen ||
        e.mozCancelFullScreen ||
        e.webkitExitFullscreen
      ).call(e);
    }
    function X() {
      var e = F(),
        t = (function () {
          var e,
            t,
            n = window;
          return (
            V([
              "buildID" in navigator,
              "MozAppearance" in
                (null !==
                  (t =
                    null === (e = document.documentElement) || void 0 === e
                      ? void 0
                      : e.style) && void 0 !== t
                  ? t
                  : {}),
              "onmozfullscreenchange" in n,
              "mozInnerScreenX" in n,
              "CSSMozDocumentRule" in n,
              "CanvasCaptureMediaStream" in n,
            ]) >= 4
          );
        })();
      if (!e && !t) return !1;
      var n = window;
      return (
        V([
          "onorientationchange" in n,
          "orientation" in n,
          e && !("SharedWorker" in n),
          t && /android/i.test(navigator.appVersion),
        ]) >= 2
      );
    }
    function T(e) {
      var t = new Error(e);
      return (t.name = e), t;
    }
    function Y(e, t, n) {
      var r, a, c;
      return (
        void 0 === n && (n = 50),
        o(this, void 0, void 0, function () {
          var o, l;
          return i(this, function (i) {
            switch (i.label) {
              case 0:
                (o = document), (i.label = 1);
              case 1:
                return o.body ? [3, 3] : [4, u(n)];
              case 2:
                return i.sent(), [3, 1];
              case 3:
                (l = o.createElement("iframe")), (i.label = 4);
              case 4:
                return (
                  i.trys.push([4, , 10, 11]),
                  [
                    4,
                    new Promise(function (e, n) {
                      var r = !1,
                        i = function () {
                          (r = !0), e();
                        };
                      (l.onload = i),
                        (l.onerror = function (e) {
                          (r = !0), n(e);
                        });
                      var a = l.style;
                      a.setProperty("display", "block", "important"),
                        (a.position = "absolute"),
                        (a.top = "0"),
                        (a.left = "0"),
                        (a.visibility = "hidden"),
                        t && "srcdoc" in l
                          ? (l.srcdoc = t)
                          : (l.src = "about:blank"),
                        o.body.appendChild(l);
                      var c = function () {
                        var e, t;
                        r ||
                          ("complete" ===
                          (null ===
                            (t =
                              null === (e = l.contentWindow) || void 0 === e
                                ? void 0
                                : e.document) || void 0 === t
                            ? void 0
                            : t.readyState)
                            ? i()
                            : setTimeout(c, 10));
                      };
                      c();
                    }),
                  ]
                );
              case 5:
                i.sent(), (i.label = 6);
              case 6:
                return (
                  null ===
                    (a =
                      null === (r = l.contentWindow) || void 0 === r
                        ? void 0
                        : r.document) || void 0 === a
                    ? void 0
                    : a.body
                )
                  ? [3, 8]
                  : [4, u(n)];
              case 7:
                return i.sent(), [3, 6];
              case 8:
                return [4, e(l, l.contentWindow)];
              case 9:
                return [2, i.sent()];
              case 10:
                return (
                  null === (c = l.parentNode) ||
                    void 0 === c ||
                    c.removeChild(l),
                  [7]
                );
              case 11:
                return [2];
            }
          });
        })
      );
    }
    function R(e) {
      for (
        var t = (function (e) {
            for (
              var t,
                n,
                r = "Unexpected syntax '" + e + "'",
                o = /^\s*([a-z-]*)(.*)$/i.exec(e),
                i = o[1] || void 0,
                a = {},
                c = /([.:#][\w-]+|\[.+?\])/gi,
                u = function (e, t) {
                  (a[e] = a[e] || []), a[e].push(t);
                };
              ;

            ) {
              var l = c.exec(o[2]);
              if (!l) break;
              var s = l[0];
              switch (s[0]) {
                case ".":
                  u("class", s.slice(1));
                  break;
                case "#":
                  u("id", s.slice(1));
                  break;
                case "[":
                  var d =
                    /^\[([\w-]+)([~|^$*]?=("(.*?)"|([\w-]+)))?(\s+[is])?\]$/.exec(
                      s
                    );
                  if (!d) throw new Error(r);
                  u(
                    d[1],
                    null !==
                      (n = null !== (t = d[4]) && void 0 !== t ? t : d[5]) &&
                      void 0 !== n
                      ? n
                      : ""
                  );
                  break;
                default:
                  throw new Error(r);
              }
            }
            return [i, a];
          })(e),
          n = t[0],
          r = t[1],
          o = document.createElement(null != n ? n : "div"),
          i = 0,
          a = Object.keys(r);
        i < a.length;
        i++
      ) {
        var c = a[i],
          u = r[c].join(" ");
        "style" === c ? G(o.style, u) : o.setAttribute(c, u);
      }
      return o;
    }
    function G(e, t) {
      for (var n = 0, r = t.split(";"); n < r.length; n++) {
        var o = r[n],
          i = /^\s*([\w-]+)\s*:\s*(.+?)(\s*!([\w-]+))?\s*$/.exec(o);
        if (i) {
          var a = i[1],
            c = i[2],
            u = i[4];
          e.setProperty(a, c, u || "");
        }
      }
    }
    var A = ["monospace", "sans-serif", "serif"],
      P = [
        "sans-serif-thin",
        "ARNO PRO",
        "Agency FB",
        "Arabic Typesetting",
        "Arial Unicode MS",
        "AvantGarde Bk BT",
        "BankGothic Md BT",
        "Batang",
        "Bitstream Vera Sans Mono",
        "Calibri",
        "Century",
        "Century Gothic",
        "Clarendon",
        "EUROSTILE",
        "Franklin Gothic",
        "Futura Bk BT",
        "Futura Md BT",
        "GOTHAM",
        "Gill Sans",
        "HELV",
        "Haettenschweiler",
        "Helvetica Neue",
        "Humanst521 BT",
        "Leelawadee",
        "Letter Gothic",
        "Levenim MT",
        "Lucida Bright",
        "Lucida Sans",
        "Menlo",
        "MS Mincho",
        "MS Outlook",
        "MS Reference Specialty",
        "MS UI Gothic",
        "MT Extra",
        "MYRIAD PRO",
        "Marlett",
        "Meiryo UI",
        "Microsoft Uighur",
        "Minion Pro",
        "Monotype Corsiva",
        "PMingLiU",
        "Pristina",
        "SCRIPTINA",
        "Segoe UI Light",
        "Serifa",
        "SimHei",
        "Small Fonts",
        "Staccato222 BT",
        "TRAJAN PRO",
        "Univers CE 55 Medium",
        "Vrinda",
        "ZWAdobeF",
      ];
    function J(e) {
      return e.toDataURL();
    }
    var _, H;
    function N() {
      var e = this;
      return (
        (function () {
          if (void 0 === H) {
            var e = function () {
              var t = E();
              z(t) ? (H = setTimeout(e, 2500)) : ((_ = t), (H = void 0));
            };
            e();
          }
        })(),
        function () {
          return o(e, void 0, void 0, function () {
            var e;
            return i(this, function (t) {
              switch (t.label) {
                case 0:
                  return z((e = E()))
                    ? _
                      ? [2, a(_)]
                      : (n = document).fullscreenElement ||
                        n.msFullscreenElement ||
                        n.mozFullScreenElement ||
                        n.webkitFullscreenElement
                      ? [4, M()]
                      : [3, 2]
                    : [3, 2];
                case 1:
                  t.sent(), (e = E()), (t.label = 2);
                case 2:
                  return z(e) || (_ = e), [2, e];
              }
              var n;
            });
          });
        }
      );
    }
    function E() {
      var e = screen;
      return [
        k(L(e.availTop), null),
        k(L(e.width) - L(e.availWidth) - k(L(e.availLeft), 0), null),
        k(L(e.height) - L(e.availHeight) - k(L(e.availTop), 0), null),
        k(L(e.availLeft), null),
      ];
    }
    function z(e) {
      for (var t = 0; t < 4; ++t) if (e[t]) return !1;
      return !0;
    }
    function O(e) {
      var t;
      return o(this, void 0, void 0, function () {
        var n, r, o, a, c, l, s;
        return i(this, function (i) {
          switch (i.label) {
            case 0:
              for (
                n = document,
                  r = n.createElement("div"),
                  o = new Array(e.length),
                  a = {},
                  D(r),
                  s = 0;
                s < e.length;
                ++s
              )
                (c = R(e[s])),
                  D((l = n.createElement("div"))),
                  l.appendChild(c),
                  r.appendChild(l),
                  (o[s] = c);
              i.label = 1;
            case 1:
              return n.body ? [3, 3] : [4, u(50)];
            case 2:
              return i.sent(), [3, 1];
            case 3:
              n.body.appendChild(r);
              try {
                for (s = 0; s < e.length; ++s)
                  o[s].offsetParent || (a[e[s]] = !0);
              } finally {
                null === (t = r.parentNode) || void 0 === t || t.removeChild(r);
              }
              return [2, a];
          }
        });
      });
    }
    function D(e) {
      e.style.setProperty("display", "block", "important");
    }
    function B(e) {
      return matchMedia("(inverted-colors: " + e + ")").matches;
    }
    function Q(e) {
      return matchMedia("(forced-colors: " + e + ")").matches;
    }
    function U(e) {
      return matchMedia("(prefers-contrast: " + e + ")").matches;
    }
    function K(e) {
      return matchMedia("(prefers-reduced-motion: " + e + ")").matches;
    }
    function q(e) {
      return matchMedia("(dynamic-range: " + e + ")").matches;
    }
    var $ = Math,
      ee = function () {
        return 0;
      };
    var te = {
      default: [],
      apple: [{ font: "-apple-system-body" }],
      serif: [{ fontFamily: "serif" }],
      sans: [{ fontFamily: "sans-serif" }],
      mono: [{ fontFamily: "monospace" }],
      min: [{ fontSize: "1px" }],
      system: [{ fontFamily: "system-ui" }],
    };
    var ne = {
      fonts: function () {
        return Y(function (e, t) {
          var n = t.document,
            r = n.body;
          r.style.fontSize = "48px";
          var o = n.createElement("div"),
            i = {},
            a = {},
            c = function (e) {
              var t = n.createElement("span"),
                r = t.style;
              return (
                (r.position = "absolute"),
                (r.top = "0"),
                (r.left = "0"),
                (r.fontFamily = e),
                (t.textContent = "mmMwWLliI0O&1"),
                o.appendChild(t),
                t
              );
            },
            u = A.map(c),
            l = (function () {
              for (
                var e = {},
                  t = function (t) {
                    e[t] = A.map(function (e) {
                      return (function (e, t) {
                        return c("'" + e + "'," + t);
                      })(t, e);
                    });
                  },
                  n = 0,
                  r = P;
                n < r.length;
                n++
              ) {
                t(r[n]);
              }
              return e;
            })();
          r.appendChild(o);
          for (var s = 0; s < A.length; s++)
            (i[A[s]] = u[s].offsetWidth), (a[A[s]] = u[s].offsetHeight);
          return P.filter(function (e) {
            return (
              (t = l[e]),
              A.some(function (e, n) {
                return t[n].offsetWidth !== i[e] || t[n].offsetHeight !== a[e];
              })
            );
            var t;
          });
        });
      },
      domBlockers: function (e) {
        var t = (void 0 === e ? {} : e).debug;
        return o(this, void 0, void 0, function () {
          var e, n, r, o, a;
          return i(this, function (i) {
            switch (i.label) {
              case 0:
                return x() || X()
                  ? ((c = atob),
                    (e = {
                      abpIndo: [
                        "#Iklan-Melayang",
                        "#Kolom-Iklan-728",
                        "#SidebarIklan-wrapper",
                        c("YVt0aXRsZT0iN25hZ2EgcG9rZXIiIGld"),
                        '[title="ALIENBOLA" i]',
                      ],
                      abpvn: [
                        "#quangcaomb",
                        c("Lmlvc0Fkc2lvc0Fkcy1sYXlvdXQ="),
                        ".quangcao",
                        c("W2hyZWZePSJodHRwczovL3I4OC52bi8iXQ=="),
                        c("W2hyZWZePSJodHRwczovL3piZXQudm4vIl0="),
                      ],
                      adBlockFinland: [
                        ".mainostila",
                        c("LnNwb25zb3JpdA=="),
                        ".ylamainos",
                        c("YVtocmVmKj0iL2NsaWNrdGhyZ2guYXNwPyJd"),
                        c(
                          "YVtocmVmXj0iaHR0cHM6Ly9hcHAucmVhZHBlYWsuY29tL2FkcyJd"
                        ),
                      ],
                      adBlockPersian: [
                        "#navbar_notice_50",
                        ".kadr",
                        'TABLE[width="140px"]',
                        "#divAgahi",
                        c("I2FkMl9pbmxpbmU="),
                      ],
                      adBlockWarningRemoval: [
                        "#adblock-honeypot",
                        ".adblocker-root",
                        ".wp_adblock_detect",
                        c("LmhlYWRlci1ibG9ja2VkLWFk"),
                        c("I2FkX2Jsb2NrZXI="),
                      ],
                      adGuardAnnoyances: [
                        'amp-embed[type="zen"]',
                        ".hs-sosyal",
                        "#cookieconsentdiv",
                        'div[class^="app_gdpr"]',
                        ".as-oil",
                      ],
                      adGuardBase: [
                        ".BetterJsPopOverlay",
                        c("I2FkXzMwMFgyNTA="),
                        c("I2Jhbm5lcmZsb2F0MjI="),
                        c("I2FkLWJhbm5lcg=="),
                        c("I2NhbXBhaWduLWJhbm5lcg=="),
                      ],
                      adGuardChinese: [
                        c("LlppX2FkX2FfSA=="),
                        c("YVtocmVmKj0iL29kMDA1LmNvbSJd"),
                        c("YVtocmVmKj0iLmh0aGJldDM0LmNvbSJd"),
                        ".qq_nr_lad",
                        "#widget-quan",
                      ],
                      adGuardFrench: [
                        c("I2Jsb2NrLXZpZXdzLWFkcy1zaWRlYmFyLWJsb2NrLWJsb2Nr"),
                        "#pavePub",
                        c("LmFkLWRlc2t0b3AtcmVjdGFuZ2xl"),
                        ".mobile_adhesion",
                        ".widgetadv",
                      ],
                      adGuardGerman: [
                        c("LmJhbm5lcml0ZW13ZXJidW5nX2hlYWRfMQ=="),
                        c("LmJveHN0YXJ0d2VyYnVuZw=="),
                        c("LndlcmJ1bmcz"),
                        c(
                          "YVtocmVmXj0iaHR0cDovL3d3dy5laXMuZGUvaW5kZXgucGh0bWw/cmVmaWQ9Il0="
                        ),
                        c(
                          "YVtocmVmXj0iaHR0cHM6Ly93d3cudGlwaWNvLmNvbS8/YWZmaWxpYXRlSWQ9Il0="
                        ),
                      ],
                      adGuardJapanese: [
                        "#kauli_yad_1",
                        c(
                          "YVtocmVmXj0iaHR0cDovL2FkMi50cmFmZmljZ2F0ZS5uZXQvIl0="
                        ),
                        c("Ll9wb3BJbl9pbmZpbml0ZV9hZA=="),
                        c("LmFkZ29vZ2xl"),
                        c("LmFkX3JlZ3VsYXIz"),
                      ],
                      adGuardMobile: [
                        c("YW1wLWF1dG8tYWRz"),
                        c("LmFtcF9hZA=="),
                        'amp-embed[type="24smi"]',
                        "#mgid_iframe1",
                        c("I2FkX2ludmlld19hcmVh"),
                      ],
                      adGuardRussian: [
                        c("YVtocmVmXj0iaHR0cHM6Ly9hZC5sZXRtZWFkcy5jb20vIl0="),
                        c("LnJlY2xhbWE="),
                        'div[id^="smi2adblock"]',
                        c("ZGl2W2lkXj0iQWRGb3hfYmFubmVyXyJd"),
                        c("I2FkX3NxdWFyZQ=="),
                      ],
                      adGuardSocial: [
                        c(
                          "YVtocmVmXj0iLy93d3cuc3R1bWJsZXVwb24uY29tL3N1Ym1pdD91cmw9Il0="
                        ),
                        c("YVtocmVmXj0iLy90ZWxlZ3JhbS5tZS9zaGFyZS91cmw/Il0="),
                        ".etsy-tweet",
                        "#inlineShare",
                        ".popup-social",
                      ],
                      adGuardSpanishPortuguese: [
                        "#barraPublicidade",
                        "#Publicidade",
                        "#publiEspecial",
                        "#queTooltip",
                        c("W2hyZWZePSJodHRwOi8vYWRzLmdsaXNwYS5jb20vIl0="),
                      ],
                      adGuardTrackingProtection: [
                        "#qoo-counter",
                        c("YVtocmVmXj0iaHR0cDovL2NsaWNrLmhvdGxvZy5ydS8iXQ=="),
                        c(
                          "YVtocmVmXj0iaHR0cDovL2hpdGNvdW50ZXIucnUvdG9wL3N0YXQucGhwIl0="
                        ),
                        c("YVtocmVmXj0iaHR0cDovL3RvcC5tYWlsLnJ1L2p1bXAiXQ=="),
                        "#top100counter",
                      ],
                      adGuardTurkish: [
                        "#backkapat",
                        c("I3Jla2xhbWk="),
                        c(
                          "YVtocmVmXj0iaHR0cDovL2Fkc2Vydi5vbnRlay5jb20udHIvIl0="
                        ),
                        c(
                          "YVtocmVmXj0iaHR0cDovL2l6bGVuemkuY29tL2NhbXBhaWduLyJd"
                        ),
                        c(
                          "YVtocmVmXj0iaHR0cDovL3d3dy5pbnN0YWxsYWRzLm5ldC8iXQ=="
                        ),
                      ],
                      bulgarian: [
                        c("dGQjZnJlZW5ldF90YWJsZV9hZHM="),
                        "#ea_intext_div",
                        ".lapni-pop-over",
                        "#xenium_hot_offers",
                        c("I25ld0Fk"),
                      ],
                      easyList: [
                        c("I0FEX0NPTlRST0xfMjg="),
                        c("LnNlY29uZC1wb3N0LWFkcy13cmFwcGVy"),
                        ".universalboxADVBOX03",
                        c("LmFkdmVydGlzZW1lbnQtNzI4eDkw"),
                        c("LnNxdWFyZV9hZHM="),
                      ],
                      easyListChina: [
                        c("YVtocmVmKj0iLndlbnNpeHVldGFuZy5jb20vIl0="),
                        c(
                          "LmFwcGd1aWRlLXdyYXBbb25jbGljayo9ImJjZWJvcy5jb20iXQ=="
                        ),
                        c("LmZyb250cGFnZUFkdk0="),
                        "#taotaole",
                        "#aafoot.top_box",
                      ],
                      easyListCookie: [
                        "#AdaCompliance.app-notice",
                        ".text-center.rgpd",
                        ".panel--cookie",
                        ".js-cookies-andromeda",
                        ".elxtr-consent",
                      ],
                      easyListCzechSlovak: [
                        "#onlajny-stickers",
                        c("I3Jla2xhbW5pLWJveA=="),
                        c("LnJla2xhbWEtbWVnYWJvYXJk"),
                        ".sklik",
                        c("W2lkXj0ic2tsaWtSZWtsYW1hIl0="),
                      ],
                      easyListDutch: [
                        c("I2FkdmVydGVudGll"),
                        c("I3ZpcEFkbWFya3RCYW5uZXJCbG9jaw=="),
                        ".adstekst",
                        c("YVtocmVmXj0iaHR0cHM6Ly94bHR1YmUubmwvY2xpY2svIl0="),
                        "#semilo-lrectangle",
                      ],
                      easyListGermany: [
                        c("I0FkX1dpbjJkYXk="),
                        c("I3dlcmJ1bmdzYm94MzAw"),
                        c(
                          "YVtocmVmXj0iaHR0cDovL3d3dy5yb3RsaWNodGthcnRlaS5jb20vP3NjPSJd"
                        ),
                        c("I3dlcmJ1bmdfd2lkZXNreXNjcmFwZXJfc2NyZWVu"),
                        c(
                          "YVtocmVmXj0iaHR0cDovL2xhbmRpbmcucGFya3BsYXR6a2FydGVpLmNvbS8/YWc9Il0="
                        ),
                      ],
                      easyListItaly: [
                        c("LmJveF9hZHZfYW5udW5jaQ=="),
                        ".sb-box-pubbliredazionale",
                        c(
                          "YVtocmVmXj0iaHR0cDovL2FmZmlsaWF6aW9uaWFkcy5zbmFpLml0LyJd"
                        ),
                        c("YVtocmVmXj0iaHR0cHM6Ly9hZHNlcnZlci5odG1sLml0LyJd"),
                        c(
                          "YVtocmVmXj0iaHR0cHM6Ly9hZmZpbGlhemlvbmlhZHMuc25haS5pdC8iXQ=="
                        ),
                      ],
                      easyListLithuania: [
                        c("LnJla2xhbW9zX3RhcnBhcw=="),
                        c("LnJla2xhbW9zX251b3JvZG9z"),
                        c("aW1nW2FsdD0iUmVrbGFtaW5pcyBza3lkZWxpcyJd"),
                        c("aW1nW2FsdD0iRGVkaWt1b3RpLmx0IHNlcnZlcmlhaSJd"),
                        c("aW1nW2FsdD0iSG9zdGluZ2FzIFNlcnZlcmlhaS5sdCJd"),
                      ],
                      estonian: [
                        c("QVtocmVmKj0iaHR0cDovL3BheTRyZXN1bHRzMjQuZXUiXQ=="),
                      ],
                      fanboyAnnoyances: [
                        "#feedback-tab",
                        "#taboola-below-article",
                        ".feedburnerFeedBlock",
                        ".widget-feedburner-counter",
                        '[title="Subscribe to our blog"]',
                      ],
                      fanboyAntiFacebook: [".util-bar-module-firefly-visible"],
                      fanboyEnhancedTrackers: [
                        ".open.pushModal",
                        "#issuem-leaky-paywall-articles-zero-remaining-nag",
                        "#sovrn_container",
                        'div[class$="-hide"][zoompage-fontsize][style="display: block;"]',
                        ".BlockNag__Card",
                      ],
                      fanboySocial: [
                        ".td-tags-and-social-wrapper-box",
                        ".twitterContainer",
                        ".youtube-social",
                        'a[title^="Like us on Facebook"]',
                        'img[alt^="Share on Digg"]',
                      ],
                      frellwitSwedish: [
                        c(
                          "YVtocmVmKj0iY2FzaW5vcHJvLnNlIl1bdGFyZ2V0PSJfYmxhbmsiXQ=="
                        ),
                        c("YVtocmVmKj0iZG9rdG9yLXNlLm9uZWxpbmsubWUiXQ=="),
                        "article.category-samarbete",
                        c("ZGl2LmhvbGlkQWRz"),
                        "ul.adsmodern",
                      ],
                      greekAdBlock: [
                        c("QVtocmVmKj0iYWRtYW4ub3RlbmV0LmdyL2NsaWNrPyJd"),
                        c(
                          "QVtocmVmKj0iaHR0cDovL2F4aWFiYW5uZXJzLmV4b2R1cy5nci8iXQ=="
                        ),
                        c(
                          "QVtocmVmKj0iaHR0cDovL2ludGVyYWN0aXZlLmZvcnRobmV0LmdyL2NsaWNrPyJd"
                        ),
                        "DIV.agores300",
                        "TABLE.advright",
                      ],
                      hungarian: [
                        "#cemp_doboz",
                        ".optimonk-iframe-container",
                        c("LmFkX19tYWlu"),
                        c("W2NsYXNzKj0iR29vZ2xlQWRzIl0="),
                        "#hirdetesek_box",
                      ],
                      iDontCareAboutCookies: [
                        '.alert-info[data-block-track*="CookieNotice"]',
                        ".ModuleTemplateCookieIndicator",
                        ".o--cookies--container",
                        ".cookie-msg-info-container",
                        "#cookies-policy-sticky",
                      ],
                      icelandicAbp: [
                        c(
                          "QVtocmVmXj0iL2ZyYW1ld29yay9yZXNvdXJjZXMvZm9ybXMvYWRzLmFzcHgiXQ=="
                        ),
                      ],
                      latvian: [
                        c(
                          "YVtocmVmPSJodHRwOi8vd3d3LnNhbGlkemluaS5sdi8iXVtzdHlsZT0iZGlzcGxheTogYmxvY2s7IHdpZHRoOiAxMjBweDsgaGVpZ2h0OiA0MHB4OyBvdmVyZmxvdzogaGlkZGVuOyBwb3NpdGlvbjogcmVsYXRpdmU7Il0="
                        ),
                        c(
                          "YVtocmVmPSJodHRwOi8vd3d3LnNhbGlkemluaS5sdi8iXVtzdHlsZT0iZGlzcGxheTogYmxvY2s7IHdpZHRoOiA4OHB4OyBoZWlnaHQ6IDMxcHg7IG92ZXJmbG93OiBoaWRkZW47IHBvc2l0aW9uOiByZWxhdGl2ZTsiXQ=="
                        ),
                      ],
                      listKr: [
                        c("YVtocmVmKj0iLy9hZC5wbGFuYnBsdXMuY28ua3IvIl0="),
                        c("I2xpdmVyZUFkV3JhcHBlcg=="),
                        c("YVtocmVmKj0iLy9hZHYuaW1hZHJlcC5jby5rci8iXQ=="),
                        c("aW5zLmZhc3R2aWV3LWFk"),
                        ".revenue_unit_item.dable",
                      ],
                      listeAr: [
                        c("LmdlbWluaUxCMUFk"),
                        ".right-and-left-sponsers",
                        c("YVtocmVmKj0iLmFmbGFtLmluZm8iXQ=="),
                        c("YVtocmVmKj0iYm9vcmFxLm9yZyJd"),
                        c(
                          "YVtocmVmKj0iZHViaXp6bGUuY29tL2FyLz91dG1fc291cmNlPSJd"
                        ),
                      ],
                      listeFr: [
                        c("YVtocmVmXj0iaHR0cDovL3Byb21vLnZhZG9yLmNvbS8iXQ=="),
                        c("I2FkY29udGFpbmVyX3JlY2hlcmNoZQ=="),
                        c("YVtocmVmKj0id2Vib3JhbWEuZnIvZmNnaS1iaW4vIl0="),
                        ".site-pub-interstitiel",
                        'div[id^="crt-"][data-criteo-id]',
                      ],
                      officialPolish: [
                        "#ceneo-placeholder-ceneo-12",
                        c("W2hyZWZePSJodHRwczovL2FmZi5zZW5kaHViLnBsLyJd"),
                        c(
                          "YVtocmVmXj0iaHR0cDovL2Fkdm1hbmFnZXIudGVjaGZ1bi5wbC9yZWRpcmVjdC8iXQ=="
                        ),
                        c(
                          "YVtocmVmXj0iaHR0cDovL3d3dy50cml6ZXIucGwvP3V0bV9zb3VyY2UiXQ=="
                        ),
                        c("ZGl2I3NrYXBpZWNfYWQ="),
                      ],
                      ro: [
                        c(
                          "YVtocmVmXj0iLy9hZmZ0cmsuYWx0ZXgucm8vQ291bnRlci9DbGljayJd"
                        ),
                        'a[href^="/magazin/"]',
                        c(
                          "YVtocmVmXj0iaHR0cHM6Ly9ibGFja2ZyaWRheXNhbGVzLnJvL3Ryay9zaG9wLyJd"
                        ),
                        c(
                          "YVtocmVmXj0iaHR0cHM6Ly9ldmVudC4ycGVyZm9ybWFudC5jb20vZXZlbnRzL2NsaWNrIl0="
                        ),
                        c("YVtocmVmXj0iaHR0cHM6Ly9sLnByb2ZpdHNoYXJlLnJvLyJd"),
                      ],
                      ruAd: [
                        c("YVtocmVmKj0iLy9mZWJyYXJlLnJ1LyJd"),
                        c("YVtocmVmKj0iLy91dGltZy5ydS8iXQ=="),
                        c("YVtocmVmKj0iOi8vY2hpa2lkaWtpLnJ1Il0="),
                        "#pgeldiz",
                        ".yandex-rtb-block",
                      ],
                      thaiAds: [
                        "a[href*=macau-uta-popup]",
                        c("I2Fkcy1nb29nbGUtbWlkZGxlX3JlY3RhbmdsZS1ncm91cA=="),
                        c("LmFkczMwMHM="),
                        ".bumq",
                        ".img-kosana",
                      ],
                      webAnnoyancesUltralist: [
                        "#mod-social-share-2",
                        "#social-tools",
                        c("LmN0cGwtZnVsbGJhbm5lcg=="),
                        ".zergnet-recommend",
                        ".yt.btn-link.btn-md.btn",
                      ],
                    }),
                    (n = Object.keys(e)),
                    [
                      4,
                      O(
                        (a = []).concat.apply(
                          a,
                          n.map(function (t) {
                            return e[t];
                          })
                        )
                      ),
                    ])
                  : [2, void 0];
              case 1:
                return (
                  (r = i.sent()),
                  t &&
                    (function (e, t) {
                      for (
                        var n = "DOM blockers debug:\n```",
                          r = 0,
                          o = Object.keys(e);
                        r < o.length;
                        r++
                      ) {
                        var i = o[r];
                        n += "\n" + i + ":";
                        for (var a = 0, c = e[i]; a < c.length; a++) {
                          var u = c[a];
                          n += "\n  " + (t[u] ? "🚫" : "➡️") + " " + u;
                        }
                      }
                      console.log(n + "\n```");
                    })(e, r),
                  (o = n.filter(function (t) {
                    var n = e[t];
                    return (
                      V(
                        n.map(function (e) {
                          return r[e];
                        })
                      ) >
                      0.6 * n.length
                    );
                  })).sort(),
                  [2, o]
                );
            }
            var c;
          });
        });
      },
      fontPreferences: function () {
        return (function (e, t) {
          void 0 === t && (t = 4e3);
          return Y(function (n, r) {
            var o = r.document,
              i = o.body,
              c = i.style;
            (c.width = t + "px"),
              (c.webkitTextSizeAdjust = c.textSizeAdjust = "none"),
              F()
                ? (i.style.zoom = "" + 1 / r.devicePixelRatio)
                : x() && (i.style.zoom = "reset");
            var u = o.createElement("div");
            return (
              (u.textContent = a(Array((t / 20) << 0))
                .map(function () {
                  return "word";
                })
                .join(" ")),
              i.appendChild(u),
              e(o, i)
            );
          }, '<!doctype html><html><head><meta name="viewport" content="width=device-width, initial-scale=1">');
        })(function (e, t) {
          for (
            var n = {}, r = {}, o = 0, i = Object.keys(te);
            o < i.length;
            o++
          ) {
            var a = i[o],
              c = te[a],
              u = c[0],
              l = void 0 === u ? {} : u,
              s = c[1],
              d = void 0 === s ? "mmMwWLliI0fiflO&1" : s,
              f = e.createElement("span");
            (f.textContent = d), (f.style.whiteSpace = "nowrap");
            for (var m = 0, h = Object.keys(l); m < h.length; m++) {
              var v = h[m],
                p = l[v];
              void 0 !== p && (f.style[v] = p);
            }
            (n[a] = f), t.appendChild(e.createElement("br")), t.appendChild(f);
          }
          for (var y = 0, b = Object.keys(te); y < b.length; y++) {
            r[(a = b[y])] = n[a].getBoundingClientRect().width;
          }
          return r;
        });
      },
      audio: function () {
        var e = window,
          t = e.OfflineAudioContext || e.webkitOfflineAudioContext;
        if (!t) return -2;
        if (
          x() &&
          !I() &&
          !(function () {
            var e = window;
            return (
              V([
                "DOMRectList" in e,
                "RTCPeerConnectionIceEvent" in e,
                "SVGGeometryElement" in e,
                "ontransitioncancel" in e,
              ]) >= 3
            );
          })()
        )
          return -1;
        var n = new t(1, 5e3, 44100),
          r = n.createOscillator();
        (r.type = "triangle"), (r.frequency.value = 1e4);
        var o = n.createDynamicsCompressor();
        (o.threshold.value = -50),
          (o.knee.value = 40),
          (o.ratio.value = 12),
          (o.attack.value = 0),
          (o.release.value = 0.25),
          r.connect(o),
          o.connect(n.destination),
          r.start(0);
        var i = (function (e) {
            var t = 3,
              n = 500,
              r = 500,
              o = 5e3,
              i = function () {};
            return [
              new Promise(function (a, c) {
                var u = !1,
                  l = 0,
                  s = 0;
                e.oncomplete = function (e) {
                  return a(e.renderedBuffer);
                };
                var d = function () {
                    setTimeout(function () {
                      return c(T("timeout"));
                    }, Math.min(r, s + o - Date.now()));
                  },
                  f = function () {
                    try {
                      switch ((e.startRendering(), e.state)) {
                        case "running":
                          (s = Date.now()), u && d();
                          break;
                        case "suspended":
                          document.hidden || l++,
                            u && l >= t ? c(T("suspended")) : setTimeout(f, n);
                      }
                    } catch (r) {
                      c(r);
                    }
                  };
                f(),
                  (i = function () {
                    u || ((u = !0), s > 0 && d());
                  });
              }),
              i,
            ];
          })(n),
          a = i[0],
          c = i[1],
          u = a.then(
            function (e) {
              return (function (e) {
                for (var t = 0, n = 0; n < e.length; ++n) t += Math.abs(e[n]);
                return t;
              })(e.getChannelData(0).subarray(4500));
            },
            function (e) {
              if ("timeout" === e.name || "suspended" === e.name) return -3;
              throw e;
            }
          );
        return (
          f(u),
          function () {
            return c(), u;
          }
        );
      },
      screenFrame: function () {
        var e = this,
          t = N();
        return function () {
          return o(e, void 0, void 0, function () {
            var e, n;
            return i(this, function (r) {
              switch (r.label) {
                case 0:
                  return [4, t()];
                case 1:
                  return (
                    (e = r.sent()),
                    [
                      2,
                      [
                        (n = function (e) {
                          return null === e ? null : S(e, 10);
                        })(e[0]),
                        n(e[1]),
                        n(e[2]),
                        n(e[3]),
                      ],
                    ]
                  );
              }
            });
          });
        };
      },
      osCpu: function () {
        return navigator.oscpu;
      },
      languages: function () {
        var e,
          t = navigator,
          n = [],
          r =
            t.language ||
            t.userLanguage ||
            t.browserLanguage ||
            t.systemLanguage;
        if ((void 0 !== r && n.push([r]), Array.isArray(t.languages)))
          (F() &&
            V([
              !("MediaSettingsRange" in (e = window)),
              "RTCEncodedAudioFrame" in e,
              "" + e.Intl == "[object Intl]",
              "" + e.Reflect == "[object Reflect]",
            ]) >= 3) ||
            n.push(t.languages);
        else if ("string" == typeof t.languages) {
          var o = t.languages;
          o && n.push(o.split(","));
        }
        return n;
      },
      colorDepth: function () {
        return window.screen.colorDepth;
      },
      deviceMemory: function () {
        return k(L(navigator.deviceMemory), void 0);
      },
      screenResolution: function () {
        var e = screen,
          t = function (e) {
            return k(w(e), null);
          },
          n = [t(e.width), t(e.height)];
        return n.sort().reverse(), n;
      },
      hardwareConcurrency: function () {
        return k(w(navigator.hardwareConcurrency), void 0);
      },
      timezone: function () {
        var e,
          t =
            null === (e = window.Intl) || void 0 === e
              ? void 0
              : e.DateTimeFormat;
        if (t) {
          var n = new t().resolvedOptions().timeZone;
          if (n) return n;
        }
        var r,
          o =
            ((r = new Date().getFullYear()),
            -Math.max(
              L(new Date(r, 0, 1).getTimezoneOffset()),
              L(new Date(r, 6, 1).getTimezoneOffset())
            ));
        return "UTC" + (o >= 0 ? "+" : "") + Math.abs(o);
      },
      sessionStorage: function () {
        try {
          return !!window.sessionStorage;
        } catch (e) {
          return !0;
        }
      },
      localStorage: function () {
        try {
          return !!window.localStorage;
        } catch (e) {
          return !0;
        }
      },
      indexedDB: function () {
        var e, t;
        if (
          !(
            j() ||
            ((e = window),
            (t = navigator),
            V([
              "msWriteProfilerMark" in e,
              "MSStream" in e,
              "msLaunchUri" in t,
              "msSaveBlob" in t,
            ]) >= 3 && !j())
          )
        )
          try {
            return !!window.indexedDB;
          } catch (n) {
            return !0;
          }
      },
      openDatabase: function () {
        return !!window.openDatabase;
      },
      cpuClass: function () {
        return navigator.cpuClass;
      },
      platform: function () {
        var e = navigator.platform;
        return "MacIntel" === e && x() && !I()
          ? (function () {
              if ("iPad" === navigator.platform) return !0;
              var e = screen,
                t = e.width / e.height;
              return (
                V([
                  "MediaSource" in window,
                  !!Element.prototype.webkitRequestFullscreen,
                  t > 0.65 && t < 1.53,
                ]) >= 2
              );
            })()
            ? "iPad"
            : "iPhone"
          : e;
      },
      plugins: function () {
        var e = navigator.plugins;
        if (e) {
          for (var t = [], n = 0; n < e.length; ++n) {
            var r = e[n];
            if (r) {
              for (var o = [], i = 0; i < r.length; ++i) {
                var a = r[i];
                o.push({ type: a.type, suffixes: a.suffixes });
              }
              t.push({
                name: r.name,
                description: r.description,
                mimeTypes: o,
              });
            }
          }
          return t;
        }
      },
      canvas: function () {
        var e,
          t,
          n = !1,
          r = (function () {
            var e = document.createElement("canvas");
            return (e.width = 1), (e.height = 1), [e, e.getContext("2d")];
          })(),
          o = r[0],
          i = r[1];
        if (
          (function (e, t) {
            return !(!t || !e.toDataURL);
          })(o, i)
        ) {
          (n = (function (e) {
            return (
              e.rect(0, 0, 10, 10),
              e.rect(2, 2, 6, 6),
              !e.isPointInPath(5, 5, "evenodd")
            );
          })(i)),
            (function (e, t) {
              (e.width = 240),
                (e.height = 60),
                (t.textBaseline = "alphabetic"),
                (t.fillStyle = "#f60"),
                t.fillRect(100, 1, 62, 20),
                (t.fillStyle = "#069"),
                (t.font = '11pt "Times New Roman"');
              var n = "Cwm fjordbank gly " + String.fromCharCode(55357, 56835);
              t.fillText(n, 2, 15),
                (t.fillStyle = "rgba(102, 204, 0, 0.2)"),
                (t.font = "18pt Arial"),
                t.fillText(n, 4, 45);
            })(o, i);
          var a = J(o);
          a !== J(o)
            ? (e = t = "unstable")
            : ((t = a),
              (function (e, t) {
                (e.width = 122),
                  (e.height = 110),
                  (t.globalCompositeOperation = "multiply");
                for (
                  var n = 0,
                    r = [
                      ["#f2f", 40, 40],
                      ["#2ff", 80, 40],
                      ["#ff2", 60, 80],
                    ];
                  n < r.length;
                  n++
                ) {
                  var o = r[n],
                    i = o[0],
                    a = o[1],
                    c = o[2];
                  (t.fillStyle = i),
                    t.beginPath(),
                    t.arc(a, c, 40, 0, 2 * Math.PI, !0),
                    t.closePath(),
                    t.fill();
                }
                (t.fillStyle = "#f9c"),
                  t.arc(60, 60, 60, 0, 2 * Math.PI, !0),
                  t.arc(60, 60, 20, 0, 2 * Math.PI, !0),
                  t.fill("evenodd");
              })(o, i),
              (e = J(o)));
        } else e = t = "";
        return { winding: n, geometry: e, text: t };
      },
      touchSupport: function () {
        var e,
          t = navigator,
          n = 0;
        void 0 !== t.maxTouchPoints
          ? (n = w(t.maxTouchPoints))
          : void 0 !== t.msMaxTouchPoints && (n = t.msMaxTouchPoints);
        try {
          document.createEvent("TouchEvent"), (e = !0);
        } catch (r) {
          e = !1;
        }
        return {
          maxTouchPoints: n,
          touchEvent: e,
          touchStart: "ontouchstart" in window,
        };
      },
      vendor: function () {
        return navigator.vendor || "";
      },
      vendorFlavors: function () {
        for (
          var e = [],
            t = 0,
            n = [
              "chrome",
              "safari",
              "__crWeb",
              "__gCrWeb",
              "yandex",
              "__yb",
              "__ybro",
              "__firefox__",
              "__edgeTrackingPreventionStatistics",
              "webkit",
              "oprt",
              "samsungAr",
              "ucweb",
              "UCShellJava",
              "puffinDevice",
            ];
          t < n.length;
          t++
        ) {
          var r = n[t],
            o = window[r];
          o && "object" == typeof o && e.push(r);
        }
        return e.sort();
      },
      cookiesEnabled: function () {
        var e = document;
        try {
          e.cookie = "cookietest=1; SameSite=Strict;";
          var t = -1 !== e.cookie.indexOf("cookietest=");
          return (
            (e.cookie =
              "cookietest=1; SameSite=Strict; expires=Thu, 01-Jan-1970 00:00:01 GMT"),
            t
          );
        } catch (n) {
          return !1;
        }
      },
      colorGamut: function () {
        for (var e = 0, t = ["rec2020", "p3", "srgb"]; e < t.length; e++) {
          var n = t[e];
          if (matchMedia("(color-gamut: " + n + ")").matches) return n;
        }
      },
      invertedColors: function () {
        return !!B("inverted") || (!B("none") && void 0);
      },
      forcedColors: function () {
        return !!Q("active") || (!Q("none") && void 0);
      },
      monochrome: function () {
        if (matchMedia("(min-monochrome: 0)").matches) {
          for (var e = 0; e <= 100; ++e)
            if (matchMedia("(max-monochrome: " + e + ")").matches) return e;
          throw new Error("Too high value");
        }
      },
      contrast: function () {
        return U("no-preference")
          ? 0
          : U("high") || U("more")
          ? 1
          : U("low") || U("less")
          ? -1
          : U("forced")
          ? 10
          : void 0;
      },
      reducedMotion: function () {
        return !!K("reduce") || (!K("no-preference") && void 0);
      },
      hdr: function () {
        return !!q("high") || (!q("standard") && void 0);
      },
      math: function () {
        var e,
          t = $.acos || ee,
          n = $.acosh || ee,
          r = $.asin || ee,
          o = $.asinh || ee,
          i = $.atanh || ee,
          a = $.atan || ee,
          c = $.sin || ee,
          u = $.sinh || ee,
          l = $.cos || ee,
          s = $.cosh || ee,
          d = $.tan || ee,
          f = $.tanh || ee,
          m = $.exp || ee,
          h = $.expm1 || ee,
          v = $.log1p || ee;
        return {
          acos: t(0.12312423423423424),
          acosh: n(1e308),
          acoshPf: ((e = 1e154), $.log(e + $.sqrt(e * e - 1))),
          asin: r(0.12312423423423424),
          asinh: o(1),
          asinhPf: (function (e) {
            return $.log(e + $.sqrt(e * e + 1));
          })(1),
          atanh: i(0.5),
          atanhPf: (function (e) {
            return $.log((1 + e) / (1 - e)) / 2;
          })(0.5),
          atan: a(0.5),
          sin: c(-1e300),
          sinh: u(1),
          sinhPf: (function (e) {
            return $.exp(e) - 1 / $.exp(e) / 2;
          })(1),
          cos: l(10.000000000123),
          cosh: s(1),
          coshPf: (function (e) {
            return ($.exp(e) + 1 / $.exp(e)) / 2;
          })(1),
          tan: d(-1e300),
          tanh: f(1),
          tanhPf: (function (e) {
            return ($.exp(2 * e) - 1) / ($.exp(2 * e) + 1);
          })(1),
          exp: m(1),
          expm1: h(1),
          expm1Pf: (function (e) {
            return $.exp(e) - 1;
          })(1),
          log1p: v(10),
          log1pPf: (function (e) {
            return $.log(1 + e);
          })(10),
          powPI: (function (e) {
            return $.pow($.PI, e);
          })(-100),
        };
      },
    };
    function re(e) {
      var t = (function (e) {
          if (X()) return 0.4;
          if (x()) return I() ? 0.5 : 0.3;
          var t = e.platform.value || "";
          if (/^Win/.test(t)) return 0.6;
          if (/^Mac/.test(t)) return 0.5;
          return 0.7;
        })(e),
        n = (function (e) {
          return S(0.99 + 0.01 * e, 1e-4);
        })(t);
      return {
        score: t,
        comment: "$ if upgrade to Pro: https://fpjs.dev/pro".replace(
          /\$/g,
          "" + n
        ),
      };
    }
    function oe(e) {
      return JSON.stringify(
        e,
        function (e, t) {
          return t instanceof Error ? g(t) : t;
        },
        2
      );
    }
    function ie(e) {
      return (function (e, t) {
        t = t || 0;
        var n,
          r = (e = e || "").length % 16,
          o = e.length - r,
          i = [0, t],
          a = [0, t],
          c = [0, 0],
          u = [0, 0],
          l = [2277735313, 289559509],
          s = [1291169091, 658871167];
        for (n = 0; n < o; n += 16)
          (c = [
            (255 & e.charCodeAt(n + 4)) |
              ((255 & e.charCodeAt(n + 5)) << 8) |
              ((255 & e.charCodeAt(n + 6)) << 16) |
              ((255 & e.charCodeAt(n + 7)) << 24),
            (255 & e.charCodeAt(n)) |
              ((255 & e.charCodeAt(n + 1)) << 8) |
              ((255 & e.charCodeAt(n + 2)) << 16) |
              ((255 & e.charCodeAt(n + 3)) << 24),
          ]),
            (u = [
              (255 & e.charCodeAt(n + 12)) |
                ((255 & e.charCodeAt(n + 13)) << 8) |
                ((255 & e.charCodeAt(n + 14)) << 16) |
                ((255 & e.charCodeAt(n + 15)) << 24),
              (255 & e.charCodeAt(n + 8)) |
                ((255 & e.charCodeAt(n + 9)) << 8) |
                ((255 & e.charCodeAt(n + 10)) << 16) |
                ((255 & e.charCodeAt(n + 11)) << 24),
            ]),
            (c = v((c = h(c, l)), 31)),
            (i = m((i = v((i = y(i, (c = h(c, s)))), 27)), a)),
            (i = m(h(i, [0, 5]), [0, 1390208809])),
            (u = v((u = h(u, s)), 33)),
            (a = m((a = v((a = y(a, (u = h(u, l)))), 31)), i)),
            (a = m(h(a, [0, 5]), [0, 944331445]));
        switch (((c = [0, 0]), (u = [0, 0]), r)) {
          case 15:
            u = y(u, p([0, e.charCodeAt(n + 14)], 48));
          case 14:
            u = y(u, p([0, e.charCodeAt(n + 13)], 40));
          case 13:
            u = y(u, p([0, e.charCodeAt(n + 12)], 32));
          case 12:
            u = y(u, p([0, e.charCodeAt(n + 11)], 24));
          case 11:
            u = y(u, p([0, e.charCodeAt(n + 10)], 16));
          case 10:
            u = y(u, p([0, e.charCodeAt(n + 9)], 8));
          case 9:
            (u = h((u = y(u, [0, e.charCodeAt(n + 8)])), s)),
              (a = y(a, (u = h((u = v(u, 33)), l))));
          case 8:
            c = y(c, p([0, e.charCodeAt(n + 7)], 56));
          case 7:
            c = y(c, p([0, e.charCodeAt(n + 6)], 48));
          case 6:
            c = y(c, p([0, e.charCodeAt(n + 5)], 40));
          case 5:
            c = y(c, p([0, e.charCodeAt(n + 4)], 32));
          case 4:
            c = y(c, p([0, e.charCodeAt(n + 3)], 24));
          case 3:
            c = y(c, p([0, e.charCodeAt(n + 2)], 16));
          case 2:
            c = y(c, p([0, e.charCodeAt(n + 1)], 8));
          case 1:
            (c = h((c = y(c, [0, e.charCodeAt(n)])), l)),
              (i = y(i, (c = h((c = v(c, 31)), s))));
        }
        return (
          (i = m((i = y(i, [0, e.length])), (a = y(a, [0, e.length])))),
          (a = m(a, i)),
          (i = m((i = b(i)), (a = b(a)))),
          (a = m(a, i)),
          ("00000000" + (i[0] >>> 0).toString(16)).slice(-8) +
            ("00000000" + (i[1] >>> 0).toString(16)).slice(-8) +
            ("00000000" + (a[0] >>> 0).toString(16)).slice(-8) +
            ("00000000" + (a[1] >>> 0).toString(16)).slice(-8)
        );
      })(
        (function (e) {
          for (
            var t = "", n = 0, r = Object.keys(e).sort();
            n < r.length;
            n++
          ) {
            var o = r[n],
              i = e[o],
              a = i.error ? "error" : JSON.stringify(i.value);
            t += (t ? "|" : "") + o.replace(/([:|\\])/g, "\\$1") + ":" + a;
          }
          return t;
        })(e)
      );
    }
    function ae(e) {
      return (
        void 0 === e && (e = 50),
        (function (e, t) {
          void 0 === t && (t = 1 / 0);
          var n = window.requestIdleCallback;
          return n
            ? new Promise(function (e) {
                return n.call(
                  window,
                  function () {
                    return e();
                  },
                  { timeout: t }
                );
              })
            : u(Math.min(e, t));
        })(e, 2 * e)
      );
    }
    function ce(e, t) {
      var n = Date.now();
      return {
        get: function (r) {
          return o(this, void 0, void 0, function () {
            var o, a, u;
            return i(this, function (i) {
              switch (i.label) {
                case 0:
                  return (o = Date.now()), [4, e()];
                case 1:
                  return (
                    (a = i.sent()),
                    (u = (function (e) {
                      var t;
                      return {
                        get visitorId() {
                          return void 0 === t && (t = ie(this.components)), t;
                        },
                        set visitorId(e) {
                          t = e;
                        },
                        confidence: re(e),
                        components: e,
                        version: c.a,
                      };
                    })(a)),
                    (t || (null == r ? void 0 : r.debug)) &&
                      console.log(
                        "Copy the text below to get the debug data:\n\n```\nversion: " +
                          u.version +
                          "\nuserAgent: " +
                          navigator.userAgent +
                          "\ntimeBetweenLoadAndGet: " +
                          (o - n) +
                          "\nvisitorId: " +
                          u.visitorId +
                          "\ncomponents: " +
                          oe(a) +
                          "\n```"
                      ),
                    [2, u]
                  );
              }
            });
          });
        },
      };
    }
    function ue(e) {
      var t = void 0 === e ? {} : e,
        n = t.delayFallback,
        r = t.debug,
        a = t.monitoring,
        u = void 0 === a || a;
      return o(this, void 0, void 0, function () {
        return i(this, function (e) {
          switch (e.label) {
            case 0:
              return (
                u &&
                  (function () {
                    if (!(window.__fpjs_d_m || Math.random() >= 0.001))
                      try {
                        var e = new XMLHttpRequest();
                        e.open(
                          "get",
                          "https://m1.openfpcdn.io/fingerprintjs/v" +
                            c.a +
                            "/npm-monitoring",
                          !0
                        ),
                          e.send();
                      } catch (t) {
                        console.error(t);
                      }
                  })(),
                [4, ae(n)]
              );
            case 1:
              return e.sent(), [2, ce(C(ne, { debug: r }, []), r)];
          }
        });
      });
    }
    function le() {
      return o(this, void 0, void 0, function () {
        return i(this, function (e) {
          switch (e.label) {
            case 0:
              return [4, ue({ debug: !0 })];
            case 1:
              return [4, e.sent().get()];
            case 2:
              return [2, e.sent()];
          }
        });
      });
    }
    function se(e) {
      var t = e.output,
        n = e.header,
        r = e.content,
        o = e.comment,
        i = e.size,
        a = document.createElement("div");
      a.appendChild(fe(n)), a.classList.add("heading"), t.appendChild(a);
      var c = document.createElement("pre");
      if (
        (c.appendChild(fe(r)), i && c.classList.add(i), t.appendChild(c), o)
      ) {
        var u = document.createElement("div");
        u.appendChild(fe(o)), u.classList.add("comment"), t.appendChild(u);
      }
    }
    function de(e) {
      var t = document.querySelector("#debugCopy");
      t instanceof HTMLButtonElement &&
        ((t.disabled = !1),
        t.addEventListener("click", function (t) {
          t.preventDefault(),
            (function (e) {
              var t = document.createElement("textarea");
              (t.value = e),
                document.body.appendChild(t),
                t.focus(),
                t.select();
              try {
                document.execCommand("copy");
              } catch (n) {}
              document.body.removeChild(t);
            })(e);
        }));
      var n = document.querySelector("#debugShare");
      n instanceof HTMLButtonElement &&
        ((n.disabled = !1),
        n.addEventListener("click", function (t) {
          t.preventDefault(),
            (function (e) {
              o(this, void 0, void 0, function () {
                return i(this, function (t) {
                  switch (t.label) {
                    case 0:
                      if (!navigator.share)
                        return (
                          alert(
                            "Sharing is unavailable.\n\nSharing is available in mobile browsers and only on HTTPS websites. " +
                              ("https:" === location.protocol
                                ? "Use a mobile device or the Copy button instead."
                                : "Open https://" +
                                  location.host +
                                  location.pathname +
                                  location.search +
                                  " instead.")
                          ),
                          [2]
                        );
                      t.label = 1;
                    case 1:
                      return (
                        t.trys.push([1, 3, , 4]),
                        [4, navigator.share({ text: e })]
                      );
                    case 2:
                      return t.sent(), [3, 4];
                    case 3:
                      return t.sent(), [3, 4];
                    case 4:
                      return [2];
                  }
                });
              });
            })(e);
        }));
    }
    function fe(e) {
      if ("string" == typeof e) return document.createTextNode(e);
      var t = document.createElement("div");
      t.innerHTML = e.html;
      for (var n = document.createDocumentFragment(); t.firstChild; )
        n.appendChild(t.firstChild);
      return n;
    }
    !(function () {
      o(this, void 0, void 0, function () {
        var e, t, n, r, o, a, c, u, l;
        return i(this, function (i) {
          switch (i.label) {
            case 0:
              if (!(e = document.querySelector(".output")))
                throw new Error(
                  "The output element isn't found in the HTML code"
                );
              (t = Date.now()), (i.label = 1);
            case 1:
              return i.trys.push([1, 3, , 4]), [4, le()];
            case 2:
              return (
                (n = i.sent()),
                (r = n.visitorId),
                (o = n.confidence),
                (a = n.components),
                (u = Date.now() - t),
                (e.innerHTML = ""),
                se({
                  output: e,
                  header: "Visitor identifier:",
                  content: r,
                  size: "giant",
                }),
                se({
                  output: e,
                  header: "Time took to get the identifier:",
                  content: u + "ms",
                  size: "big",
                }),
                se({
                  output: e,
                  header: "Confidence score:",
                  content: String(o.score),
                  comment: o.comment && {
                    html: o.comment.replace(
                      /(upgrade\s+to\s+)?pro(\s+version)?(:\s+(https?:\/\/\S+))?/gi,
                      '<a href="$4" target="_blank">$&</a>'
                    ),
                  },
                  size: "big",
                }),
                se({
                  output: e,
                  header: "User agent:",
                  content: navigator.userAgent,
                }),
                se({
                  output: e,
                  header: "Entropy components:",
                  content: oe(a),
                }),
                de(
                  "Visitor identifier: `" +
                    r +
                    "`\nTime took to get the identifier: " +
                    u +
                    "ms\nConfidence: " +
                    JSON.stringify(o) +
                    "\nUser agent: `" +
                    navigator.userAgent +
                    "`\nEntropy components:\n```\n" +
                    oe(a) +
                    "\n```"
                ),
                [3, 4]
              );
            case 3:
              throw (
                ((c = i.sent()),
                (u = Date.now() - t),
                (l = g(c)),
                (e.innerHTML = ""),
                se({
                  output: e,
                  header: "Unexpected error:",
                  content: JSON.stringify(l, null, 2),
                }),
                se({
                  output: e,
                  header: "Time passed before the error:",
                  content: u + "ms",
                  size: "big",
                }),
                se({
                  output: e,
                  header: "User agent:",
                  content: navigator.userAgent,
                }),
                de(
                  "Unexpected error:\n\n```\n" +
                    JSON.stringify(l, null, 2) +
                    "\n```\nTime passed before the error: " +
                    u +
                    "ms\nUser agent: `" +
                    navigator.userAgent +
                    "`"
                ),
                c)
              );
            case 4:
              return [2];
          }
        });
      });
    })();
  },
]);
//# sourceMappingURL=main.js.map?0dcac13863e60a092fdb
