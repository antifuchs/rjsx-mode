;;; flow-tests.el --- Tests for rjsx-mode's flow type annotations.    -*- lexical-binding: t -*-

(load-file "./rjsx-tests.el")
(require 'rjsx-mode)
(require 'cl-lib)
(require 'ert)

(cl-defmacro js2-flow-deftest-parse (name code-string &key bind syntax-error errors-count
                                     warnings-count)
  "Parse a flow-ed string."
  (declare (indent defun))
  `(ert-deftest ,(intern (format "js2-%s" name)) ()
     (let ,(append bind '((js2-basic-offset 2)))
       (js2-test-parse-string ,(format "// @flow\n%s" code-string)
                              :syntax-error ,syntax-error
                              :errors-count ,errors-count
                              :warnings-count ,warnings-count
                              :reference ,code-string))))

(js2-flow-deftest-parse ft-function-decl
  "function concat(a: number, b: number) {
  return a + b;
}")

(js2-flow-deftest-parse ft-const-decl
  "function concat(a: number, b) {
  const c: number = a + b;
  return c;
}")

(js2-flow-deftest-parse ft-union-types
  "function concat(a: number | string, b) {
  const c: number | string = a + b;
  return c;
}")

(js2-flow-deftest-parse ft-literal-types
  "function concat(a: \"A\", b: true | false | null | string) {
  const c: number | string = a + b;
  return c;
}")
