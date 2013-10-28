var namespace = namespace || {};
namespace.module = namespace.module || require('./module');
// should is magic because it messes with Object.prototype, so we can't use the
// var module = module || require('module') trick
if (!Object.prototype.should) {
  require('should');
}

describe('module', function() {
  describe('#exported()', function() {
    it('adds', function() {
      namespace.module.exported().should.equal(31);
    });
  });
});
