var should = should || require('should');

var namespace = namespace || {};
namespace.module = require('./module');

describe('module', function() {
  describe('#exported()', function() {
    it('adds', function() {
      namespace.module.exported().should.equal(31);
    });
  });
});
