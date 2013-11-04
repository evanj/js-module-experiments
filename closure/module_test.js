goog.require('namespace.module');

describe('module', function() {
  describe('#exported()', function() {
    it('adds', function() {
      namespace.module.exported().should.equal(31);
    });
  });
});
